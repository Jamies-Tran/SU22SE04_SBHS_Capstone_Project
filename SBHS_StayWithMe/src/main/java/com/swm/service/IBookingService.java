package com.swm.service;

import java.util.List;

import org.springframework.lang.Nullable;

import com.swm.entity.BookingDepositEntity;
import com.swm.entity.BookingEntity;
import com.swm.entity.PassengerCancelBookingTicketEntity;


public interface IBookingService {
	
	BookingEntity createBooking(BookingEntity bookingEntity);
	
	BookingEntity findBookingById(Long Id);
	
	BookingEntity findBookingByOtp(String otp);
	
	PassengerCancelBookingTicketEntity findPassengerCancelBookingTicketByBookingId(Long bookingId);
	
	List<BookingEntity> getHomestayBookingList(String homestayName, String status);
	
	List<BookingEntity> getUserBookingList(String status);
	
	List<BookingEntity> getBookingPage(int page, int size);
	
	BookingEntity confirmBooking(Long BookingId, boolean isAccepted, @Nullable String rejectMessage);
	
	BookingEntity checkInByPassengerOrLandlord(Long bookingId, String bookingOtp);
	
	BookingEntity checkInByPassengerRelative(String bookingOtp);
	
	BookingEntity checkOut(Long bookingId);
	
	BookingDepositEntity payForBookingDeposit(Long bookingId, Long amount);
	
	BookingEntity passengerCancelBooking(Long bookingId);
	
	void confirmCheckIn(Long bookingId, boolean isAccepted);
	
	BookingEntity deleteBooking(Long bookingId);
	
	public List<BookingEntity> getHomestayBookingListForLandlord(String homestayName, String status);
	
	void remindPassengerBookingDate();

}
