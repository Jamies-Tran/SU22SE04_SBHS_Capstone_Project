package com.swm.service;

import com.swm.entity.BookingOtpEntity;

public interface IBookingOtpService {
	BookingOtpEntity findBookingOtpByCode(String bookingOtp);
}
