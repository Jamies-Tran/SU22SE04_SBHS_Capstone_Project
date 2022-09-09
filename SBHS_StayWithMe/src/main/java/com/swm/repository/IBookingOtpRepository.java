package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.swm.entity.BookingOtpEntity;

public interface IBookingOtpRepository extends JpaRepository<BookingOtpEntity, Long> {
	
	@Query(value = "select bo from BookingOtpEntity bo where bo.passengerName = :passengerName")
	BookingOtpEntity findBookingOtpByPassengerName(@Param("passengerName") String passengerName);
}
