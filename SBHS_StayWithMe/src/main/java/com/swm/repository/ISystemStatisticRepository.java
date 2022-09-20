package com.swm.repository;

import java.util.Date;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.swm.entity.SystemStatisticEntity;

public interface ISystemStatisticRepository extends JpaRepository<SystemStatisticEntity, Long> {
	
	@Query(value = "select s from SystemStatisticEntity s where s.statisticTime = :date")
	Optional<SystemStatisticEntity> findSystemstatisticByDate(@Param("date") Date date);
	
}
