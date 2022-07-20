package com.swm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.swm.converter.BookingConverter;
import com.swm.dto.BookingRequestDto;
import com.swm.dto.BookingResponseDto;
import com.swm.dto.ConfirmRequestDto;
import com.swm.entity.BookingEntity;
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
	
	@Autowired
	private IBookingService bookingService;
	
	@Autowired
	private BookingConverter bookingConvert;
	
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
	
	@PostMapping("/checkin")
	@PreAuthorize("hasAuthority('booking:update')")
	public ResponseEntity<?> checkInHomestay(@RequestBody CheckIn checkIn) {
		bookingService.verifyBookingCheckIn(checkIn.getBookingId(), checkIn.getBookingOtp());
		
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@PostMapping("/checkin-confirm")
	public ResponseEntity<?> confirmCheckInHomestay() {

		
		return new ResponseEntity<>(HttpStatus.OK);
	}
}
