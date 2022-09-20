package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.swm.entity.HomestayCommonFacilityEntity;

public interface IHomestayCommonFacilityRepository extends JpaRepository<HomestayCommonFacilityEntity, Long> {
	
	@Modifying
	@Query(value = "delete from HomestayCommonFacilityEntity c where c.homestayCommonFacility.Id = :homestayId and c.homestayCommonFacilityUpdateRequest = null")
	void clearOldHomestayCommonFacility(@Param("homestayId") Long homestayId);
}
