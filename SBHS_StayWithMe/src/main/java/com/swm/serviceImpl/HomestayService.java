package com.swm.serviceImpl;

import java.util.Collections;
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
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;

import com.google.api.client.http.HttpHeaders;
import com.swm.converter.HomestayConverter;
import com.swm.dto.distance.matrix.response.DistanceMatrixResponseDto;
import com.swm.dto.homestay.HomestayFilterDto;
import com.swm.dto.homestay.HomestayPagesResponseDto;
import com.swm.dto.homestay.HomestayResponseDto;
import com.swm.entity.HomestayEntity;
import com.swm.entity.HomestayPostingRequestEntity;
import com.swm.entity.HomestayPriceListEntity;
import com.swm.entity.LandlordEntity;
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
import com.swm.service.ISystemStatisticService;
import com.swm.service.IUserService;
import com.swm.util.DateParsingUtil;

@Service
public class HomestayService implements IHomestayService {

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
	private ISpecialDayPriceListRepository specialDayPriceListRepo;
	

	@Autowired
	@Lazy
	private HomestayConverter homestayConvert;
	
	@Value("${google.api.key}")
	private String apiKey;

	private Date currentDate = new Date();
	
	private RestTemplate restTemplate = new RestTemplate();

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
	public HomestayEntity setDeleteStatusForHomestayById(Long Id, boolean confirmCancelAndDelete) {
		UserEntity user = userService.findUserByUserInfo(authenticationService.getAuthenticatedUser().getUsername());
		HomestayEntity homestayEntity = homestayRepo.findById(Id)
				.orElseThrow(() -> new ResourceNotFoundException(Id.toString(), "Homestay id not found"));
		
		if (confirmCancelAndDelete) {
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
						bookingService.confirmBooking(h.getId(), false,
								"Homestay has been removed by landlord");
					});
				}
				homestayEntity.setStatus(HomestayStatus.HOMESTAY_PENDING_DELETE.name());
				homestayEntity.setModifiedBy(user.getUsername());
				homestayEntity.setModifiedDate(DateParsingUtil.formatDateTime(currentDate));
			}
		}
		

		return homestayEntity;
	}

	@Transactional
	@Override
	public HomestayEntity createHomestay(HomestayEntity homestayEntity) {

		if (homestayRepo.findHomestayByName(homestayEntity.getName()).isPresent()) {
			throw new DuplicateResourceException(homestayEntity.getName(), "Homestay exist");
		}

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
		SystemStatisticEntity systemStatistic = this.systemStatisticService.findSystemStatisticByTime(DateParsingUtil.statisticYearMonthTime(homestayPostingRequest.getCreatedDate()));
		Long totalHomestayRequest = systemStatistic.getTotalHomestayRequest() + 1;
		systemStatistic.setTotalHomestayRequest(totalHomestayRequest);

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
		List<HomestayEntity> homestayEntityList = this.getHomestayBookingAvailableList();
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
		Page<HomestayEntity> homestayPages = this.homestayPagesNextOrPrevious(page, size);
		List<HomestayEntity> homestayList = homestayPages.getContent();

		if (StringUtils.hasLength(filter.getFilterByStr())) {
			homestayList = homestayPages.filter(h -> h.getName().contains(filter.getFilterByStr())
					|| h.getAddress().contains(filter.getFilterByStr())
					|| h.getLandlordOwner().getLandlordAccount().getUsername().contains(filter.getFilterByStr()))
					.toList();
		}

		if (filter.getFilterByHighestAveragePoint() != null && filter.getFilterByHighestAveragePoint()) {
			homestayList = homestayPages.stream().sorted(Collections.reverseOrder()).collect(Collectors.toList());
		}

		if (filter.getLowestPrice() != null && filter.getHighestPrice() != null) {
			homestayList = homestayPages.filter(h -> averageHomestayPrice(h) >= filter.getLowestPrice()
					&& averageHomestayPrice(h) <= filter.getHighestPrice()).toList();
		}

		if (filter.getFilterByNewestPublishedDate() != null && filter.getFilterByNewestPublishedDate()) {
			homestayList = homestayPages
					.filter(h -> differentFromCurrentDateToHomestayPublishedDate(h.getCreatedDate()) <= 30).toList();
		}

		HomestayPagesResponseDto homestayPagesResponseDto = new HomestayPagesResponseDto();
		List<HomestayResponseDto> homestayResponseListDto = homestayList.stream()
				.map(h -> homestayConvert.homestayResponseDtoConvert(h)).collect(Collectors.toList());
		homestayPagesResponseDto.setHomestayListDto(homestayResponseListDto);
		homestayPagesResponseDto.setTotalPages(homestayPages.getTotalPages());

		return homestayPagesResponseDto;
	}

	private long differentFromCurrentDateToHomestayPublishedDate(Date publishedDate) {
		long differentInTime = currentDate.getTime() - publishedDate.getTime();
		long differentInDay = (differentInTime / (1000 * 60 * 60 * 24)) % 365;

		return differentInDay;
	}

	private Page<HomestayEntity> homestayPagesNextOrPrevious(int page, int size) {
		Pageable pageable = PageRequest.of(page, size);
		Page<HomestayEntity> homestayPages = homestayRepo.homestayPageable(pageable,
				HomestayStatus.HOMESTAY_BOOKING_AVAILABLE.name());
		if (homestayPages.getTotalPages() <= page) {
			int homestayLastPageNumber = homestayPages.getTotalPages() - 1;
			homestayPages = homestayRepo.homestayPageable(PageRequest.of(homestayLastPageNumber, size),
					HomestayStatus.HOMESTAY_BOOKING_AVAILABLE.name());
		} else if (homestayPages.getTotalPages() == page) {
			homestayPages = homestayRepo.homestayPageable(PageRequest.of(0, size),
					HomestayStatus.HOMESTAY_BOOKING_AVAILABLE.name());
		}

		return homestayPages;
	}

	private Long averageHomestayPrice(HomestayEntity homestayEntity) {
		long total = 0;
		for (HomestayPriceListEntity homestayPriceList : homestayEntity.getPriceList()) {
//			System.out.println("Price: " + homestayPriceList.getPrice() + " current total: " + total);
			total = total + homestayPriceList.getPrice();
		}
		total = total / homestayEntity.getPriceList().size();
		return total;
	}

	@Override
	public DistanceMatrixResponseDto getDistanceMatrixFromPlaces(String origin_address) {
//		String Url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=Vancouver%20BC%7CSeattle&destinations=San%20Francisco%7CVictoria%20BC&mode=bicycling&language=fr-FR&key=YOUR_API_KEY";
		StringBuilder url = new StringBuilder();
		StringBuilder destinationBuilder = new StringBuilder();
		List<HomestayEntity> homestayList = this.homestayRepo.findAll();
		if(homestayList.size() > 1) {
			for(int i = 0; i < homestayList.size(); i++) {
				if(i == 0) {
					destinationBuilder.append(homestayList.get(i).getAddress().replace(" ", "%20"));
				} else {
					destinationBuilder.append("%7C").append(homestayList.get(i).getAddress().replace(" ", "%20"));
				}
			}
		} else {
			destinationBuilder.append(homestayList.get(0).getAddress());
		}
		url.append("https://maps.googleapis.com/maps/api/distancematrix/json?origins=").append(origin_address.replace(" ", "%20")).append("&destinations=").append(destinationBuilder.toString()).append("&key=").append(this.apiKey);
		//String testUrl = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=43 Phan Văn Trị, Phường 2, District 5, Ho Chi Minh City&destinations=413 Nguyễn Chí Thanh, Phường 15, District 5, Ho Chi Minh City&language=vi&key=AIzaSyBWOP0ACmQomYhf1CsV92Y3cjbj3HBV73U";
		//System.out.println(testUrl);
		System.out.println(url.toString());
		
		HttpHeaders header = new HttpHeaders();
		header.setContentType("text/plain");
		//DistanceMatrixResponseDto distanceMatrixResponse = new DistanceMatrixResponseDto();
		DistanceMatrixResponseDto distanceMatrixResponse = restTemplate.getForObject(url.toString(), DistanceMatrixResponseDto.class);
		
		return distanceMatrixResponse;
	}

}
