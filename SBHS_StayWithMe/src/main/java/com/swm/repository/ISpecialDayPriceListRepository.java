package com.swm.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.swm.entity.SpecialDayPriceListEntity;

public interface ISpecialDayPriceListRepository extends JpaRepository<SpecialDayPriceListEntity, Long> {
	
	@Query(value = "select s from SpecialDayPriceListEntity s where s.specialDayCode = :code")
	Optional<SpecialDayPriceListEntity> findSpecialDayByCode(@Param("code") String specialDayCode);
}
