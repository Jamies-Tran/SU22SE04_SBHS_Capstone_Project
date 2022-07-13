package com.swm.serviceImpl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.swm.entity.HomestayAftercareEntity;
import com.swm.entity.HomestayEntity;
import com.swm.entity.HomestayFacilityEntity;
import com.swm.entity.HomestayImageEntity;
import com.swm.entity.HomestayLicenseImageEntity;
import com.swm.entity.HomestayPostingRequestEntity;
import com.swm.entity.LandlordEntity;
import com.swm.entity.RatingEntity;
import com.swm.entity.UserEntity;
import com.swm.enums.HomestayStatus;
import com.swm.enums.RequestStatus;
import com.swm.enums.RequestType;
import com.swm.exception.DuplicateResourceException;
import com.swm.exception.NotEnoughBalanceException;
import com.swm.exception.ResourceNotFoundException;
import com.swm.repository.IHomestayRepository;
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

	private Date currentDate = new Date();

	@Override
	public HomestayEntity findHomestayByName(String name) {
		HomestayEntity homestayEntity = homestayRepo.findHomestayByName(name)
				.orElseThrow(() -> new ResourceNotFoundException(name, "Homestay not found"));

		return homestayEntity;
	}

	@Override
	public List<HomestayEntity> findLandlordHomestayList() {
		List<HomestayEntity> homestayList = homestayRepo.findAll();
		if (homestayList.isEmpty()) {
			throw new ResourceNotFoundException("There's no homestay registered on platform");
		}

		return homestayList;
	}

	@Override
	public HomestayEntity deleteHomestayById(Long Id) {
		UserEntity userEntity = userService.findUserByUserInfo(authenticationService.getAuthenticatedUser().getUsername());
		
		HomestayEntity homestayEntity = homestayRepo.findById(Id)
				.orElseThrow(() -> new ResourceNotFoundException(Id.toString(), "Homestay id not found"));
		if(!userEntity.getLandlord().getHomestayOwned().contains(homestayEntity)) {
			throw new ResourceNotFoundException(homestayEntity.getName(), "You do not owned this homestay");
		}
		homestayRepo.delete(homestayEntity);

		return homestayEntity;
	}

	@Override
	public HomestayEntity createHomestay(HomestayEntity homestay, HomestayLicenseImageEntity homestayLicense,
			List<HomestayImageEntity> homestayImages, List<HomestayAftercareEntity> homestayServices,
			List<HomestayFacilityEntity> homestayFacilities) {

		if (homestayRepo.findHomestayByName(homestay.getName()).isPresent()) {
			throw new DuplicateResourceException(homestay.getName(), "Homestay exist");
		}

		String accountPoster = authenticationService.getAuthenticatedUser().getUsername();
		homestay.setCreatedDate(currentDate);
		homestay.setCreatedBy(accountPoster);
		homestayImages.forEach(img -> {
			img.setHomestayImage(homestay);
			img.setCreatedDate(currentDate);
			img.setCreatedBy(accountPoster);
		});

		homestay.setImageList(homestayImages);
		homestayServices.forEach(srv -> {
			srv.setHomestayServiceContainer(homestay);
			srv.setCreatedDate(currentDate);
			srv.setCreatedBy(accountPoster);
		});
		homestay.setHomestayService(homestayServices);
		homestayFacilities.forEach(fct -> {
			fct.setHomestayFacilityContainer(homestay);
			fct.setCreatedDate(currentDate);
			fct.setCreatedBy(accountPoster);
		});
		homestay.setFacilities(homestayFacilities);
		UserEntity userEntity = userService.findUserByUserInfo(accountPoster);
		LandlordEntity landlordEntity = userEntity.getLandlord();
		if (landlordEntity.getWallet().getBalance() < 1000) {
			throw new NotEnoughBalanceException("Your wallet doesn't have enough balance");
		}
		homestay.setLandlordOwner(landlordEntity);
		landlordEntity.setHomestayOwned(List.of(homestay));
		homestayLicense.setHomestayLicense(homestay);
		homestayLicense.setCreatedBy(accountPoster);
		homestayLicense.setCreatedDate(currentDate);
		homestay.setLicenseImage(homestayLicense);
		RatingEntity rating = new RatingEntity();
		rating.setCreatedDate(currentDate);
		rating.setHomestayPoint(homestay);
		homestay.setRating(rating);
		homestay.setStatus(HomestayStatus.HOMESTAY_REQUEST_PENDING.name());
		HomestayPostingRequestEntity homestayPostingRequest = new HomestayPostingRequestEntity();
		homestayPostingRequest.setCreatedBy(homestay.getLandlordOwner().getLandlordAccount().getUsername());
		homestayPostingRequest.setCreatedDate(currentDate);
		homestayPostingRequest.setRequestType(RequestType.HOMESTAY_POSTING_REQUEST.name());
		homestayPostingRequest.setStatus(RequestStatus.PENDING.name());
		homestayPostingRequest.setRequestHomestay(homestay);
		homestay.setHomestayPostingRequest(homestayPostingRequest);
		HomestayEntity homestayPersisted = homestayRepo.save(homestay);

		return homestayPersisted;
	}

	@Override
	public List<HomestayEntity> findHomestayContainLoction(String location) {
		List<HomestayEntity> homestayList = homestayRepo.findHomestayListContainLocation(location);
		if (homestayList.isEmpty()) {
			throw new ResourceNotFoundException(location, "There's no homestay at this location");
		}

		return homestayList;
	}


	@Override
	public HomestayEntity findHomestayById(Long Id) {
		HomestayEntity homestayEntity = this.homestayRepo.findById(Id)
				.orElseThrow(() -> new ResourceNotFoundException(Id.toString(), "Homestay id not found"));
		
		return homestayEntity;
	}

}
