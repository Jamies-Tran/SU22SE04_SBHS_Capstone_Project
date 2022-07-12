package com.swm.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.swm.entity.HomestayEntity;
import com.swm.entity.HomestayPostingRequestEntity;

public interface IHomestayRepository extends JpaRepository<HomestayEntity, Long> {
	
	@Query(value = "select h from HomestayEntity h where h.name = :name")
	Optional<HomestayEntity> findHomestayByName(@Param("name") String name);
	
	@Query(value = "select h from HomestayEntity h where h.homestayPostingRequest = :homestayPostingRequest")
	Optional<HomestayEntity> findHomestayEntiyByRequestId(@Param("homestayPostingRequest") HomestayPostingRequestEntity request);
	
	@Query(value = "select h from HomestayEntity h where h.price between :lowerPrice and :higherPrice")
	List<HomestayEntity> findHomestayListBetweenPrice(@Param("lowerPrice") double lowerPrice, @Param("higherPrice") double higherPrice);
	
	@Query(value = "select h from HomestayEntity h where h.location like %:location%")
	List<HomestayEntity> findHomestayListContainLocation(@Param("location") String location);
}
