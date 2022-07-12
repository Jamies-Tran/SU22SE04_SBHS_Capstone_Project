package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.swm.entity.PromotionEntity;

public interface IPromotionRepository extends JpaRepository<PromotionEntity, Long> {
	
	@Query(value = "select * from promotion p where p.code = :promotionCode", nativeQuery = true)
	PromotionEntity findPromotionByCode(@Param("promotionCode") String promotionCode);
}
