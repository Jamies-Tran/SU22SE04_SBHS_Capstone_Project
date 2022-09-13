package com.swm.converter;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.swm.dto.HomestayAdditionalFacilityDto;
import com.swm.dto.HomestayAftercareDto;
import com.swm.dto.HomestayCommonFacilityDto;
import com.swm.dto.HomestayResponseDto;
import com.swm.dto.HomestayImageDto;
import com.swm.dto.HomestayLicenseDto;
import com.swm.dto.HomestayPriceListRequestDto;
import com.swm.dto.HomestayPriceListResponseDto;
import com.swm.dto.HomestayRequestDto;
import com.swm.dto.SpecialDayPriceListDto;
import com.swm.entity.HomestayAdditionalFacilityEntity;
import com.swm.entity.HomestayAftercareEntity;
import com.swm.entity.HomestayCommonFacilityEntity;
import com.swm.entity.HomestayEntity;
import com.swm.entity.HomestayImageEntity;
import com.swm.entity.HomestayLicenseImageEntity;
import com.swm.entity.HomestayPriceListEntity;
import com.swm.entity.SpecialDayPriceListEntity;
import com.swm.service.IHomestayService;

@Component
public class HomestayConverter {
	
	@Autowired
	private IHomestayService homestayService;
	
	/* convert riêng từng cái entity trong homestay dto */
	public HomestayEntity homestayEntityConvert(HomestayRequestDto homestayDto) {
		List<HomestayPriceListEntity> homestayPriceList = homestayDto.getHomestayPriceList().stream()
				.map(p -> this.homestayPriceListEntityConvert(p)).collect(Collectors.toList());
		List<HomestayCommonFacilityEntity> homestayCommonFacilities = homestayDto.getHomestayCommonFacilities().stream()
				.map(c -> this.homestayCommonFacilityEntityConvert(c)).collect(Collectors.toList());
		List<HomestayAdditionalFacilityEntity> homestayAdditionalFacilities = homestayDto.getHomestayAdditionalFacilities().stream()
				.map(a -> this.homestayAdditionalEntityConvert(a)).collect(Collectors.toList());
		List<HomestayImageEntity> homestayImages = homestayDto.getHomestayImages().stream()
				.map(i -> this.homestayImageEntityConvert(i)).collect(Collectors.toList());
		List<HomestayAftercareEntity> homestayServices = homestayDto.getHomestayServices().stream()
				.map(s -> this.homestayAftercareEntityConvert(s)).collect(Collectors.toList());
		HomestayLicenseImageEntity homestayLicenseImage = this.homestayLicenseEntityConvert(homestayDto.getHomestayLicense());
		
		HomestayEntity homestayEntity = new HomestayEntity();
		homestayEntity.setName(homestayDto.getName());
		homestayEntity.setDescription(homestayDto.getDescription());
		homestayEntity.setAddress(homestayDto.getAddress());
		homestayEntity.setCity(homestayDto.getCity());
		homestayEntity.setPriceList(homestayPriceList);
		homestayEntity.setNumberOfRoom(homestayDto.getNumberOfRoom());
		homestayEntity.setCheckInTime(homestayDto.getCheckInTime());
		homestayEntity.setCheckOutTime(homestayDto.getCheckOutTime());
		homestayEntity.setLicenseImage(homestayLicenseImage);
		homestayEntity.setAdditionalFacilities(homestayAdditionalFacilities);
		homestayEntity.setCommonFacilities(homestayCommonFacilities);
		homestayEntity.setImageList(homestayImages);
		homestayEntity.setHomestayService(homestayServices);
		

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

	public HomestayCommonFacilityEntity homestayFacilityEntityConvert(HomestayCommonFacilityDto homestayFacilityDto) {
		HomestayCommonFacilityEntity homestayFacilityEntity = new HomestayCommonFacilityEntity();
		homestayFacilityEntity.setName(homestayFacilityDto.getName());
		homestayFacilityEntity.setAmount(homestayFacilityDto.getAmount());

		return homestayFacilityEntity;
	}
	
	public HomestayResponseDto homestayResponseDtoConvert(HomestayEntity homestayEntity) {
		List<HomestayImageDto> homestayImageList = homestayEntity.getImageList().stream()
				.map(img -> this.homestayImageDtoConvert(img)).collect(Collectors.toList());
		List<HomestayAftercareDto> homestayServiceList = homestayEntity.getHomestayService().stream()
				.map(srv -> this.homestayAftercareDtoConvert(srv)).collect(Collectors.toList());
		List<HomestayCommonFacilityDto> homestayCommonFacilityList = homestayEntity.getCommonFacilities().stream()
				.map(fct -> this.homestayCommonFacilityDtoConvert(fct)).collect(Collectors.toList());
		List<HomestayAdditionalFacilityDto> homestayAdditionalFacilityList = homestayEntity.getAdditionalFacilities().stream()
				.map(a -> this.homestayAdditionalFacilityDtoConvert(a)).collect(Collectors.toList());
		List<HomestayPriceListResponseDto> homestayPriceList = homestayEntity.getPriceList().stream()
				.map(p -> this.homestayPriceListResponseDtoConvert(p)).collect(Collectors.toList());
		HomestayLicenseDto homestayLicenseImageDto = homestayLicenseDtoConvert(homestayEntity.getLicenseImage());
		HomestayResponseDto homestayDto = new HomestayResponseDto();
		homestayDto.setId(homestayEntity.getId());
		homestayDto.setName(homestayEntity.getName());
		homestayDto.setDescription(homestayEntity.getDescription());
		homestayDto.setOwner(homestayEntity.getLandlordOwner().getLandlordAccount().getUsername());
		homestayDto.setAddress(homestayEntity.getAddress());
		homestayDto.setCity(homestayEntity.getCity());
		homestayDto.setHomestayPriceList(homestayPriceList);
		homestayDto.setNumberOfRoom(homestayEntity.getNumberOfRoom());
		homestayDto.setCheckInTime(homestayEntity.getCheckInTime());
		homestayDto.setCheckOutTime(homestayEntity.getCheckOutTime());
		homestayDto.setStatus(homestayEntity.getStatus());
		homestayDto.setConvenientPoint(homestayEntity.getConvenientPoint());
		homestayDto.setSecurityPoint(homestayEntity.getSecurityPoint());
		homestayDto.setPositionPoint(homestayEntity.getPositionPoint());
		homestayDto.setAverage(homestayEntity.getAverage());
		homestayDto.setHomestayLicense(homestayLicenseImageDto);
		homestayDto.setHomestayImages(homestayImageList);
		homestayDto.setHomestayServices(homestayServiceList);
		homestayDto.setHomestayCommonFacilities(homestayCommonFacilityList);
		homestayDto.setHomestayAdditionalFacilities(homestayAdditionalFacilityList);
		homestayDto.setTotalBookingTime(homestayEntity.getTotalBookingTime());
		homestayDto.setTotalRatingTime(homestayEntity.getTotalRatingTime());
		
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
	
	private HomestayPriceListResponseDto homestayPriceListResponseDtoConvert(HomestayPriceListEntity homestayPriceListEntity) {
		HomestayPriceListResponseDto homestayPriceListDto = new HomestayPriceListResponseDto();
		homestayPriceListDto.setId(homestayPriceListEntity.getId());
		homestayPriceListDto.setPrice(homestayPriceListEntity.getPrice());
		homestayPriceListDto.setType(homestayPriceListEntity.getType());
		if(homestayPriceListEntity.getSpecialDayPriceList() != null) {
			homestayPriceListDto.setSpecialDayList(specialDayPriceListDtoConvert(homestayPriceListEntity.getSpecialDayPriceList()));
		}
		
		return homestayPriceListDto;
	}
	
	private HomestayPriceListEntity homestayPriceListEntityConvert(HomestayPriceListRequestDto homestayPriceListDto) {
		HomestayPriceListEntity homestayPriceListEntity = new HomestayPriceListEntity();
		if(homestayPriceListDto.getSpecialDayCode() != null) {
			SpecialDayPriceListEntity specialDayPriceListEntity = homestayService.findSpecialDayByCode(homestayPriceListDto.getSpecialDayCode());
			specialDayPriceListEntity.setHomestayPriceLst(List.of(homestayPriceListEntity));
			homestayPriceListEntity.setSpecialDayPriceList(specialDayPriceListEntity);
		}
		homestayPriceListEntity.setPrice(homestayPriceListDto.getPrice());
		homestayPriceListEntity.setType(homestayPriceListDto.getType());
		
		
		return homestayPriceListEntity;
	}
	
	public SpecialDayPriceListDto specialDayPriceListDtoConvert(SpecialDayPriceListEntity homestayPriceListEntity) {
		SpecialDayPriceListDto specialDayListDto = new SpecialDayPriceListDto();
		specialDayListDto.setId(homestayPriceListEntity.getId());
		specialDayListDto.setStartDay(homestayPriceListEntity.getStartDay());
		specialDayListDto.setEndDay(homestayPriceListEntity.getEndDay());
		specialDayListDto.setStartMonth(homestayPriceListEntity.getStartMonth());
		specialDayListDto.setEndMonth(homestayPriceListEntity.getEndMonth());
		specialDayListDto.setDescription(homestayPriceListEntity.getDescription());
		specialDayListDto.setSpecialDayCode(homestayPriceListEntity.getSpecialDayCode());
		
		return specialDayListDto;
	}
	
	public SpecialDayPriceListEntity specialDayPriceListEntityConverter(SpecialDayPriceListDto specialDayPriceListDto) {
		SpecialDayPriceListEntity specialDayPriceListEntity = new SpecialDayPriceListEntity();
		//specialDayPriceListEntity.setSpecialDayCode(specialDayPriceListDto.getSpecialDayCode());
		specialDayPriceListEntity.setStartDay(specialDayPriceListDto.getStartDay());
		specialDayPriceListEntity.setEndDay(specialDayPriceListDto.getEndDay());
		specialDayPriceListEntity.setStartMonth(specialDayPriceListDto.getStartMonth());
		specialDayPriceListEntity.setEndMonth(specialDayPriceListDto.getEndMonth());
		specialDayPriceListEntity.setDescription(specialDayPriceListDto.getDescription());
		
		return specialDayPriceListEntity;
	}

	public HomestayAftercareDto homestayAftercareDtoConvert(HomestayAftercareEntity homestayAftercareEntity) {
		HomestayAftercareDto homestayAftercareDto = new HomestayAftercareDto();
		homestayAftercareDto.setId(homestayAftercareEntity.getId());
		homestayAftercareDto.setName(homestayAftercareEntity.getServiceName());
		homestayAftercareDto.setPrice(homestayAftercareEntity.getPrice());

		return homestayAftercareDto;
	}

	public HomestayCommonFacilityDto homestayCommonFacilityDtoConvert(HomestayCommonFacilityEntity homestayFacilityEntity) {
		HomestayCommonFacilityDto homestayFacilityDto = new HomestayCommonFacilityDto();
		homestayFacilityDto.setId(homestayFacilityEntity.getId());
		homestayFacilityDto.setName(homestayFacilityEntity.getName());
		homestayFacilityDto.setAmount(homestayFacilityEntity.getAmount());

		return homestayFacilityDto;
	}
	
	public HomestayAdditionalFacilityDto homestayAdditionalFacilityDtoConvert(HomestayAdditionalFacilityEntity homestayAdditionalFacilityEntity) {
		HomestayAdditionalFacilityDto homestayAdditionalFacilityDto = new HomestayAdditionalFacilityDto();
		homestayAdditionalFacilityDto.setId(homestayAdditionalFacilityEntity.getId());
		homestayAdditionalFacilityDto.setName(homestayAdditionalFacilityEntity.getName());
		homestayAdditionalFacilityDto.setAmount(homestayAdditionalFacilityEntity.getAmount());
		
		return homestayAdditionalFacilityDto;
	}
	
	public HomestayCommonFacilityEntity homestayCommonFacilityEntityConvert(HomestayCommonFacilityDto homestayCommonFacilityDto) {
		HomestayCommonFacilityEntity homestayCommonFacilityEntity = new HomestayCommonFacilityEntity();
		homestayCommonFacilityEntity.setName(homestayCommonFacilityDto.getName());
		homestayCommonFacilityEntity.setAmount(homestayCommonFacilityDto.getAmount());
		
		return homestayCommonFacilityEntity;
	}
	
	public HomestayAdditionalFacilityEntity homestayAdditionalEntityConvert(HomestayAdditionalFacilityDto homestayAdditionalFacilityDto) {
		HomestayAdditionalFacilityEntity homestayAdditionalFacilityEntity = new HomestayAdditionalFacilityEntity();
		homestayAdditionalFacilityEntity.setName(homestayAdditionalFacilityDto.getName());
		homestayAdditionalFacilityEntity.setAmount(homestayAdditionalFacilityDto.getAmount());
		
		return homestayAdditionalFacilityEntity;
	}
}
