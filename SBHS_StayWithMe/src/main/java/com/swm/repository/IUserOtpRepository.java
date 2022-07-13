package com.swm.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.swm.entity.UserOtpEntity;

public interface IUserOtpRepository extends JpaRepository<UserOtpEntity, Long> {
	
	@Query(value = "select userOtp from UserOtpEntity userOtp where userOtp.code = :code")
	Optional<UserOtpEntity> findUserOtpByUserCode(@Param("code") String otp);

}
