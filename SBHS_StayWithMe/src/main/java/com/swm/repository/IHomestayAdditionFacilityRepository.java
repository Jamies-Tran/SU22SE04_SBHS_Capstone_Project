package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.swm.entity.HomestayAdditionalFacilityEntity;

public interface IHomestayAdditionFacilityRepository extends JpaRepository<HomestayAdditionalFacilityEntity, Long> {
	
	@Modifying
	@Query(value = "delete from HomestayAdditionalFacilityEntity a where a.homestayAdditionalFacility.Id = :homestayId and a.homestayAdditionalFacilityUpdateRequest = null")
	void clearOldHomestayAdditionalFacility(@Param("homestayId") Long homestayId);
}
