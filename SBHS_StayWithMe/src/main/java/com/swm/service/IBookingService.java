package com.swm.service;

import java.util.Date;
import java.util.List;

import org.springframework.lang.Nullable;

import com.swm.entity.BookingEntity;
import com.swm.entity.HomestayEntity;

public interface IBookingService {
	BookingEntity createBooking(BookingEntity bookingEntity);
	
	BookingEntity findBookingById(Long Id);
	
	List<BookingEntity> getBookingList();
	
	BookingEntity confirmBooking(Long BookingId, boolean isAccepted, @Nullable String rejectMessage);
	
	BookingEntity verifyBookingCheckIn(Long bookingId, String bookingOtp);
	
	void confirmCheckIn(Long bookingId, boolean isAccepted);
	
	boolean isBookingDateValid(HomestayEntity homestayEntity ,Date checkIn, Date checkOut);
}
