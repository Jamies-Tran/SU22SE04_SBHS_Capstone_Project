package com.swm.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.swm.entity.UserEntity;

public interface IUserRepository extends JpaRepository<UserEntity, Long> {
	
	@Query(value = "select u from UserEntity u where u.username = :username")
	Optional<UserEntity> findUserByUsername(@Param("username") String username);
	
	@Query(value = "select u from UserEntity u where u.email = :email")
	Optional<UserEntity> findUserByEmail(@Param("email") String email);
	
	@Query(value = "select u from UserEntity u where u.phone = :phone")
	Optional<UserEntity> findUserByPhone(@Param("phone") String phone);
}
