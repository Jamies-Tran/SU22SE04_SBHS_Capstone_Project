package com.swm.service;

import java.util.Date;
import java.util.List;

import org.springframework.lang.Nullable;

import com.swm.entity.BookingDepositEntity;
import com.swm.entity.BookingEntity;
import com.swm.entity.HomestayEntity;

public interface IBookingService {
	BookingEntity createBooking(BookingEntity bookingEntity);
	
	BookingEntity findBookingById(Long Id);
	
	List<BookingEntity> getBookingList();
	
	List<String> getHomestayBookingDate(Long bookingId);
	
	BookingEntity confirmBooking(Long BookingId, boolean isAccepted, @Nullable String rejectMessage);
	
	BookingEntity verifyBookingCheckIn(Long bookingId, String bookingOtp);
	
	BookingEntity checkOutRequest(Long bookingId, String paymentMethod);
	
	BookingDepositEntity payForBookingDeposit(Long bookingId, Long amount);
	
	BookingEntity passengerCancelBooking(Long bookingId);
	
	void confirmCheckIn(Long bookingId, boolean isAccepted);
	
	boolean isBookingDateValid(HomestayEntity homestayEntity ,Date checkIn, Date checkOut);
	
	BookingEntity deleteBooking(Long bookingId);

}
