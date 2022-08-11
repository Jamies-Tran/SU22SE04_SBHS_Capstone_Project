package com.swm.service;

import com.swm.entity.BaseWalletEntity;
import com.swm.entity.UserEntity;
import com.swm.entity.UserOtpEntity;

public interface IUserService {
	BaseWalletEntity findSystemWalletByUsername(String wallet_type);
	
	UserEntity findUserById(Long Id);
	
	UserEntity findUserByUserInfo(String userInfo);
	
	UserOtpEntity findUserOtpByCode(String otp);
	
	UserEntity createPassengerUser(UserEntity userEntity);
	
	UserEntity createLandlordUser(UserEntity userEntity, String citizenIdentificationUrlFront, String citizenIdentificationUrlBack);
	
	UserEntity createAdminUser(UserEntity userEntity);
	
	UserOtpEntity createUserOtpByUserInfo(String userInfo);
	
	boolean checkUserOtp(String userInfo, String userOtp);
	
	UserEntity changePassword(String userInfo, String newPassword);
	
	void deleteUserOtp(UserOtpEntity useOtpEntity);
	
	
}
