package com.swm.service;

import java.util.List;

import com.swm.entity.BookingEntity;

public interface IBookingService {
	BookingEntity createBooking(BookingEntity bookingEntity);
	
	BookingEntity findBookingById(Long Id);
	
	List<BookingEntity> getBookingList();
}
