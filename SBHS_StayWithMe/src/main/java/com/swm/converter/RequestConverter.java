package com.swm.converter;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.swm.dto.HomestayAdditionalFacilityDto;
import com.swm.dto.HomestayAftercareDto;
import com.swm.dto.HomestayCommonFacilityDto;
import com.swm.dto.HomestayImageDto;
import com.swm.dto.HomestayPostingRequestDto;
import com.swm.dto.HomestayPriceListRequestDto;
import com.swm.dto.HomestayPriceListResponseDto;
import com.swm.dto.HomestayUpdateRequestDto;
import com.swm.dto.LandlordBalanceWithdrawalRequestDto;
import com.swm.dto.RequestDto;
import com.swm.entity.BaseRequestEntity;
import com.swm.entity.HomestayAdditionalFacilityEntity;
import com.swm.entity.HomestayAftercareEntity;
import com.swm.entity.HomestayCommonFacilityEntity;
import com.swm.entity.HomestayImageEntity;
import com.swm.entity.HomestayPostingRequestEntity;
import com.swm.entity.HomestayPriceListEntity;
import com.swm.entity.HomestayUpdateRequestEntity;
import com.swm.entity.LandlordAccountRequestEntity;
import com.swm.entity.LandlordBalanceWithdrawalRequestEntity;
import com.swm.enums.RequestStatus;
import com.swm.util.DateParsingUtil;

@Component
public class RequestConverter {

	@Autowired
	private HomestayConverter homestayConvert;

	public RequestDto landlordAccountRequestDtoConvert(LandlordAccountRequestEntity request) {
		RequestDto requestDto = new RequestDto();
		requestDto.setId(request.getId());
		requestDto.setCreatedBy(request.getCreatedBy());
		requestDto.setCreatedByEmail(request.getAccountRequesting().getLandlordAccount().getEmail());
		requestDto.setCreatedDate(request.getCreatedDate().toString());
		requestDto.setType(request.getRequestType());
		requestDto.setStatus(request.getStatus());
		if (request.getStatus().equals(RequestStatus.PENDING.name())) {
			requestDto.setVerifyBy(null);
		} else {
			requestDto.setVerifyBy(request.getVerifiedBy());
		}
		return requestDto;
	}

	public RequestDto homestayPostingRequestDtoConvert(HomestayPostingRequestEntity request) {
		HomestayPostingRequestDto requestDto = new HomestayPostingRequestDto();
		List<HomestayPriceListRequestDto> homestayPriceList = request.getRequestHomestay().getPriceList().stream()
				.map(p -> this.homestayPriceListDtoConvert(p)).collect(Collectors.toList());
		requestDto.setId(request.getId());
		requestDto.setCreatedBy(request.getCreatedBy());
		requestDto.setCreatedByEmail(request.getRequestHomestay().getLandlordOwner().getLandlordAccount().getEmail());
		requestDto.setCreatedDate(request.getCreatedDate().toString());
		requestDto.setType(request.getRequestType());
		requestDto.setStatus(request.getStatus());
		requestDto.setHomestayName(request.getRequestHomestay().getName());
		requestDto.setNumberOfRoom(request.getRequestHomestay().getNumberOfRoom());
		requestDto.setHomestayPriceList(homestayPriceList);
		requestDto.setCity(request.getRequestHomestay().getCity());
		requestDto.setCheckInTime(request.getRequestHomestay().getCheckInTime());
		requestDto.setCheckOutTime(request.getRequestHomestay().getCheckOutTime());
		requestDto.setAddress(request.getRequestHomestay().getAddress());
		requestDto.setDescription(request.getRequestHomestay().getDescription());
		requestDto.setImageLicenseUrl(request.getRequestHomestay().getLicenseImage().getUrl());
		requestDto.setHomestayImagesList(request.getRequestHomestay().getImageList().stream()
				.map(i -> homestayConvert.homestayImageDtoConvert(i)).collect(Collectors.toList()));
		requestDto.setHomestayFacilityList(request.getRequestHomestay().getCommonFacilities().stream()
				.map(f -> homestayConvert.homestayCommonFacilityDtoConvert(f)).collect(Collectors.toList()));
		requestDto.setHomestayAftercareList(request.getRequestHomestay().getHomestayService().stream()
				.map(s -> homestayConvert.homestayAftercareDtoConvert(s)).collect(Collectors.toList()));
		if (request.getStatus().equals(RequestStatus.PENDING.name())) {
			requestDto.setVerifyBy(null);
		} else {
			requestDto.setVerifyBy(request.getVerifiedBy());
		}
		return requestDto;
	}

	private HomestayPriceListRequestDto homestayPriceListDtoConvert(HomestayPriceListEntity homestayPriceListEntity) {
		HomestayPriceListRequestDto homestayPriceListDto = new HomestayPriceListRequestDto();
		homestayPriceListDto.setId(homestayPriceListEntity.getId());
		homestayPriceListDto.setPrice(homestayPriceListEntity.getPrice());

		return homestayPriceListDto;
	}

	public RequestDto baseRequestDtoConvert(BaseRequestEntity request, Long requestId) {
		RequestDto requestDto = new RequestDto();
		requestDto.setId(requestId);
		requestDto.setCreatedBy(request.getCreatedBy());
		requestDto.setCreatedDate(request.getCreatedDate().toString());
		requestDto.setType(request.getRequestType());
		requestDto.setStatus(request.getStatus());
		if (request.getStatus().equals(RequestStatus.PENDING.name())) {
			requestDto.setVerifyBy(null);
		} else {
			requestDto.setVerifyBy(request.getVerifiedBy());
		}
		return requestDto;
	}

	public HomestayUpdateRequestEntity homestayUpdateRequestEntityConvert(
			HomestayUpdateRequestDto homestayUpdateRequestDto) {
		HomestayUpdateRequestEntity homestayUpdateRequestEntity = new HomestayUpdateRequestEntity();
		if(homestayUpdateRequestDto.getNewHomestayAdditionalFacility() != null) {
			List<HomestayAdditionalFacilityEntity> newHomestayAdditionEntity = homestayUpdateRequestDto
					.getNewHomestayAdditionalFacility().stream()
					.map(f -> homestayConvert.homestayAdditionalEntityConvert(f)).collect(Collectors.toList());
			homestayUpdateRequestEntity.setNewHomestayAdditionalFacility(newHomestayAdditionEntity);
		}
		if(homestayUpdateRequestDto.getNewHomestayCommonFacility() != null) {
			List<HomestayCommonFacilityEntity> newHomestayCommonEntity = homestayUpdateRequestDto
					.getNewHomestayCommonFacility().stream()
					.map(f -> homestayConvert.homestayCommonFacilityEntityConvert(f)).collect(Collectors.toList());
			homestayUpdateRequestEntity.setNewHomestayCommonFacility(newHomestayCommonEntity);
		}
		if(homestayUpdateRequestDto.getNewHomestayImages() != null) {
			List<HomestayImageEntity> newHomestayImageEntity = homestayUpdateRequestDto.getNewHomestayImages().stream()
					.map(i -> homestayConvert.homestayImageEntityConvert(i)).collect(Collectors.toList());
			homestayUpdateRequestEntity.setNewHomestayImages(newHomestayImageEntity);
		}
		if(homestayUpdateRequestDto.getNewHomestayRequestPriceList() != null) {
			List<HomestayPriceListEntity> newHomestayPriceListEntity = homestayUpdateRequestDto.getNewHomestayRequestPriceList()
					.stream().map(f -> homestayConvert.homestayPriceListEntityConvert(f)).collect(Collectors.toList());
			homestayUpdateRequestEntity.setNewHomestayPriceList(newHomestayPriceListEntity);
		}
		if(homestayUpdateRequestDto.getNewHomestayService() != null) {
			List<HomestayAftercareEntity> newHomestayServiceEntity = homestayUpdateRequestDto.getNewHomestayService()
					.stream().map(s -> homestayConvert.homestayAftercareEntityConvert(s)).collect(Collectors.toList());
			homestayUpdateRequestEntity.setNewHomestayService(newHomestayServiceEntity);
		}
		
		
		homestayUpdateRequestEntity.setHomestayUpdateRequestId(homestayUpdateRequestDto.getHomestayUpdateRequestId());
		homestayUpdateRequestEntity.setNewName(homestayUpdateRequestDto.getNewName());
		homestayUpdateRequestEntity.setNewDescription(homestayUpdateRequestDto.getNewDescription());
		homestayUpdateRequestEntity.setNewAddress(homestayUpdateRequestDto.getNewAddress());
		homestayUpdateRequestEntity.setNewCity(homestayUpdateRequestDto.getNewCity());
		
		
		
		homestayUpdateRequestEntity
				.setNewHomestayLicenseImagesUrl(homestayUpdateRequestDto.getNewHomestayLicenseImageUrl());
		
		

		return homestayUpdateRequestEntity;
	}

	public HomestayUpdateRequestDto homestayUpdateRequestDtoConvert(HomestayUpdateRequestEntity homestayUpdateRequestEntity) {
		HomestayUpdateRequestDto homestayUpdateRequestDto = new HomestayUpdateRequestDto();
		if(homestayUpdateRequestEntity.getNewHomestayAdditionalFacility() != null) {
			List<HomestayAdditionalFacilityDto> homestayAdditionalDto = homestayUpdateRequestEntity
					.getNewHomestayAdditionalFacility().stream()
					.map(f -> homestayConvert.homestayAdditionalFacilityDtoConvert(f)).collect(Collectors.toList());
			homestayUpdateRequestDto.setNewHomestayAdditionalFacility(homestayAdditionalDto);
		}
		if(homestayUpdateRequestEntity.getNewHomestayCommonFacility() != null) {
			List<HomestayCommonFacilityDto> homestayCommonDto = homestayUpdateRequestEntity
					.getNewHomestayCommonFacility().stream()
					.map(f -> homestayConvert.homestayCommonFacilityDtoConvert(f)).collect(Collectors.toList());
			homestayUpdateRequestDto.setNewHomestayCommonFacility(homestayCommonDto);
		}
		if(homestayUpdateRequestEntity.getNewHomestayImages() != null) {
			List<HomestayImageDto> homestayImageDto = homestayUpdateRequestEntity
					.getNewHomestayImages().stream()
					.map(i -> homestayConvert.homestayImageDtoConvert(i)).collect(Collectors.toList());
			homestayUpdateRequestDto.setNewHomestayImages(homestayImageDto);
		}
		if(homestayUpdateRequestEntity.getNewHomestayPriceList() != null) {
			List<HomestayPriceListResponseDto> homestayPriceListDto = homestayUpdateRequestEntity
					.getNewHomestayPriceList().stream()
					.map(f -> homestayConvert.homestayPriceListResponseDtoConvert(f)).collect(Collectors.toList());
			homestayUpdateRequestDto.setNewHomestayResponsePriceList(homestayPriceListDto);
		}
		if(homestayUpdateRequestEntity.getNewHomestayService() != null) {
			List<HomestayAftercareDto> homestayServiceDto = homestayUpdateRequestEntity
					.getNewHomestayService().stream()
					.map(s -> homestayConvert.homestayAftercareDtoConvert(s)).collect(Collectors.toList());
			homestayUpdateRequestDto.setNewHomestayService(homestayServiceDto);
		}
		
		homestayUpdateRequestDto.setId(homestayUpdateRequestEntity.getId());
		homestayUpdateRequestDto.setHomestayUpdateRequestId(homestayUpdateRequestEntity.getHomestayUpdateRequestId());
		homestayUpdateRequestDto.setNewName(homestayUpdateRequestEntity.getNewName());
		homestayUpdateRequestDto.setNewDescription(homestayUpdateRequestEntity.getNewDescription());
		homestayUpdateRequestDto.setNewAddress(homestayUpdateRequestEntity.getNewAddress());
		homestayUpdateRequestDto.setNewCity(homestayUpdateRequestEntity.getNewCity());
		homestayUpdateRequestDto.setNewHomestayLicenseImageUrl(homestayUpdateRequestEntity.getNewHomestayLicenseImagesUrl());
		homestayUpdateRequestDto.setCreatedBy(homestayUpdateRequestEntity.getCreatedBy());
		homestayUpdateRequestDto.setCreatedByEmail(homestayUpdateRequestEntity.getCreatedByEmail());
		homestayUpdateRequestDto.setCreatedDate(DateParsingUtil.parseDateTimeToStr(homestayUpdateRequestEntity.getCreatedDate()));
		homestayUpdateRequestDto.setType(homestayUpdateRequestEntity.getRequestType());
		homestayUpdateRequestDto.setStatus(homestayUpdateRequestEntity.getStatus());
		
		return homestayUpdateRequestDto;
	}
	
	
	public LandlordBalanceWithdrawalRequestEntity withdrawalEntityConvert(LandlordBalanceWithdrawalRequestDto withdrawalRequestDto) {
		LandlordBalanceWithdrawalRequestEntity withdrawalEntity = new LandlordBalanceWithdrawalRequestEntity();
		withdrawalEntity.setAmount(withdrawalRequestDto.getAmount());
		
		return withdrawalEntity;
	}
	
	public LandlordBalanceWithdrawalRequestDto withdrawalDtoConvert(LandlordBalanceWithdrawalRequestEntity withdrawalRequestEntity) {
		LandlordBalanceWithdrawalRequestDto withdrawalRequestDto = new LandlordBalanceWithdrawalRequestDto();
		withdrawalRequestDto.setId(withdrawalRequestEntity.getId());
		withdrawalRequestDto.setCreatedBy(withdrawalRequestEntity.getCreatedBy());
		withdrawalRequestDto.setCreatedByEmail(withdrawalRequestEntity.getCreatedByEmail());
		withdrawalRequestDto.setCreatedDate(DateParsingUtil.parseDateTimeToStr(withdrawalRequestEntity.getCreatedDate()));
		withdrawalRequestDto.setStatus(withdrawalRequestEntity.getStatus());
		withdrawalRequestDto.setAmount(withdrawalRequestEntity.getAmount());
		if(StringUtils.hasLength(withdrawalRequestEntity.getVerifiedBy())) {
			withdrawalRequestDto.setVerifyBy(withdrawalRequestEntity.getVerifiedBy());
		}
		withdrawalRequestDto.setType(withdrawalRequestEntity.getRequestType());
		
		return withdrawalRequestDto;
	}
}
