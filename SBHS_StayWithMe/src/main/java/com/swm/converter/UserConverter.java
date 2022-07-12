package com.swm.converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.swm.dto.AdminDto;
import com.swm.dto.LandlordDto;
import com.swm.dto.PassengerDto;
import com.swm.dto.UserDto;
import com.swm.entity.AvatarEntity;
import com.swm.entity.RoleEntity;
import com.swm.entity.UserEntity;
import com.swm.enums.AccountRole;
import com.swm.exception.ParseDateException;
import com.swm.service.IRoleService;

@Component
public class UserConverter {

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private IRoleService roleService;
	
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

	public UserEntity passengerEntityConvert(PassengerDto passengerDto) {
		UserEntity userEntity = new UserEntity();
		try {
			userEntity.setUsername(passengerDto.getUsername());
			userEntity.setPassword(passwordEncoder.encode(passengerDto.getPassword()));
			userEntity.setAddress(passengerDto.getAddress());
			userEntity.setGender(passengerDto.getGender());
			userEntity.setEmail(passengerDto.getEmail());
			userEntity.setPhone(passengerDto.getPhone());
			userEntity.setCitizenIdentificationString(passengerDto.getCitizenIdentificationString());
			userEntity.setDob(dateFormat.parse(passengerDto.getDob()));
			userEntity.setAvatar(new AvatarEntity(passengerDto.getAvatarUrl()));
			RoleEntity passengerRole = roleService.findRoleByName(AccountRole.PASSENGER.name());
			userEntity.setRoles(List.of(passengerRole));
			
			return userEntity;
		} catch (ParseException e) {
			throw new ParseDateException(passengerDto.getDob());
		}
	}
	
	public UserEntity landlordEntityConvert(LandlordDto landlordDto) {
		UserEntity userEntity = new UserEntity();
		
		try {
			userEntity.setUsername(landlordDto.getUsername());
			userEntity.setPassword(passwordEncoder.encode(landlordDto.getPassword()));
			userEntity.setAddress(landlordDto.getAddress());
			userEntity.setGender(landlordDto.getGender());
			userEntity.setEmail(landlordDto.getEmail());
			userEntity.setPhone(landlordDto.getPhone());
			userEntity.setDob(dateFormat.parse(landlordDto.getDob()));
			userEntity.setCitizenIdentificationString(landlordDto.getCitizenIdentificationString());
			userEntity.setDob(dateFormat.parse(landlordDto.getDob()));
			userEntity.setAvatar(new AvatarEntity(landlordDto.getAvatarUrl()));
			RoleEntity landlordRole = roleService.findRoleByName(AccountRole.LANDLORD.name());
			userEntity.setRoles(List.of(landlordRole));
			
			return userEntity;
		} catch (ParseException e) {
			throw new ParseDateException(landlordDto.getDob());		}
	}
	
	public UserEntity AdminEntityConvert(AdminDto adminDto) {
		UserEntity adminEntity = new UserEntity();
		try {
			adminEntity.setUsername(adminDto.getUsername());
			adminEntity.setPassword(passwordEncoder.encode(adminDto.getPassword()));
			adminEntity.setAddress(adminDto.getAddress());
			adminEntity.setGender(adminDto.getGender());
			adminEntity.setEmail(adminDto.getEmail());
			adminEntity.setPhone(adminDto.getPhone());
			adminEntity.setCitizenIdentificationString(adminDto.getCitizenIdentificationString());
			adminEntity.setDob(dateFormat.parse(adminDto.getDob()));
			adminEntity.setAvatar(new AvatarEntity(adminDto.getAvatarUrl()));
			RoleEntity adminRole = roleService.findRoleByName(AccountRole.ADMIN.name());
			adminEntity.setRoles(List.of(adminRole));

			return adminEntity;
		} catch (ParseException e) {
			throw new ParseDateException(adminDto.getDob());
		}
	}
	

	public UserDto userResponseDtoConvert(UserEntity userEntity) {
		UserDto userDto = new UserDto();
		userDto.setId(userEntity.getId());
		userDto.setUsername(userEntity.getUsername());
		userDto.setAddress(userEntity.getAddress());
		userDto.setGender(userEntity.getGender());
		userDto.setEmail(userEntity.getEmail());
		userDto.setPhone(userEntity.getPhone());
		userDto.setCitizenIdentificationString(userEntity.getCitizenIdentificationString());
		userDto.setDob(dateFormat.format(userEntity.getDob()));
		userDto.setAvatarUrl(userEntity.getAvatar().getUrl());
		
		return userDto;
	}
	
	
}
