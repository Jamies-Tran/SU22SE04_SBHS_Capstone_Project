package com.swm.service;

import java.util.List;

import org.springframework.lang.Nullable;

import com.swm.entity.BookingEntity;

public interface IBookingService {
	BookingEntity createBooking(BookingEntity bookingEntity);
	
	BookingEntity findBookingById(Long Id);
	
	List<BookingEntity> getBookingList();
	
	BookingEntity confirmBooking(Long BookingId, boolean isAccepted, @Nullable String rejectMessage);
	
	BookingEntity checkInHomestay(Long bookingId, String bookingOtp);
}
