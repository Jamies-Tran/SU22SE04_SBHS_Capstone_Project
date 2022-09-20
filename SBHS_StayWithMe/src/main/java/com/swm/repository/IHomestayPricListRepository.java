package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.swm.entity.HomestayPriceListEntity;

public interface IHomestayPricListRepository extends JpaRepository<HomestayPriceListEntity, Long> {

	@Modifying
	@Query(value = "delete from HomestayPriceListEntity h where h.homestayPriceList.Id = :homestayId and h.homestayPriceListUpdateRequest = null")
	void clearOldPriceList(@Param("homestayId") Long homestayId);
	
}
