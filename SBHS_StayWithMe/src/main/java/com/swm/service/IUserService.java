package com.swm.service;

import com.swm.entity.UserEntity;

public interface IUserService {
	UserEntity findUserById(Long Id);
	
	UserEntity findUserByUsername(String username);
	
	UserEntity findUserByEmail(String email);
	
	UserEntity createPassengerUser(UserEntity userEntity);
	
	UserEntity createLandlordUser(UserEntity userEntity, String CitizenIdentificationUrl);
	
	UserEntity createAdminUser(UserEntity userEntity);
	
	void createUserOtpByUserInfo(String userInfo);
	
	boolean checkUserOtp(String userInfo, String userOtp);
	
}
