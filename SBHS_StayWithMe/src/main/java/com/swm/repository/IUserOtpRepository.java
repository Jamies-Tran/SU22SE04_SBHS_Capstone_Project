package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.UserOtpEntity;

public interface IUserOtpRepository extends JpaRepository<UserOtpEntity, Long> {
	
}
