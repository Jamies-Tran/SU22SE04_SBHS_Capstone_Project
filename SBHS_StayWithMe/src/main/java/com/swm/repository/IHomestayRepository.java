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
	Page<HomestayEntity> homestayPagination(Pageable pageable, @Param("status") String status);
	
	@Query(value = "select h from HomestayEntity h where h.averagePrice >= :lowestPrice and h.averagePrice <= :highestPrice")
	Page<HomestayEntity> homestayFilterByPricePagination(Pageable pageable, @Param("lowestPrice") Long lowestPrice, @Param("highestPrice") Long highestPrice);
	
	@Query(value = "select h from HomestayEntity h where h.name like %:filterStr% or h.address like %:filterStr% or h.landlordOwner.landlordAccount.username like %:filterStr% and h.status = :status")
	Page<HomestayEntity> homestayFilterByStringPagination(Pageable pageable, @Param("filterStr") String filterStr, @Param("status") String status);
	
	@Query(value = "select h from HomestayEntity h where h.averagePrice >= :lowestPrice")
	Page<HomestayEntity> homestayFilterByLowestPrice(Pageable pageable, @Param("lowestPrice") Long lowestPrice);
	
	@Query(value = "select h from HomestayEntity h where h.averagePrice <= :highestPrice")
	Page<HomestayEntity> homestayFilterByHighestPrice(Pageable pageable, @Param("highestPrice") Long highestPrice);
	
	@Query(value = "select h from HomestayEntity h where h.address like %:address%")
	Optional<HomestayEntity> findHomestayByAddress(@Param("address") String address);
}
