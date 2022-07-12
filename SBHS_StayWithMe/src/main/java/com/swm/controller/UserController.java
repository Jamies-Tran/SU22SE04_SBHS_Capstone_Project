package com.swm.controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.swm.converter.UserConverter;
import com.swm.dto.AdminDto;
import com.swm.dto.AuthenticationDto;
import com.swm.dto.LandlordDto;
import com.swm.dto.LoginSuccessResponseDto;
import com.swm.dto.PassengerDto;
import com.swm.dto.UserDto;
import com.swm.dto.UserOtpDto;
import com.swm.entity.UserEntity;
import com.swm.security.token.JwtTokenUtil;
import com.swm.service.IAuthenticationService;
import com.swm.service.IUserService;

@RestController
@RequestMapping("/api/user")
public class UserController {

	@Autowired
	private IUserService userService;

	@Autowired
	private UserConverter userConvert;

	@Autowired
	private JwtTokenUtil jwtUtil;
	
	
	@Autowired
	private IAuthenticationService authenticationService;


	@PostMapping("/register/passenger")
	public ResponseEntity<?> createPassengerAccount(@RequestBody PassengerDto userDto) {
		UserEntity userEntity = userConvert.passengerEntityConvert(userDto);
		UserEntity userPersisted = userService.createPassengerUser(userEntity);
		UserDto userResponse = userConvert.userResponseDtoConvert(userPersisted);
		
		return new ResponseEntity<>(userResponse, HttpStatus.CREATED);
	}
	
	
	@PostMapping("/register/landlord")
	public ResponseEntity<?> createLandlordAccount(@RequestBody LandlordDto userDto) {
		UserEntity userEntity = userConvert.landlordEntityConvert(userDto);
		String citizenIdentificationUrl = userDto.getCitizenIdentificationUrl();
		UserEntity userPersisted = userService.createLandlordUser(userEntity, citizenIdentificationUrl);
		UserDto userResponse = userConvert.userResponseDtoConvert(userPersisted);
		
		return new ResponseEntity<>(userResponse, HttpStatus.CREATED);
	}
	
	@PostMapping("/register/admin")
	public ResponseEntity<?> createAdminAccount(@RequestBody AdminDto adminDto) {
		UserEntity userEntity = userConvert.AdminEntityConvert(adminDto);
		UserEntity userPersisted = userService.createAdminUser(userEntity);
		UserDto userResponse = userConvert.userResponseDtoConvert(userPersisted);
		
		return new ResponseEntity<>(userResponse, HttpStatus.CREATED);
	}
	
	@PostMapping("/login/web")
	public ResponseEntity<?> webAccountLogin(@RequestBody AuthenticationDto userLogin) {
		UserDetails userDetails = authenticationService.loginAuthentication(userLogin.getUsername(), userLogin.getPassword());
		
		
		String token = jwtUtil.generateJwtTokenString(userDetails.getUsername());
		return new ResponseEntity<>(new LoginSuccessResponseDto(userDetails.getUsername(), new Date(), token, userDetails.getAuthorities()), HttpStatus.OK);
		
	}
	
	@GetMapping("/otp/{userInfo}")
	public ResponseEntity<?> createForgetPasswordOtp(@PathVariable("userInfo") String userInfo) {
		userService.createUserOtpByUserInfo(userInfo);
		
		return new ResponseEntity<>(HttpStatus.CREATED);
	}
	
	@PostMapping("/otp/confirm")
	public ResponseEntity<?> confirmUserOtpForgetPassword(@RequestBody UserOtpDto userOtpDto) {
		boolean isOtpCorrect = userService.checkUserOtp(userOtpDto.getUserInfo(), userOtpDto.getUserOtp());
		if(isOtpCorrect) {
			return new ResponseEntity<>(HttpStatus.ACCEPTED);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}

}


