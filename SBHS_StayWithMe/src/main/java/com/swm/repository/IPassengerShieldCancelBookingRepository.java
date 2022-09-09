package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.PassengerCancelBookingTicketEntity;

public interface IPassengerShieldCancelBookingRepository extends JpaRepository<PassengerCancelBookingTicketEntity, Long>{

}
