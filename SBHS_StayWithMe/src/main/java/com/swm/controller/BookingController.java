package com.swm.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.swm.converter.BookingConverter;
import com.swm.converter.HomestayConverter;
import com.swm.dto.BookingRequestDto;
import com.swm.dto.BookingResponseDto;
import com.swm.dto.ConfirmRequestDto;
import com.swm.dto.HomestayShortageInfoDto;
import com.swm.entity.BookingDepositEntity;
import com.swm.entity.BookingEntity;
import com.swm.entity.HomestayEntity;
import com.swm.service.IBookingService;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@RestController
@RequestMapping("/api/booking")
public class BookingController {
	
	@AllArgsConstructor
	@NoArgsConstructor
	@Getter
	@Setter
	public static class CheckIn {
		private String bookingOtp;
		private Long bookingId;
	}
	
	@AllArgsConstructor
	@NoArgsConstructor
	@Getter
	@Setter
	public static class BookingDepositAmount {
		private Long amount;
	}
	
	@AllArgsConstructor
	@NoArgsConstructor
	@Getter
	@Setter
	public static class BookingDepositResponse {
		private HomestayShortageInfoDto homestayDto;
		private Long amount;
	}
	
	@Autowired
	private IBookingService bookingService;
	
	@Autowired
	private BookingConverter bookingConvert;
	
	@Autowired
	private HomestayConverter homestayConverter;
	
	private Logger log = LoggerFactory.getLogger(BookingController.class);
	
	@PostMapping
	@PreAuthorize("hasRole('ROLE_PASSENGER')")
	public ResponseEntity<?> createBooking(@RequestBody BookingRequestDto bookingRequestDto) {
		BookingEntity bookingEntity = bookingConvert.bookingToEntity(bookingRequestDto);
		BookingEntity bookingPersisted = bookingService.createBooking(bookingEntity);
		BookingResponseDto bookingResponseDto = bookingConvert.bookingToDto(bookingPersisted);
		
		return new ResponseEntity<>(bookingResponseDto, HttpStatus.CREATED);
	}
	
	@PostMapping("/confirm/{bookingId}")
	@PreAuthorize("hasRole('ROLE_LANDLORD')")
	public ResponseEntity<?> confirmBooking(@PathVariable("bookingId") Long bookingId, @RequestBody ConfirmRequestDto confirmRequestDto) {
		BookingEntity bookingEntity = bookingService.confirmBooking(bookingId, confirmRequestDto.getIsAccepted(), confirmRequestDto.getRejectMessage());
		BookingResponseDto bookingResponseDto = bookingConvert.bookingToDto(bookingEntity);
		
		return new ResponseEntity<>(bookingResponseDto, HttpStatus.OK);
	}
	
	@PostMapping("/deposit/payment/{bookingId}")
	@PreAuthorize("hasRole('ROLE_PASSENGER')")
	public ResponseEntity<?> payDepositBooking(@PathVariable("bookingId") Long bookingId,@RequestBody BookingDepositAmount depositAmount) {
		log.info("Request deposit: " + depositAmount.getAmount());
		BookingDepositEntity bookingDepositEntity = bookingService.payForBookingDeposit(bookingId, depositAmount.getAmount());
		HomestayEntity homestayEntity = bookingDepositEntity.getBookingDeposit().getBookingHomestay(); 
		HomestayShortageInfoDto homestayResponseDto = homestayConverter.homestayDtoConvert(homestayEntity);
		BookingDepositResponse bookingDepositResponse = new BookingDepositResponse();
		bookingDepositResponse.setHomestayDto(homestayResponseDto);
		bookingDepositResponse.setAmount(bookingDepositEntity.getDepositPaidAmount());
		
		return new ResponseEntity<>(bookingDepositResponse, HttpStatus.OK);
		
	}
	
	@PostMapping("/checkin")
	@PreAuthorize("hasAuthority('booking:update')")
	public ResponseEntity<?> checkInHomestay(@RequestBody CheckIn checkIn) {
		BookingEntity bookingEntity = bookingService.verifyBookingCheckIn(checkIn.getBookingId(), checkIn.getBookingOtp());
		BookingResponseDto bookingResponseDto = bookingConvert.bookingToDto(bookingEntity);
		
		return new ResponseEntity<>(bookingResponseDto, HttpStatus.OK);
	}
	
	@PatchMapping("/checkin-confirm/{bookingId}")
	@PreAuthorize("hasRole('ROLE_LANDLORD')")
	public ResponseEntity<?> confirmCheckInHomestay(@PathVariable("bookingId") Long bookingId,@RequestBody ConfirmRequestDto confirmRequestDto) {
		bookingService.confirmCheckIn(bookingId, confirmRequestDto.getIsAccepted());
		
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@PatchMapping("/passenger-cancel/{bookingId}")
	@PreAuthorize("hasRole('ROLE_PASSENGER')")
	public ResponseEntity<?> passengerCancelBooking(@PathVariable("bookingId") Long bookingId) {
		BookingEntity cancelBooking = bookingService.passengerCancelBooking(bookingId);
		BookingResponseDto bookingResponseDto = bookingConvert.bookingToDto(cancelBooking);
		
		return new ResponseEntity<>(bookingResponseDto, HttpStatus.OK);
		
	}
	
	@DeleteMapping("/delete/{bookingId}")
	@PreAuthorize("hasRole('ROLE_PASSENGER')")
	public ResponseEntity<?> deleteBooking(@PathVariable("bookingId") Long bookingId) {
		bookingService.deleteBooking(bookingId);
		
		return new ResponseEntity<>(HttpStatus.NO_CONTENT);
	}
	
	@GetMapping("/date-list/{bookingId}")
	@PreAuthorize("hasAuthority('booking:view')")
	public ResponseEntity<?> getBookingDateList(@PathVariable("bookingId") Long bookingId) {
		List<String> bookingDateList = bookingService.getHomestayBookingDate(bookingId);
		
		return new ResponseEntity<>(bookingDateList, HttpStatus.OK);
	}
}
