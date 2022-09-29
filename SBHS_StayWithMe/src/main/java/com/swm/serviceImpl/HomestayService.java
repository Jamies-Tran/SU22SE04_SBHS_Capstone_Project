package com.swm.serviceImpl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Lazy;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;

import com.swm.converter.HomestayConverter;
import com.swm.dto.distance.LocationDistanceDto;
import com.swm.dto.google.distance.matrix.DistanceMatrixResponseGoogleDto;
import com.swm.dto.goong.distance.matrix.DistanceMatrixResponseGoongDto;
import com.swm.dto.goong.geocoding.GeocodingGoongResponseDto;
import com.swm.dto.homestay.HomestayFilterDto;
import com.swm.dto.homestay.HomestayPagesResponseDto;
import com.swm.dto.homestay.HomestayResponseDto;
import com.swm.entity.HomestayEntity;
import com.swm.entity.HomestayPostingRequestEntity;
import com.swm.entity.HomestayPriceListEntity;
import com.swm.entity.LandlordEntity;
import com.swm.entity.LandlordStatisticEntity;
import com.swm.entity.SpecialDayPriceListEntity;
import com.swm.entity.SystemStatisticEntity;
import com.swm.entity.UserEntity;
import com.swm.enums.BookingStatus;
import com.swm.enums.HomestayStatus;
import com.swm.enums.PriceType;
import com.swm.enums.RequestStatus;
import com.swm.enums.RequestType;
import com.swm.exception.DuplicateResourceException;
import com.swm.exception.InvalidBalanceException;
import com.swm.exception.ResourceNotAllowException;
import com.swm.exception.ResourceNotFoundException;
import com.swm.repository.IHomestayRepository;
import com.swm.repository.ISpecialDayPriceListRepository;
import com.swm.service.IAuthenticationService;
import com.swm.service.IBookingService;
import com.swm.service.IHomestayService;
import com.swm.service.ILandlordStatisticService;
import com.swm.service.ISystemStatisticService;
import com.swm.service.IUserService;
import com.swm.util.CustomPage;
import com.swm.util.DateParsingUtil;

@Service
public class HomestayService implements IHomestayService {

//	@AllArgsConstructor
//	@NoArgsConstructor
//	@Getter
//	@Setter
//	class HomestayGeometryFromUserLocation {
//		String homestayName;
//		String latLng;
//		String distance;
//	}

	@Autowired
	private IHomestayRepository homestayRepo;

	@Autowired
	private IUserService userService;

	@Autowired
	private IAuthenticationService authenticationService;

	@Autowired
	@Lazy
	private IBookingService bookingService;

	@Autowired
	@Lazy
	private ISystemStatisticService systemStatisticService;

	@Autowired
	private ILandlordStatisticService landlordStatisticService;

	@Autowired
	private ISpecialDayPriceListRepository specialDayPriceListRepo;

	@Autowired
	@Lazy
	private HomestayConverter homestayConvert;

	@Value("${google.api.key}")
	private String googleApiKey;

	@Value("${goong.api.key}")
	private String goongApiKey;

	private Date currentDate = new Date();

	private RestTemplate restTemplate = new RestTemplate();

	private String GOONG_DISTANCE_MATRIX_API = "https://rsapi.goong.io/DistanceMatrix";

	private String GOONG_GEOCODING_API = "https://rsapi.goong.io/geocode";

	Logger log = LoggerFactory.getLogger(HomestayService.class);

	@Override
	public HomestayEntity findHomestayByName(String name) {
		HomestayEntity homestayEntity = homestayRepo.findHomestayByName(name)
				.orElseThrow(() -> new ResourceNotFoundException(name, "Homestay not found"));

		return homestayEntity;
	}

	@Override
	public List<HomestayEntity> getHomestayBookingAvailableList() {
		List<HomestayEntity> homestayList = homestayRepo.findAll().stream()
				.filter(h -> h.getStatus().equalsIgnoreCase(HomestayStatus.HOMESTAY_BOOKING_AVAILABLE.name()))
				.collect(Collectors.toList());

		return homestayList;
	}

	@Transactional
	@Override
	public HomestayEntity setDeleteStatusForHomestayById(Long Id) {
		UserEntity user = userService.findUserByUserInfo(authenticationService.getAuthenticatedUser().getUsername());
		HomestayEntity homestayEntity = homestayRepo.findById(Id)
				.orElseThrow(() -> new ResourceNotFoundException(Id.toString(), "Homestay id not found"));

		if (homestayEntity.getBooking().isEmpty()) {
			homestayEntity.setStatus(HomestayStatus.HOMESTAY_DELETE.name());
			homestayEntity.setModifiedBy(user.getUsername());
			homestayEntity.setModifiedDate(DateParsingUtil.formatDateTime(currentDate));
		} else {
			if (homestayEntity.getBooking().stream()
					.anyMatch(h -> h.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_PENDING.name())
							|| h.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_PENDING_ALERT_SENT.name()))) {
				homestayEntity.getBooking().stream()
						.filter(h -> h.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_PENDING.name())
								|| h.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_PENDING_ALERT_SENT.name()))
						.collect(Collectors.toList()).forEach(h -> {
							bookingService.confirmBooking(h.getId(), false, "Homestay has been removed by landlord");
						});
			}
			homestayEntity.setStatus(HomestayStatus.HOMESTAY_PENDING_DELETE.name());
			homestayEntity.setModifiedBy(user.getUsername());
			homestayEntity.setModifiedDate(DateParsingUtil.formatDateTime(currentDate));
		}

		return homestayEntity;
	}

	@Transactional
	@Override
	public HomestayEntity createHomestay(HomestayEntity homestayEntity) {

		if (homestayRepo.findHomestayByName(homestayEntity.getName()).isPresent()) {
			throw new DuplicateResourceException(homestayEntity.getName(), "Homestay exist");
		}
		GeocodingGoongResponseDto homestayAddressGeometry = getLocationGeometry(homestayEntity.getAddress());
		StringBuilder homestayActualAddress = new StringBuilder();
		homestayActualAddress.append(homestayAddressGeometry.getResults().get(0).getFormatted_address()).append("-")
				.append(homestayAddressGeometry.getResults().get(0).getGeometry().getLocation().getLat()).append(",")
				.append(homestayAddressGeometry.getResults().get(0).getGeometry().getLocation().getLng());
		System.out.println(homestayActualAddress.toString());
		homestayEntity.setAddress(homestayActualAddress.toString());
		String accountPoster = authenticationService.getAuthenticatedUser().getUsername();
		homestayEntity.setCreatedDate(currentDate);
		homestayEntity.setCreatedBy(accountPoster);
		homestayEntity.getImageList().forEach(img -> {
			img.setHomestayImage(homestayEntity);
			img.setCreatedDate(currentDate);
			img.setCreatedBy(accountPoster);
		});

		homestayEntity.getHomestayService().forEach(srv -> {
			srv.setHomestayServiceContainer(homestayEntity);
			srv.setCreatedDate(currentDate);
			srv.setCreatedBy(accountPoster);
		});

		homestayEntity.getCommonFacilities().forEach(c -> {
			c.setHomestayCommonFacility(homestayEntity);
			c.setCreatedBy(accountPoster);
			c.setCreatedDate(currentDate);
		});

		homestayEntity.getAdditionalFacilities().forEach(a -> {
			a.setHomestayAdditionalFacility(homestayEntity);
			a.setCreatedBy(accountPoster);
			a.setCreatedDate(currentDate);
		});

		homestayEntity.getPriceList().forEach(p -> {
			if (p.getType().equalsIgnoreCase(PriceType.SPECIAL.name()) && p.getSpecialDayPriceList() == null) {
				throw new ResourceNotAllowException("Special day day must include day, month and description");
			}
			p.setHomestayPriceList(homestayEntity);
			p.setCreatedBy(accountPoster);
			p.setCreatedDate(currentDate);
		});

		UserEntity userEntity = userService.findUserByUserInfo(accountPoster);
		LandlordEntity landlordEntity = userEntity.getLandlord();
		if (landlordEntity.getWallet().getBalance() < 1000) {
			throw new InvalidBalanceException("Your wallet doesn't have enough balance");
		}
		homestayEntity.setLandlordOwner(landlordEntity);
		landlordEntity.setHomestayOwned(List.of(homestayEntity));
		homestayEntity.getLicenseImage().setHomestayLicense(homestayEntity);
		homestayEntity.getLicenseImage().setCreatedBy(accountPoster);
		homestayEntity.getLicenseImage().setCreatedDate(currentDate);
//		RatingEntity rating = new RatingEntity();
//		rating.setCreatedDate(currentDate);
//		rating.setHomestayPoint(homestayEntity);
//		homestayEntity.setRating(rating);
		homestayEntity.setStatus(HomestayStatus.HOMESTAY_REQUEST_PENDING.name());
		HomestayPostingRequestEntity homestayPostingRequest = new HomestayPostingRequestEntity();
		homestayPostingRequest.setCreatedBy(homestayEntity.getLandlordOwner().getLandlordAccount().getUsername());
		homestayPostingRequest.setCreatedDate(currentDate);
		homestayPostingRequest.setRequestType(RequestType.HOMESTAY_POSTING_REQUEST.name());
		homestayPostingRequest.setStatus(RequestStatus.PENDING.name());
		homestayPostingRequest.setRequestHomestay(homestayEntity);
		homestayEntity.setHomestayPostingRequest(homestayPostingRequest);
		HomestayEntity homestayPersisted = homestayRepo.save(homestayEntity);
		SystemStatisticEntity systemStatistic = this.systemStatisticService.findSystemStatisticByTime(
				DateParsingUtil.statisticYearMonthTime(homestayPostingRequest.getCreatedDate()));
		LandlordStatisticEntity landlordStatistic = this.landlordStatisticService.findLandlordStatisticByTime(
				DateParsingUtil.statisticYearMonthTime(homestayPostingRequest.getCreatedDate()));
		Long systemTotalHomestayRequest = systemStatistic.getTotalHomestayRequest() + 1;
		Long landlordTotalPendingHomestay = landlordStatistic.getTotalPendingHomestay() + 1;
		systemStatistic.setTotalHomestayRequest(systemTotalHomestayRequest);
		landlordStatistic.setTotalPendingHomestay(landlordTotalPendingHomestay);

		return homestayPersisted;
	}

	@Override
	public List<HomestayEntity> findHomestayBookingAvailableListByCity(String city) {
		List<HomestayEntity> homestayList = this.getHomestayBookingAvailableList().stream()
				.filter(h -> h.getCity().equalsIgnoreCase(city)).collect(Collectors.toList());

		return homestayList;
	}

	@Override
	public HomestayEntity findHomestayById(Long Id) {
		HomestayEntity homestayEntity = this.homestayRepo.findById(Id)
				.orElseThrow(() -> new ResourceNotFoundException(Id.toString(), "Homestay id not found"));

		return homestayEntity;
	}

	@Override
	public List<HomestayEntity> findHomestayListByOwnerName() {
		UserDetails userDetails = authenticationService.getAuthenticatedUser();
		List<HomestayEntity> homestayEntityList = this.homestayRepo.findAll();
		List<HomestayEntity> ownerHomestayList = homestayEntityList.stream().filter(homestay -> homestay
				.getLandlordOwner().getLandlordAccount().getUsername().equals(userDetails.getUsername()))
				.collect(Collectors.toList());

		return ownerHomestayList;
	}

	@Override
	public List<SpecialDayPriceListEntity> addSpecialDayPriceList(List<SpecialDayPriceListEntity> specialDayPriceList) {
		specialDayPriceList.forEach(sd -> {
			StringBuilder specialDayCodeBuilder = new StringBuilder(sd.getSpecialDayCode());
			if (sd.getStartDay() != sd.getEndDay()) {
				specialDayCodeBuilder.append(sd.getStartDay()).append(sd.getStartMonth()).append(sd.getEndDay())
						.append(sd.getEndMonth());
			} else {
				specialDayCodeBuilder.append(sd.getStartDay()).append(sd.getStartMonth());
			}
			sd.setSpecialDayCode(specialDayCodeBuilder.toString());
			log.info(sd.getSpecialDayCode());
		});

		List<SpecialDayPriceListEntity> specialDayList = this.specialDayPriceListRepo.saveAll(specialDayPriceList);

		return specialDayList;
	}

	@Override
	public SpecialDayPriceListEntity findSpecialDayByCode(String code) {
		SpecialDayPriceListEntity specialDayPriceListEntity = specialDayPriceListRepo.findSpecialDayByCode(code)
				.orElseThrow(() -> new ResourceNotFoundException("Can't find special day code"));

		return specialDayPriceListEntity;
	}

	@Override
	public SpecialDayPriceListEntity deleteSpecialDayPriceList(String code) {
		SpecialDayPriceListEntity specialDayPriceList = this.findSpecialDayByCode(code);
		if (specialDayPriceList.getHomestayPriceLst() != null) {
			throw new ResourceNotAllowException("Can't delete special day with code " + code);
		}

		specialDayPriceListRepo.delete(specialDayPriceList);
		return specialDayPriceList;
	}

	@Override
	public List<SpecialDayPriceListEntity> getSpecialDayPriceList() {
		List<SpecialDayPriceListEntity> specialPriceList = specialDayPriceListRepo.findAll();

		return specialPriceList;
	}

	@Override
	public HomestayPagesResponseDto getHomestayPage(HomestayFilterDto filter, int page, int size) {
		Page<HomestayEntity> homestayPages = this.homestayRepo.homestayPagination(PageRequest.of(page, size),
				HomestayStatus.HOMESTAY_BOOKING_AVAILABLE.name());
		List<HomestayEntity> homestayList = homestayPages.getContent();
		Pageable pageable = null;
		System.out.println(filter.getFilterByHighestAveragePoint());

		if (filter.getFilterByNearestPlace() != null && filter.getFilterByNearestPlace()) {
			List<HomestayEntity> results = this.getNeareastLocationFromPlaces(filter.getFilterByStr()).stream()
					.map(h -> this.findHomestayByAddress(h.getAddress()))
					.filter(h -> h.getStatus().equalsIgnoreCase(HomestayStatus.HOMESTAY_BOOKING_AVAILABLE.name()))
					.collect(Collectors.toList());
			CustomPage<HomestayEntity> homestayCustomPages = new CustomPage<HomestayEntity>(page, size, results);
			homestayList = homestayCustomPages.of();

			List<String> geoMeterLtnLng = new ArrayList<String>();
			homestayList.forEach(h -> {
				geoMeterLtnLng.add(h.getAddress().split("-")[1]);
			});
			System.out.println(geoMeterLtnLng.size());
			List<String> userDistanceFromHomestays = this.getDistanceString(filter.getFilterByStr(), geoMeterLtnLng);
			HomestayPagesResponseDto homestayPagesResponseDto = new HomestayPagesResponseDto();
			List<HomestayResponseDto> homestayResponseListDto = homestayList.stream()
					.map(h -> homestayConvert.homestayResponseDtoConvert(h)).collect(Collectors.toList());
			for (int i = 0; i < homestayList.size(); i++) {
				String address = userDistanceFromHomestays.get(i);
				homestayResponseListDto.get(i).setUserDistanceFromHomestay(address);
			}
			homestayPagesResponseDto.setHomestayListDto(homestayResponseListDto);
			homestayPagesResponseDto.setTotalPages(homestayCustomPages.totalPages());

			return homestayPagesResponseDto;

		} else {
			if (StringUtils.hasLength(filter.getFilterByStr())
					&& !StringUtils.hasLength(filter.getLowestPrice().toString())
					&& !StringUtils.hasLength(filter.getHighestPrice().toString())) {
				System.out.println("filter string not null");
				if ((filter.getFilterByHighestAveragePoint() == null
						|| filter.getFilterByHighestAveragePoint() == false)
						&& (filter.getFilterByNewestPublishedDate() == null
								|| filter.getFilterByNewestPublishedDate() == false)
						&& (filter.getFilterByTrending() == null || filter.getFilterByTrending() == false)) {
					System.out.println("filter all null");
					pageable = PageRequest.of(page, size);

				} else if ((filter.getFilterByHighestAveragePoint() != null
						&& filter.getFilterByHighestAveragePoint() == true)
						&& (filter.getFilterByNewestPublishedDate() == null
								|| filter.getFilterByNewestPublishedDate() == false)
						&& (filter.getFilterByTrending() == null || filter.getFilterByTrending() == false)) {
					System.out.println("average filter not null");
					pageable = PageRequest.of(page, size, Sort.by(Direction.DESC, "averageRatingPoint"));

				} else if ((filter.getFilterByHighestAveragePoint() == null
						|| filter.getFilterByHighestAveragePoint() == false)
						&& (filter.getFilterByNewestPublishedDate() != null
								&& filter.getFilterByNewestPublishedDate() == true)
						&& (filter.getFilterByTrending() == null || filter.getFilterByTrending() == false)) {
					System.out.println("new filter not null");
					pageable = PageRequest.of(page, size, Sort.by(Direction.DESC, "createdDate"));

				} else if ((filter.getFilterByHighestAveragePoint() == null
						|| filter.getFilterByHighestAveragePoint() == false)
						&& (filter.getFilterByNewestPublishedDate() == null
								|| filter.getFilterByNewestPublishedDate() == false)
						&& (filter.getFilterByTrending() != null && filter.getFilterByTrending() == true)) {
					System.out.println("trending filter not null");
					pageable = PageRequest.of(page, size,
							Sort.by(Direction.DESC, "totalBookingTime", "averageRatingPoint"));

				} else if ((filter.getFilterByHighestAveragePoint() != null
						&& filter.getFilterByHighestAveragePoint() == true)
						&& (filter.getFilterByNewestPublishedDate() != null
								&& filter.getFilterByNewestPublishedDate() == true)
						&& (filter.getFilterByTrending() == null || filter.getFilterByTrending() == false)) {
					System.out.println("average and new filter not null");
					pageable = PageRequest.of(page, size, Sort.by(Direction.DESC, "createdDate", "averageRatingPoint"));

				} else if ((filter.getFilterByHighestAveragePoint() != null
						&& filter.getFilterByHighestAveragePoint() == true)
						&& (filter.getFilterByNewestPublishedDate() != null
								&& filter.getFilterByNewestPublishedDate() == true)
						&& (filter.getFilterByTrending() != null && filter.getFilterByTrending() == true)) {
					System.out.println("average, new and trending filter not null");
					pageable = PageRequest.of(page, size,
							Sort.by(Direction.DESC, "totalRatingTime", "averageRatingPoint", "createdDate"));

				}

				homestayPages = this.homestayRepo.homestayFilterByStringPagination(pageable, filter.getFilterByStr(),
						HomestayStatus.HOMESTAY_BOOKING_AVAILABLE.name());

			} else if (!StringUtils.hasLength(filter.getFilterByStr())
					&& filter.getLowestPrice() != null
					&& filter.getHighestPrice() == null) {

				if ((filter.getFilterByHighestAveragePoint() != null && filter.getFilterByHighestAveragePoint() == true)
						&& (filter.getFilterByNewestPublishedDate() == null
								|| filter.getFilterByNewestPublishedDate() == false)
						&& (filter.getFilterByTrending() == null || filter.getFilterByTrending() == false)) {

					pageable = PageRequest.of(page, size, Sort.by(Direction.DESC, "averagePoint"));

				} else if ((filter.getFilterByHighestAveragePoint() == null
						|| filter.getFilterByHighestAveragePoint() == false)
						&& (filter.getFilterByNewestPublishedDate() != null
								&& filter.getFilterByNewestPublishedDate() == true)
						&& (filter.getFilterByTrending() == null || filter.getFilterByTrending() == false)) {

					pageable = PageRequest.of(page, size, Sort.by(Direction.DESC, "createdDate"));

				} else if ((filter.getFilterByHighestAveragePoint() == null
						|| filter.getFilterByHighestAveragePoint() == false)
						&& (filter.getFilterByNewestPublishedDate() == null
								|| filter.getFilterByNewestPublishedDate() == false)
						&& (filter.getFilterByTrending() != null && filter.getFilterByTrending() == true)) {

					pageable = PageRequest.of(page, size, Sort.by("averageRatingPoint", "totalBookingTime"));

				}

				homestayPages = homestayRepo.homestayFilterByLowestPrice(pageable, filter.getLowestPrice());

			} else if (!StringUtils.hasLength(filter.getFilterByStr())
					&& filter.getLowestPrice() == null
					&& filter.getHighestPrice() != null) {

				if ((filter.getFilterByHighestAveragePoint() != null && filter.getFilterByHighestAveragePoint() == true)
						&& (filter.getFilterByNewestPublishedDate() == null
								|| filter.getFilterByNewestPublishedDate() == false)
						&& (filter.getFilterByTrending() == null || filter.getFilterByTrending() == false)) {

					pageable = PageRequest.of(page, size, Sort.by(Direction.DESC, "averagePoint"));

				} else if ((filter.getFilterByHighestAveragePoint() == null
						|| filter.getFilterByHighestAveragePoint() == false)
						&& (filter.getFilterByNewestPublishedDate() != null
								&& filter.getFilterByNewestPublishedDate() == true)
						&& (filter.getFilterByTrending() == null || filter.getFilterByTrending() == false)) {

					pageable = PageRequest.of(page, size, Sort.by(Direction.DESC, "createdDate"));

				} else if ((filter.getFilterByHighestAveragePoint() == null
						|| filter.getFilterByHighestAveragePoint() == false)
						&& (filter.getFilterByNewestPublishedDate() == null
								|| filter.getFilterByNewestPublishedDate() == false)
						&& (filter.getFilterByTrending() != null && filter.getFilterByTrending() == true)) {

					pageable = PageRequest.of(page, size, Sort.by("averageRatingPoint", "totalBookingTime"));
				}

				homestayPages = homestayRepo.homestayFilterByHighestPrice(pageable, filter.getHighestPrice());

			} 

		}

		homestayList = homestayPages.getContent();
		List<String> geoMeterLtnLng = new ArrayList<String>();
		homestayList.forEach(h -> {
			geoMeterLtnLng.add(h.getAddress().split("-")[1]);
		});
		System.out.println(geoMeterLtnLng.size());
		List<String> userDistanceFromHomestays = this.getDistanceString(filter.getUserCurrentLocation(),
				geoMeterLtnLng);
		HomestayPagesResponseDto homestayPagesResponseDto = new HomestayPagesResponseDto();
		List<HomestayResponseDto> homestayResponseListDto = homestayList.stream()
				.map(h -> homestayConvert.homestayResponseDtoConvert(h)).collect(Collectors.toList());
		for (int i = 0; i < homestayList.size(); i++) {
			String address = userDistanceFromHomestays.get(i);
			homestayResponseListDto.get(i).setUserDistanceFromHomestay(address);
		}
		homestayPagesResponseDto.setHomestayListDto(homestayResponseListDto);
		homestayPagesResponseDto.setTotalPages(homestayPages.getTotalPages());

		return homestayPagesResponseDto;
	}

//	private long differentFromCurrentDateToHomestayPublishedDate(Date publishedDate) {
//		long differentInTime = currentDate.getTime() - publishedDate.getTime();
//		long differentInDay = (differentInTime / (1000 * 60 * 60 * 24)) % 365;
//		System.out.println(differentInDay);
//
//		return differentInDay;
//	}

	private List<String> getDistanceString(String currentLocation, List<String> geoMeterLtnLng) {
		StringBuilder url = new StringBuilder();
		StringBuilder destinationBuilder = new StringBuilder();
		List<String> distanceListString = new ArrayList<String>();

		if (geoMeterLtnLng.size() == 1 && geoMeterLtnLng.size() > 0) {
			destinationBuilder.append(geoMeterLtnLng.get(0));
		} else {
			for (int i = 0; i < geoMeterLtnLng.size(); i++) {
				if (i == 0) {
					destinationBuilder.append(geoMeterLtnLng.get(i));
				} else {
					destinationBuilder.append("|").append(geoMeterLtnLng.get(i));
				}
			}
		}
		url.append(GOONG_DISTANCE_MATRIX_API).append("?origins=").append(currentLocation).append("&destinations=")
				.append(destinationBuilder.toString()).append("&api_key=").append(goongApiKey);
		System.out.println(url.toString());

		HttpHeaders header = new HttpHeaders();
		header.setContentType(MediaType.APPLICATION_JSON);
		DistanceMatrixResponseGoongDto distanceMatrixResponse = restTemplate.getForObject(url.toString(),
				DistanceMatrixResponseGoongDto.class, header);
		for (int i = 0; i < geoMeterLtnLng.size(); i++) {
			distanceListString
					.add(distanceMatrixResponse.getRows().get(0).getElements().get(i).getDistance().getText());
		}

		return distanceListString;
	}

	@Override
	public Long averageHomestayPrice(HomestayEntity homestayEntity) {
		long total = 0;
		for (HomestayPriceListEntity homestayPriceList : homestayEntity.getPriceList()) {
//			System.out.println("Price: " + homestayPriceList.getPrice() + " current total: " + total);
			total = total + homestayPriceList.getPrice();
		}
		total = total / homestayEntity.getPriceList().size();
		return total;
	}

	@Override
	public DistanceMatrixResponseGoogleDto getDistanceMatrixFromPlaces(String origin_address) {
//		String Url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=Vancouver%20BC%7CSeattle&destinations=San%20Francisco%7CVictoria%20BC&mode=bicycling&language=fr-FR&key=YOUR_API_KEY";
		StringBuilder url = new StringBuilder();
		StringBuilder destinationBuilder = new StringBuilder();
		List<HomestayEntity> homestayList = this.homestayRepo.findAll().stream()
				.filter(h -> h.getStatus().equalsIgnoreCase(HomestayStatus.HOMESTAY_BOOKING_AVAILABLE.name()))
				.collect(Collectors.toList());
		if (homestayList.size() > 1) {
			for (int i = 0; i < homestayList.size(); i++) {
				if (i == 0) {
					destinationBuilder.append(homestayList.get(i).getAddress());
				} else {
					destinationBuilder.append("|").append(homestayList.get(i).getAddress());
				}
			}
		} else {
			destinationBuilder.append(homestayList.get(0).getAddress());
		}
		url.append("https://maps.googleapis.com/maps/api/distancematrix/json?origins=").append(origin_address)
				.append("&destinations=").append(destinationBuilder.toString()).append("&key=")
				.append(this.googleApiKey);
		// url.append("https://rsapi.goong.io/DistanceMatrix?origins=").append(origin_address).append("&destinations=").append("10.845974116058448,106.71233014189893").append("&key=").append("BNftq2V1Va90QtjIOmWZSa8Mq0syezEDNWY6PVT4");
		System.out.println(url.toString());

		HttpHeaders header = new HttpHeaders();
		header.setContentType(MediaType.TEXT_PLAIN);

		DistanceMatrixResponseGoogleDto distanceMatrixResponse = restTemplate.getForObject(url.toString(),
				DistanceMatrixResponseGoogleDto.class, header);
		// DistanceMatrixResponseGoogleDto distanceMatrixResponse = new
		// DistanceMatrixResponseGoogleDto();

		return distanceMatrixResponse;
	}

	@Override
	public List<LocationDistanceDto> getNeareastLocationFromPlaces(String origin_address) {
//		String Url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=Vancouver%20BC%7CSeattle&destinations=San%20Francisco%7CVictoria%20BC&mode=bicycling&language=fr-FR&key=YOUR_API_KEY";

		StringBuilder url = new StringBuilder();
		StringBuilder destinationBuilder = new StringBuilder();
		List<String> addressList = new ArrayList<String>();
		List<LocationDistanceDto> locationDistanceList = new ArrayList<LocationDistanceDto>();
		List<HomestayEntity> homestayList = this.homestayRepo.findAll().stream()
				.filter(h -> h.getStatus().equalsIgnoreCase(HomestayStatus.HOMESTAY_BOOKING_AVAILABLE.name()))
				.collect(Collectors.toList());
		if (homestayList.size() > 1) {
			for (int i = 0; i < homestayList.size(); i++) {
				if (i == 0) {
					System.out.println(homestayList.get(i).getAddress().split("-")[1]);
					addressList.add(homestayList.get(i).getAddress().split("-")[1]);
					destinationBuilder.append(homestayList.get(i).getAddress().split("-")[1]);
				} else {
					System.out.println(homestayList.get(i).getAddress().split("-")[1]);
					addressList.add(homestayList.get(i).getAddress().split("-")[1]);
					destinationBuilder.append("|").append(homestayList.get(i).getAddress().split("-")[1]);
				}
			}
		} else {
			System.out.println(homestayList.get(0).getAddress().split("-")[1]);
			addressList.add(homestayList.get(0).getAddress().split("-")[1]);
			destinationBuilder.append(homestayList.get(0).getAddress().split("-")[1]);
		}
		url.append(GOONG_DISTANCE_MATRIX_API).append("?origins=").append(origin_address).append("&destinations=")
				.append(destinationBuilder.toString()).append("&api_key=").append(goongApiKey);
		System.out.println(url.toString());
		HttpHeaders header = new HttpHeaders();
		header.setContentType(MediaType.APPLICATION_JSON);
		DistanceMatrixResponseGoongDto distanceMatrixResponse = restTemplate.getForObject(url.toString(),
				DistanceMatrixResponseGoongDto.class, header);
		for (int i = 0; i < addressList.size(); i++) {
			LocationDistanceDto locationDistanceDto = new LocationDistanceDto(addressList.get(i),
					distanceMatrixResponse.getRows().get(0).getElements().get(i).getDistance().getValue());
			locationDistanceList.add(locationDistanceDto);
		}
		locationDistanceList = locationDistanceList.stream().sorted().collect(Collectors.toList());

		return locationDistanceList;
	}

	@Override
	public GeocodingGoongResponseDto getLocationGeometry(String address) {
		StringBuilder url = new StringBuilder();
		url.append(GOONG_GEOCODING_API).append("?address=").append(address).append("&api_key=").append(goongApiKey);
		HttpHeaders header = new HttpHeaders();
		header.setContentType(MediaType.APPLICATION_JSON);
		GeocodingGoongResponseDto geoCodingResponse = restTemplate.getForObject(url.toString(),
				GeocodingGoongResponseDto.class, header);

		return geoCodingResponse;
	}

	@Override
	public HomestayEntity findHomestayByAddress(String address) {
		System.out.println(address);
		HomestayEntity homestayEntity = homestayRepo.findHomestayByAddress(address)
				.orElseThrow(() -> new ResourceNotFoundException("Homestay not found"));

		return homestayEntity;
	}

	@Transactional
	@Override
	public void autoUpdateDeleteStatusHomestay() {
		List<HomestayEntity> homestayListEntity = this.homestayRepo.findAll().stream()
				.filter(h -> h.getStatus().equalsIgnoreCase(HomestayStatus.HOMESTAY_PENDING_DELETE.name()))
				.collect(Collectors.toList());
		homestayListEntity.forEach(h -> {
			h.getBooking().forEach(b -> {
				if (b.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_CHECKOUT_BY_LANDLORD.name())
						|| b.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_CHECKOUT_BY_PASSENGER_RELATIVE.name())
						|| b.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_CONFIRM_CHECKIN.name())
						|| b.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_CONFIRM_CHECKOUT.name())
						|| b.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_REJECTED.name())) {

					h.setStatus(HomestayStatus.HOMESTAY_DELETE.name());
				}
			});
		});

	}

}
