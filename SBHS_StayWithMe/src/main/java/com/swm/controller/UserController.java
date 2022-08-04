package com.swm.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import com.swm.dto.AuthenticationRequestDto;
import com.swm.dto.LandlordDto;
import com.swm.dto.AuthenticationResponseDto;
import com.swm.dto.PassengerDto;
import com.swm.dto.PasswordModificationDto;
import com.swm.dto.UserDto;
import com.swm.dto.UserOtpDto;
import com.swm.entity.BaseWalletEntity;
import com.swm.entity.UserEntity;
import com.swm.entity.UserOtpEntity;
import com.swm.security.token.JwtTokenUtil;
import com.swm.service.IAuthenticationService;
import com.swm.service.IUserService;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

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

	private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

	private Logger log = LoggerFactory.getLogger(UserController.class);

	@AllArgsConstructor
	@NoArgsConstructor
	@Getter
	@Setter
	public static class WalletReponseDto {
		private Long balance;
		private String owner;

	}

	@AllArgsConstructor
	@NoArgsConstructor
	@Getter
	@Setter
	public static class LandlordResponseDto {
		private Long id;
		private String username;
		private String avatarUrl;
		private String address;
		private String gender;
		private String dob;
		private String email;
		private String phone;
		private String citizenIdentificationString;
		private String citizenIdentificationUrlFront;
		private String citizenIdentificationUrlBack;
	}

	@PostMapping("/register/passenger")
	public ResponseEntity<?> createPassengerAccount(@RequestBody PassengerDto userDto) {
		log.info("Passenger information: " + userDto.getUsername());
		UserEntity userEntity = userConvert.passengerEntityConvert(userDto);
		UserEntity userPersisted = userService.createPassengerUser(userEntity);
		UserDto userResponse = userConvert.userResponseDtoConvert(userPersisted);

		return new ResponseEntity<>(userResponse, HttpStatus.CREATED);
	}

	@PostMapping("/register/landlord")
	public ResponseEntity<?> createLandlordAccount(@RequestBody LandlordDto userDto) {
		UserEntity userEntity = userConvert.landlordEntityConvert(userDto);
		String citizenIdentificationUrlFront = userDto.getCitizenIdentificationUrlFront();
		String citizenIdentificationUrlBack = userDto.getCitizenIdentificationUrlBack();
		UserEntity userPersisted = userService.createLandlordUser(userEntity, citizenIdentificationUrlFront,
				citizenIdentificationUrlBack);
		LandlordResponseDto landlordResponseDto = new LandlordResponseDto();
		landlordResponseDto.setAddress(userPersisted.getAddress());
		landlordResponseDto.setCitizenIdentificationString(userPersisted.getCitizenIdentificationString());
		landlordResponseDto.setCitizenIdentificationUrlBack(userDto.getCitizenIdentificationUrlBack());
		landlordResponseDto.setCitizenIdentificationUrlFront(userDto.getCitizenIdentificationUrlFront());
		landlordResponseDto.setEmail(userPersisted.getEmail());
		landlordResponseDto.setGender(userPersisted.getGender());
		landlordResponseDto.setId(userPersisted.getId());
		landlordResponseDto.setPhone(userPersisted.getPhone());
		landlordResponseDto.setUsername(userPersisted.getUsername());
		landlordResponseDto.setAvatarUrl(userPersisted.getAvatar().getUrl());
		landlordResponseDto.setDob(simpleDateFormat.format(userPersisted.getDob()));

		return new ResponseEntity<>(landlordResponseDto, HttpStatus.CREATED);
	}

	@PostMapping("/register/admin")
	public ResponseEntity<?> createAdminAccount(@RequestBody AdminDto adminDto) {
		UserEntity userEntity = userConvert.AdminEntityConvert(adminDto);
		UserEntity userPersisted = userService.createAdminUser(userEntity);
		UserDto userResponse = userConvert.userResponseDtoConvert(userPersisted);

		return new ResponseEntity<>(userResponse, HttpStatus.CREATED);
	}

	@PostMapping("/login")
	public ResponseEntity<?> webAccountLogin(@RequestBody AuthenticationRequestDto userLogin) {
		UserDetails userDetails = authenticationService.loginAuthentication(userLogin.getUserInfo(),
				userLogin.getPassword());

		String token = jwtUtil.generateJwtTokenString(userDetails.getUsername());
		UserEntity userEntiy = userService.findUserByUserInfo(userDetails.getUsername());
		AuthenticationResponseDto authenticationResponseDto = new AuthenticationResponseDto();
		authenticationResponseDto.setUsername(userEntiy.getUsername());
		authenticationResponseDto.setEmail(userEntiy.getEmail());
		authenticationResponseDto.setLoginDate(simpleDateFormat.format(new Date()));
		authenticationResponseDto.setToken(token);
		authenticationResponseDto.setRoles(userDetails.getAuthorities());

		return new ResponseEntity<>(authenticationResponseDto, HttpStatus.OK);

	}

	@GetMapping("/otp/{userInfo}")
	public ResponseEntity<?> createForgetPasswordOtp(@PathVariable("userInfo") String userInfo) {
		UserOtpEntity userOtpEntity = userService.createUserOtpByUserInfo(userInfo);
		UserEntity userEntity = userOtpEntity.getOtpOwner();
		UserDto userResponseDto = userConvert.userResponseDtoConvert(userEntity);

		return new ResponseEntity<>(userResponseDto, HttpStatus.CREATED);
	}

	@PostMapping("/otp/confirmation")
	public ResponseEntity<?> confirmUserOtpForgetPassword(@RequestBody UserOtpDto userOtpDto) {
		boolean isOtpCorrect = userService.checkUserOtp(userOtpDto.getUserInfo(), userOtpDto.getUserOtp());
		if (isOtpCorrect) {
			return new ResponseEntity<>(HttpStatus.ACCEPTED);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}

	@PostMapping("/password/modification")
	public ResponseEntity<?> changeUserPassword(@RequestBody PasswordModificationDto passwordModificationDto) {
		UserEntity userEntity = userService.changePassword(passwordModificationDto.getUserInfo(),
				passwordModificationDto.getNewPassword());
		UserDto userResponseDto = userConvert.userResponseDtoConvert(userEntity);

		return new ResponseEntity<>(userResponseDto, HttpStatus.OK);
	}

	@GetMapping("/exist/{userInfo}")
	public ResponseEntity<?> checkGmailExist(@PathVariable("userInfo") String userInfo) {
		boolean test = userService.checkUserDuplicate(userInfo);
		log.info("Is duplicate?: " + test);

		return new ResponseEntity<>(HttpStatus.OK);
	}

	@GetMapping("/get/{userInfo}")
	public ResponseEntity<?> getUserByUserInfo(@PathVariable("userInfo") String userInfo) {
		UserEntity userEntity = userService.findUserByUserInfo(userInfo);
		if(userEntity.getLandlord() == null) {
			UserDto userResponseDto = userConvert.userResponseDtoConvert(userEntity);
			
			return new ResponseEntity<>(userResponseDto, HttpStatus.OK);
		} else {
			LandlordResponseDto landlordResponseDto = new LandlordResponseDto();
			landlordResponseDto.setAddress(userEntity.getAddress());
			landlordResponseDto.setCitizenIdentificationString(userEntity.getCitizenIdentificationString());
			landlordResponseDto.setCitizenIdentificationUrlBack(userEntity.getLandlord().getCitizenIdentificationUrl().get(1).getUrl());
			landlordResponseDto.setCitizenIdentificationUrlFront(userEntity.getLandlord().getCitizenIdentificationUrl().get(0).getUrl());
			landlordResponseDto.setEmail(userEntity.getEmail());
			landlordResponseDto.setGender(userEntity.getGender());
			landlordResponseDto.setId(userEntity.getId());
			landlordResponseDto.setPhone(userEntity.getPhone());
			landlordResponseDto.setUsername(userEntity.getUsername());
			landlordResponseDto.setAvatarUrl(userEntity.getAvatar().getUrl());
			landlordResponseDto.setDob(simpleDateFormat.format(userEntity.getDob()));
			
			
			return new ResponseEntity<>(landlordResponseDto, HttpStatus.OK);
		}

		
	}

	@GetMapping("/get/wallet/{walletType}")
	public ResponseEntity<?> getWalletBalance(@PathVariable("walletType") String walletType) {
		BaseWalletEntity baseWalletEntity = userService.findSystemWalletByUsername(walletType);
		WalletReponseDto walletResponseDto = new WalletReponseDto();
		walletResponseDto.setOwner(baseWalletEntity.getCreatedBy());
		walletResponseDto.setBalance(baseWalletEntity.getBalance());

		return new ResponseEntity<>(walletResponseDto, HttpStatus.OK);

	}

}
