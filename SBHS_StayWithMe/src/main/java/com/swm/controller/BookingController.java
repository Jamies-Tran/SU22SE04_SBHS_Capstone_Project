package com.swm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.swm.converter.BookingConverter;
import com.swm.dto.BookingRequestDto;
import com.swm.dto.BookingResponseDto;
import com.swm.entity.BookingEntity;
import com.swm.service.IBookingService;

@RestController
@RequestMapping("/api/booking")
public class BookingController {
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
	
}
