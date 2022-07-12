package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.PassengerEntity;

public interface IPassengerRepository extends JpaRepository<PassengerEntity, Long> {

}
