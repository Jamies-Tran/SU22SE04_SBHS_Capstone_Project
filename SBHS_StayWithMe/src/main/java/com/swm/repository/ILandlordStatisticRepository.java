package com.swm.repository;

import java.util.Date;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.swm.entity.LandlordStatisticEntity;

public interface ILandlordStatisticRepository extends JpaRepository<LandlordStatisticEntity, Long>{
	
	@Query(value = "select l from LandlordStatisticEntity l where l.statisticTime = :date")
	Optional<LandlordStatisticEntity> findLandlordStatisticByTime(@Param("date") Date date);
}
