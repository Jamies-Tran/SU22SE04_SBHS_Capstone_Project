package com.swm.converter;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.swm.dto.HomestayPriceListDto;
import com.swm.dto.HomestayRequestDto;
import com.swm.dto.RequestDto;
import com.swm.entity.BaseRequestEntity;
import com.swm.entity.HomestayPostingRequestEntity;
import com.swm.entity.HomestayPriceListEntity;
import com.swm.entity.LandlordAccountRequestEntity;
import com.swm.enums.RequestStatus;

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

	public RequestDto homestayPostinRequestDtoConvert(HomestayPostingRequestEntity request) {
		HomestayRequestDto requestDto = new HomestayRequestDto();
		List<HomestayPriceListDto> homestayPriceList = request.getRequestHomestay().getPriceList().stream()
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
	
	private HomestayPriceListDto homestayPriceListDtoConvert(HomestayPriceListEntity homestayPriceListEntity) {
		HomestayPriceListDto homestayPriceListDto = new HomestayPriceListDto();
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
}
