package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.swm.entity.HomestayImageEntity;

public interface IHomestayImageRepository extends JpaRepository<HomestayImageEntity, Long> {
	
	@Modifying
	@Query(value = "delete from HomestayImageEntity i where i.homestayImage.Id = :homestayId and i.homestayImageUpdateRequest = null")
	void clearOldHomestayImage(@Param("homestayId") Long homestayId);
}
