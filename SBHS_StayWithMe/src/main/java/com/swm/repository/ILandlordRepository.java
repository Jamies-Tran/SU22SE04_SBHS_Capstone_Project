package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.LandlordEntity;

public interface ILandlordRepository extends JpaRepository<LandlordEntity, Long> {

}
