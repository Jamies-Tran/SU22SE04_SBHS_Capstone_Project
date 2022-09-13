package com.swm.repository;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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

	@Query(value = "select h from HomestayEntity h where h.status = :status")
	Page<HomestayEntity> homestayPageable(Pageable pageable, @Param("status") String status);
}
