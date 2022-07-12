package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.BookingEntity;

public interface IBookingRepository extends JpaRepository<BookingEntity, Long> {

}
