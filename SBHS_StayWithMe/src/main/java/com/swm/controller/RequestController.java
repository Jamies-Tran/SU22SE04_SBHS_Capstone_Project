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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.swm.converter.RequestConverter;
import com.swm.dto.request.HomestayUpdateRequestDto;
import com.swm.dto.request.LandlordBalanceWithdrawalRequestDto;
import com.swm.dto.request.RequestConfirmationDto;
import com.swm.dto.request.RequestDto;
import com.swm.entity.HomestayPostingRequestEntity;
import com.swm.entity.HomestayUpdateRequestEntity;
import com.swm.entity.LandlordAccountRequestEntity;
import com.swm.entity.LandlordBalanceWithdrawalRequestEntity;
import com.swm.service.IRequestService;

@RestController
@RequestMapping("/api/request")
public class RequestController {

	@Autowired
	private IRequestService requestService;

	@Autowired
	private RequestConverter requestConvert;

	@GetMapping("/homestay/list/{status}")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public ResponseEntity<?> getRequestList(@PathVariable("status") String status) {
		List<HomestayPostingRequestEntity> requestEntityList = requestService
				.findAllHomestayPostingRequestByStatus(status);
		List<RequestDto> requestDtoList = requestEntityList.stream()
				.map(r -> requestConvert.homestayPostingRequestDtoConvert(r)).collect(Collectors.toList());

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
	public ResponseEntity<?> verifyLandlordAccountRequest(@PathVariable("Id") Long Id,
			@RequestBody RequestConfirmationDto confirmRequest) {
		LandlordAccountRequestEntity requestEntity = requestService.verifyLandlordAccountRequestById(Id,
				confirmRequest.getIsAccepted());
		RequestDto requestResponse = requestConvert.baseRequestDtoConvert(requestEntity, requestEntity.getId());

		return new ResponseEntity<>(requestResponse, HttpStatus.ACCEPTED);
	}

	@PatchMapping("/verification/homestay/{Id}")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public ResponseEntity<?> verifyRequest(@PathVariable("Id") Long Id,
			@RequestBody RequestConfirmationDto confirmRequest) {
		HomestayPostingRequestEntity requestEntity = requestService.verifyHomestayPostinRequest(Id,
				confirmRequest.getIsAccepted(), confirmRequest.getRejectMessage());
		RequestDto requestResponse = requestConvert.baseRequestDtoConvert(requestEntity, requestEntity.getId());

		return new ResponseEntity<>(requestResponse, HttpStatus.ACCEPTED);
	}

	@GetMapping("/homestay/{Id}")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public ResponseEntity<?> verifyRequest(@PathVariable("Id") Long Id) {
		HomestayPostingRequestEntity requestEntity = requestService.findHomestayPostingRequest(Id);
		RequestDto requestResponse = requestConvert.homestayPostingRequestDtoConvert(requestEntity);

		return new ResponseEntity<>(requestResponse, HttpStatus.OK);
	}

	@GetMapping("/landlord/{status}")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public ResponseEntity<?> findAllLandlordRequestByStatus(@PathVariable("status") String status) {
		List<LandlordAccountRequestEntity> landlordAccountRequesEntitytList = requestService
				.findAllLandlordAccountRequestByStatus(status);
		List<RequestDto> requestResponseDto = landlordAccountRequesEntitytList.stream()
				.map(r -> requestConvert.baseRequestDtoConvert(r, r.getId())).collect(Collectors.toList());

		return new ResponseEntity<>(requestResponseDto, HttpStatus.OK);
	}

	@GetMapping("/homestay-update")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_LANDLORD')")
	public ResponseEntity<?> findHomestayUpdateRequest(@RequestParam Long Id) {
		HomestayUpdateRequestEntity homestayUpdateRequest = requestService.findHomestayUpdateRequest(Id);
		HomestayUpdateRequestDto homestayUpdateRequestResponse = requestConvert
				.homestayUpdateRequestDtoConvert(homestayUpdateRequest);

		return new ResponseEntity<>(homestayUpdateRequestResponse, HttpStatus.OK);
	}

	@GetMapping("/homestay-update/{status}")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_LANDLORD')")
	public ResponseEntity<?> getHomestayUpdateRequestList(@PathVariable("status") String status) {
		List<HomestayUpdateRequestEntity> homestayUpdateRequestList = requestService
				.findAllHomestayUpdateRequestByStatus(status);
		List<HomestayUpdateRequestDto> homestayUpdateRequestResponseList = homestayUpdateRequestList.stream()
				.map(h -> requestConvert.homestayUpdateRequestDtoConvert(h)).collect(Collectors.toList());

		return new ResponseEntity<>(homestayUpdateRequestResponseList, HttpStatus.OK);
	}

	@PostMapping("/homestay-update")
	@PreAuthorize("hasRole('ROLE_LANDLORD')")
	public ResponseEntity<?> createHomestayUpdateRequest(
			@RequestBody HomestayUpdateRequestDto homestayUpdateRequestDto) {
		HomestayUpdateRequestEntity homestayUpdateRequestEntity = requestConvert
				.homestayUpdateRequestEntityConvert(homestayUpdateRequestDto);
		HomestayUpdateRequestEntity homestayUpdateRequestPersistence = requestService
				.createHomestayUpdateRequest(homestayUpdateRequestEntity);
		HomestayUpdateRequestDto homestayUpdateRequestResponse = requestConvert
				.homestayUpdateRequestDtoConvert(homestayUpdateRequestPersistence);

		return new ResponseEntity<>(homestayUpdateRequestResponse, HttpStatus.CREATED);
	}

	@GetMapping("/withdraw-request/{status}")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_LANDLORD')")
	public ResponseEntity<?> getWithdrawalRequestList(@PathVariable("status") String status) {
		List<LandlordBalanceWithdrawalRequestEntity> withdrawalRequestListEntity = requestService
				.findAllWithdrawalRequestByStatus(status);
		List<LandlordBalanceWithdrawalRequestDto> withdrawalRequestResponseDtoList = withdrawalRequestListEntity
				.stream().map(h -> requestConvert.withdrawalDtoConvert(h)).collect(Collectors.toList());
	
		return new ResponseEntity<>(withdrawalRequestResponseDtoList, HttpStatus.OK);
	}

	@PostMapping("/withdraw-request")
	@PreAuthorize("hasRole('ROLE_LANDLORD')")
	public ResponseEntity<?> createWithdrawalRequest(
			@RequestBody LandlordBalanceWithdrawalRequestDto withdrawalRequest) {
		LandlordBalanceWithdrawalRequestEntity withdrawalRequestEntity = requestConvert
				.withdrawalEntityConvert(withdrawalRequest);
		LandlordBalanceWithdrawalRequestEntity withdrawalRequestPersistence = requestService
				.createBalanceWithdrawalRequest(withdrawalRequestEntity, withdrawalRequest.getPassword());
		LandlordBalanceWithdrawalRequestDto withdrawalRequestResponse = requestConvert
				.withdrawalDtoConvert(withdrawalRequestPersistence);

		return new ResponseEntity<>(withdrawalRequestResponse, HttpStatus.CREATED);
	}

	@GetMapping("/withdraw-request")
	@PreAuthorize("hasAnyRole('ROLE_LANDLORD', 'ROLE_ADMIN')")
	public ResponseEntity<?> findWithdrawRequest(@RequestParam Long Id) {
		LandlordBalanceWithdrawalRequestEntity withdrawalRequestEntity = requestService.findWithdrawalRequestById(Id);
		LandlordBalanceWithdrawalRequestDto withdrawalRequestResponseDto = requestConvert
				.withdrawalDtoConvert(withdrawalRequestEntity);

		return new ResponseEntity<>(withdrawalRequestResponseDto, HttpStatus.OK);
	}

	@PatchMapping("/verification/withdrawal-request/{Id}")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public ResponseEntity<?> verifyWithdrawalRequest(@PathVariable("Id") Long Id,
			@RequestBody RequestConfirmationDto confirmRequest) {
		requestService.verifyWithdrawalRequest(Id, confirmRequest.getIsAccepted(), confirmRequest.getRejectMessage());

		return new ResponseEntity<>(HttpStatus.ACCEPTED);
	}

	@PatchMapping("/verification/homestay-update/{Id}")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public ResponseEntity<?> verifyHomestayUpdateRequest(@PathVariable("Id") Long Id,
			@RequestBody RequestConfirmationDto confirmRequest) {
		requestService.verifyHomestayUpdateRequest(Id, true, confirmRequest.getIsAccepted(),
				confirmRequest.getRejectMessage());

		return new ResponseEntity<>(HttpStatus.ACCEPTED);
	}

}
