package com.swm.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.swm.converter.RequestConverter;
import com.swm.dto.ConfirmRequestDto;
import com.swm.dto.RequestDto;
import com.swm.entity.HomestayPostingRequestEntity;
import com.swm.entity.LandlordAccountRequestEntity;
import com.swm.service.IRequestService;

@RestController
@RequestMapping("/api/request")
public class RequestController {

	@Autowired
	private IRequestService requestService;

	@Autowired
	private RequestConverter requestConvert;

	@GetMapping("/homestay/all")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public ResponseEntity<?> getRequestList() {
		List<HomestayPostingRequestEntity> requestEntityList = requestService.findAllHomestayPostingRequest();
		List<RequestDto> requestDtoList = requestEntityList.stream()
				.map(r -> requestConvert.homestayPostinRequestDtoConvert(r)).collect(Collectors.toList());

		return new ResponseEntity<>(requestDtoList, HttpStatus.OK);
	}

	@GetMapping("/landlord/all")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public ResponseEntity<?> getRequestListByType() {
		List<LandlordAccountRequestEntity> requestEntityList = requestService.findAllLandlordAccountRequest();
		List<RequestDto> requestDtoList = requestEntityList.stream()
				.map(r -> requestConvert.landlordAccountRequestDtoConvert(r)).collect(Collectors.toList());

		return new ResponseEntity<>(requestDtoList, HttpStatus.OK);

	}

	@PatchMapping("/verification/landlord/{Id}")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public ResponseEntity<?> verifyLandlordAccountRequest(@PathVariable("Id") Long Id, @RequestBody ConfirmRequestDto confirmRequest) {
		LandlordAccountRequestEntity requestEntity = requestService.verifyLandlordAccountRequestById(Id, confirmRequest.getIsAccepted(), confirmRequest.getRejectMessage());
		RequestDto requestResponse = requestConvert.baseRequestDtoConvert(requestEntity, requestEntity.getId());

		return new ResponseEntity<>(requestResponse, HttpStatus.ACCEPTED);
	}

	@PatchMapping("/verification/homestay/{Id}")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public ResponseEntity<?> verifyRequest(@PathVariable("Id") Long Id, @RequestBody ConfirmRequestDto confirmRequest) {
		HomestayPostingRequestEntity requestEntity = requestService.verifyHomestayPostinRequest(Id, confirmRequest.getIsAccepted(), confirmRequest.getRejectMessage());
		RequestDto requestResponse = requestConvert.baseRequestDtoConvert(requestEntity, requestEntity.getId());

		return new ResponseEntity<>(requestResponse, HttpStatus.ACCEPTED);
	}

	@GetMapping("/homestay/{Id}")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public ResponseEntity<?> verifyRequest(@PathVariable("Id") Long Id) {
		System.out.println("get homestay id: " + Id);
		HomestayPostingRequestEntity requestEntity = requestService.findHomestayPostingRequest(Id);
		RequestDto requestResponse = requestConvert.baseRequestDtoConvert(requestEntity, requestEntity.getId());

		return new ResponseEntity<>(requestResponse, HttpStatus.ACCEPTED);
	}

}
