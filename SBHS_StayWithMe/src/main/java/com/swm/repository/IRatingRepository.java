package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.RatingEntity;

public interface IRatingRepository extends JpaRepository<RatingEntity, Long> {
	
}
