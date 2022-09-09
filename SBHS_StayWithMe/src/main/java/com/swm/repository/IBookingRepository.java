package com.swm.repository;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.swm.entity.BookingEntity;

public interface IBookingRepository extends JpaRepository<BookingEntity, Long> {
	
	@Query(value = "select be from BookingEntity be where be.bookingOtp.code = :bookingOtp")
	Optional<BookingEntity> findBookingByOtp(@Param("bookingOtp") String bookingOtp);
	
	@Query(value = "select b from BookingEntity b")
	Page<BookingEntity> bookingPaging(Pageable page);
}
