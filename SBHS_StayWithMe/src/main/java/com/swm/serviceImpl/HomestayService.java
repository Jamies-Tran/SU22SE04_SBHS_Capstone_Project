package com.swm.serviceImpl;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.swm.entity.BookingEntity;
import com.swm.entity.HomestayEntity;
import com.swm.entity.HomestayPostingRequestEntity;
import com.swm.entity.LandlordEntity;
import com.swm.entity.RatingEntity;
import com.swm.entity.SpecialDayPriceListEntity;
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
import com.swm.service.IHomestayService;
import com.swm.service.IUserService;

@Service
public class HomestayService implements IHomestayService {

	@Autowired
	private IHomestayRepository homestayRepo;

	@Autowired
	private IUserService userService;

	@Autowired
	private IAuthenticationService authenticationService;

	@Autowired
	private ISpecialDayPriceListRepository specialDayPriceListRepo;

	private Date currentDate = new Date();

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

	@Override
	public HomestayEntity deleteHomestayById(Long Id) {
		UserEntity userEntity = userService
				.findUserByUserInfo(authenticationService.getAuthenticatedUser().getUsername());

		HomestayEntity homestayEntity = homestayRepo.findById(Id)
				.orElseThrow(() -> new ResourceNotFoundException(Id.toString(), "Homestay id not found"));
		if (!userEntity.getLandlord().getHomestayOwned().contains(homestayEntity)) {
			throw new ResourceNotFoundException(homestayEntity.getName(), "You do not owned this homestay");
		}
		homestayRepo.delete(homestayEntity);

		return homestayEntity;
	}

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
		RatingEntity rating = new RatingEntity();
		rating.setCreatedDate(currentDate);
		rating.setHomestayPoint(homestayEntity);
		homestayEntity.setRating(rating);
		homestayEntity.setStatus(HomestayStatus.HOMESTAY_REQUEST_PENDING.name());
		HomestayPostingRequestEntity homestayPostingRequest = new HomestayPostingRequestEntity();
		homestayPostingRequest.setCreatedBy(homestayEntity.getLandlordOwner().getLandlordAccount().getUsername());
		homestayPostingRequest.setCreatedDate(currentDate);
		homestayPostingRequest.setRequestType(RequestType.HOMESTAY_POSTING_REQUEST.name());
		homestayPostingRequest.setStatus(RequestStatus.PENDING.name());
		homestayPostingRequest.setRequestHomestay(homestayEntity);
		homestayEntity.setHomestayPostingRequest(homestayPostingRequest);
		HomestayEntity homestayPersisted = homestayRepo.save(homestayEntity);

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
	public Integer numberOfFinishedBookingHomestay(Long homestayId) {
		HomestayEntity homestayEntity = this.findHomestayById(homestayId);
		List<BookingEntity> succeedBookingList = homestayEntity.getBooking().stream()
				.filter(b -> b.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_FINISHED.name()))
				.collect(Collectors.toList());

		return succeedBookingList.size();
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
		if(specialDayPriceList.getHomestayPriceLst() != null) {
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

}
