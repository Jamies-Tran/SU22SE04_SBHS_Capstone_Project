package com.swm.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.swm.entity.HomestayAftercareEntity;

public interface IHomestayAftercarerRepository extends JpaRepository<HomestayAftercareEntity, Long> {
	
	@Query(value = "select s from HomestayAftercareEntity s where s.serviceName = :serviceName")
	Optional<HomestayAftercareEntity> findHomestayServiceByName(@Param("serviceName") String serviceName);
}
