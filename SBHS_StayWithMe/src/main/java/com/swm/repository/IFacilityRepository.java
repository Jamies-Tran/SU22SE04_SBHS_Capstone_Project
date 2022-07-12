package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.HomestayFacilityEntity;

public interface IFacilityRepository extends JpaRepository<HomestayFacilityEntity, Long> {

}
