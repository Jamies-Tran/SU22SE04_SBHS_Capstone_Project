package com.swm.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.swm.entity.RoleEntity;

public interface IRoleRepository extends JpaRepository<RoleEntity, Long> {
	
	@Query(value = "select * from roles r where r.name = :name", nativeQuery = true)
	Optional<RoleEntity> findRoleByName(@Param("name") String name);
}
