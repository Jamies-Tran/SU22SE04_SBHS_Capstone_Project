package com.swm.converter;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.swm.dto.HomestayAftercareDto;
import com.swm.dto.HomestayShortageInfoDto;
import com.swm.dto.HomestayFacilityDto;
import com.swm.dto.HomestayCompleteInfoDto;
import com.swm.dto.HomestayImageDto;
import com.swm.dto.HomestayLicenseDto;
import com.swm.entity.HomestayAftercareEntity;
import com.swm.entity.HomestayEntity;
import com.swm.entity.HomestayFacilityEntity;
import com.swm.entity.HomestayImageEntity;
import com.swm.entity.HomestayLicenseImageEntity;
import com.swm.service.IHomestayService;

@Component
public class HomestayConverter {
	
	@Autowired
	private IHomestayService homestayService;

	/* convert riêng từng cái entity trong homestay dto */
	public HomestayEntity homestayEntityConvert(HomestayShortageInfoDto homestayDto) {
		HomestayEntity homestayEntity = new HomestayEntity();
		homestayEntity.setName(homestayDto.getName());
		homestayEntity.setDescription(homestayDto.getDescription());
		homestayEntity.setAddress(homestayDto.getAddress());
		homestayEntity.setCity(homestayDto.getCity());
		homestayEntity.setPrice(homestayDto.getPrice());
		homestayEntity.setNumberOfRoom(homestayDto.getNumberOfRoom());
		homestayEntity.setCheckInTime(homestayDto.getCheckInTime());
		homestayEntity.setCheckOutTime(homestayDto.getCheckOutTime());
		homestayEntity.setPayment(homestayDto.getPayment());

		return homestayEntity;
	}

	public HomestayAftercareEntity homestayAftercareEntityConvert(HomestayAftercareDto homestayAftercareDto) {
		HomestayAftercareEntity homestayAftercareEntity = new HomestayAftercareEntity();
		homestayAftercareEntity.setServiceName(homestayAftercareDto.getName());
		homestayAftercareEntity.setPrice(homestayAftercareDto.getPrice());

		return homestayAftercareEntity;
	}

	public HomestayLicenseImageEntity homestayLicenseEntityConvert(HomestayLicenseDto homestayLicenseDto) {
		HomestayLicenseImageEntity homestayLicenseEntity = new HomestayLicenseImageEntity();
		homestayLicenseEntity.setUrl(homestayLicenseDto.getUrl());

		return homestayLicenseEntity;
	}

	public HomestayImageEntity homestayImageEntityConvert(HomestayImageDto homestayImageDto) {
		HomestayImageEntity homestayImageEntity = new HomestayImageEntity();
		homestayImageEntity.setUrl(homestayImageDto.getUrl());

		return homestayImageEntity;
	}

	public HomestayFacilityEntity homestayFacilityEntityConvert(HomestayFacilityDto homestayFacilityDto) {
		HomestayFacilityEntity homestayFacilityEntity = new HomestayFacilityEntity();
		homestayFacilityEntity.setName(homestayFacilityDto.getName());
		homestayFacilityEntity.setAmount(homestayFacilityDto.getAmount());

		return homestayFacilityEntity;
	}

	public HomestayShortageInfoDto homestayDtoConvert(HomestayEntity homestayEntity) {
		List<HomestayImageDto> homestayImageList = homestayEntity.getImageList().stream()
				.map(img -> this.homestayImageDtoConvert(img)).collect(Collectors.toList());
		List<HomestayAftercareDto> homestayServiceList = homestayEntity.getHomestayService().stream()
				.map(srv -> this.homestayAftercareDtoConvert(srv)).collect(Collectors.toList());
		List<HomestayFacilityDto> homestayFacilityList = homestayEntity.getFacilities().stream()
				.map(fct -> this.homestayFacilityDtoConvert(fct)).collect(Collectors.toList());
		HomestayShortageInfoDto homestayDto = new HomestayShortageInfoDto();
		homestayDto.setId(homestayEntity.getId());
		homestayDto.setName(homestayEntity.getName());
		homestayDto.setDescription(homestayEntity.getDescription());
		//homestayDto.setOwner(homestayEntity.getLandlordOwner().getLandlordAccount().getUsername());
		homestayDto.setAddress(homestayEntity.getAddress());
		homestayDto.setCity(homestayEntity.getCity());
		homestayDto.setPrice(homestayEntity.getPrice());
		homestayDto.setNumberOfRoom(homestayEntity.getNumberOfRoom());
		homestayDto.setCheckInTime(homestayEntity.getCheckInTime());
		homestayDto.setCheckOutTime(homestayEntity.getCheckOutTime());
		homestayDto.setPayment(homestayEntity.getPayment());
		//homestayDto.setStatus(homestayEntity.getStatus());
		homestayDto.setHomestayLicense(this.homestayLicenseDtoConvert(homestayEntity.getLicenseImage()));
		homestayDto.setHomestayImages(homestayImageList);
		homestayDto.setHomestayServices(homestayServiceList);
		homestayDto.setHomestayFacilities(homestayFacilityList);
		
		return homestayDto;
	}
	
	public HomestayCompleteInfoDto homestayCompleteInfoDtoConvert(HomestayEntity homestayEntity) {
		List<HomestayImageDto> homestayImageList = homestayEntity.getImageList().stream()
				.map(img -> this.homestayImageDtoConvert(img)).collect(Collectors.toList());
		List<HomestayAftercareDto> homestayServiceList = homestayEntity.getHomestayService().stream()
				.map(srv -> this.homestayAftercareDtoConvert(srv)).collect(Collectors.toList());
		List<HomestayFacilityDto> homestayFacilityList = homestayEntity.getFacilities().stream()
				.map(fct -> this.homestayFacilityDtoConvert(fct)).collect(Collectors.toList());
		HomestayCompleteInfoDto homestayDto = new HomestayCompleteInfoDto();
		homestayDto.setId(homestayEntity.getId());
		homestayDto.setName(homestayEntity.getName());
		homestayDto.setDescription(homestayEntity.getDescription());
		homestayDto.setOwner(homestayEntity.getLandlordOwner().getLandlordAccount().getUsername());
		homestayDto.setAddress(homestayEntity.getAddress());
		homestayDto.setCity(homestayEntity.getCity());
		homestayDto.setPrice(homestayEntity.getPrice());
		homestayDto.setNumberOfRoom(homestayEntity.getNumberOfRoom());
		homestayDto.setCheckInTime(homestayEntity.getCheckInTime());
		homestayDto.setCheckOutTime(homestayEntity.getCheckOutTime());
		homestayDto.setPayment(homestayEntity.getPayment());
		homestayDto.setStatus(homestayEntity.getStatus());
		homestayDto.setConvenientPoint(homestayEntity.getRating().getConvenient());
		homestayDto.setSecurityPoint(homestayEntity.getRating().getSecurity());
		homestayDto.setPositionPoint(homestayEntity.getRating().getPosition());
		homestayDto.setAverage(homestayEntity.getRating().getAverage());
		homestayDto.setHomestayImages(homestayImageList);
		homestayDto.setHomestayServices(homestayServiceList);
		homestayDto.setHomestayFacilities(homestayFacilityList);
		homestayDto.setNumberOfFinishedBooking(homestayService.numberOfFinishedBookingHomestay(homestayEntity.getId()));
		
		return homestayDto;
	}

	private HomestayLicenseDto homestayLicenseDtoConvert(HomestayLicenseImageEntity homestayLicenseEntity) {
		HomestayLicenseDto homestayLicenseDto = new HomestayLicenseDto();
		homestayLicenseDto.setId(homestayLicenseEntity.getId());
		homestayLicenseDto.setUrl(homestayLicenseEntity.getUrl());

		return homestayLicenseDto;
	}

	public HomestayImageDto homestayImageDtoConvert(HomestayImageEntity homestayImageEntity) {
		HomestayImageDto homestayImageDto = new HomestayImageDto();
		homestayImageDto.setId(homestayImageEntity.getId());
		homestayImageDto.setUrl(homestayImageEntity.getUrl());

		return homestayImageDto;
	}

	public HomestayAftercareDto homestayAftercareDtoConvert(HomestayAftercareEntity homestayAftercareEntity) {
		HomestayAftercareDto homestayAftercareDto = new HomestayAftercareDto();
		homestayAftercareDto.setId(homestayAftercareEntity.getId());
		homestayAftercareDto.setName(homestayAftercareEntity.getServiceName());
		homestayAftercareDto.setPrice(homestayAftercareEntity.getPrice());

		return homestayAftercareDto;
	}

	public HomestayFacilityDto homestayFacilityDtoConvert(HomestayFacilityEntity homestayFacilityEntity) {
		HomestayFacilityDto homestayFacilityDto = new HomestayFacilityDto();
		homestayFacilityDto.setId(homestayFacilityEntity.getId());
		homestayFacilityDto.setName(homestayFacilityEntity.getName());
		homestayFacilityDto.setAmount(homestayFacilityEntity.getAmount());

		return homestayFacilityDto;
	}
}
