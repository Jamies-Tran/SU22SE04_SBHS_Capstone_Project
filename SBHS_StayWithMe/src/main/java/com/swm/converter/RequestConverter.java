package com.swm.converter;

import org.springframework.stereotype.Component;

import com.swm.dto.RequestDto;
import com.swm.entity.BaseRequestEntity;
import com.swm.entity.HomestayPostingRequestEntity;
import com.swm.entity.LandlordAccountRequestEntity;
import com.swm.enums.RequestStatus;

@Component
public class RequestConverter {
	
	public RequestDto landlordAccountRequestDtoConvert(LandlordAccountRequestEntity request) {
		RequestDto requestDto = new RequestDto();
		requestDto.setId(request.getId());
		requestDto.setCreatedBy(request.getCreatedBy());
		requestDto.setCreatedByEmail(request.getAccountRequesting().getLandlordAccount().getEmail());
		requestDto.setCreatedDate(request.getCreatedDate().toString());
		requestDto.setType(request.getRequestType());
		requestDto.setStatus(request.getStatus());
		if(request.getStatus().equals(RequestStatus.PENDING.name())) {
			requestDto.setVerifyBy(null);
		} else {
			requestDto.setVerifyBy(request.getVerifiedBy());
		} 
		return requestDto;
	}
	
	
	public RequestDto homestayPostinRequestDtoConvert(HomestayPostingRequestEntity request) {
		RequestDto requestDto = new RequestDto();
		requestDto.setId(request.getId());
		requestDto.setCreatedBy(request.getCreatedBy());
		requestDto.setCreatedDate(request.getCreatedDate().toString());
		requestDto.setType(request.getRequestType());
		requestDto.setStatus(request.getStatus());
		if(request.getStatus().equals(RequestStatus.PENDING.name())) {
			requestDto.setVerifyBy(null);
		} else {
			requestDto.setVerifyBy(request.getVerifiedBy());
		} 
		return requestDto;
	}
	
	public RequestDto baseRequestDtoConvert(BaseRequestEntity request, Long requestId) {
		RequestDto requestDto = new RequestDto();
		requestDto.setId(requestId);
		requestDto.setCreatedBy(request.getCreatedBy());
		requestDto.setCreatedDate(request.getCreatedDate().toString());
		requestDto.setType(request.getRequestType());
		requestDto.setStatus(request.getStatus());
		if(request.getStatus().equals(RequestStatus.PENDING.name())) {
			requestDto.setVerifyBy(null);
		} else {
			requestDto.setVerifyBy(request.getVerifiedBy());
		} 
		return requestDto;
	}
}
