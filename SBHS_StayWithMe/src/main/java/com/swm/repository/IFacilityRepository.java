package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.HomestayCommonFacilityEntity;

public interface IFacilityRepository extends JpaRepository<HomestayCommonFacilityEntity, Long> {

}
