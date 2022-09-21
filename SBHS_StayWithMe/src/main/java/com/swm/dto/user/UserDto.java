package com.swm.dto.user;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UserDto {
	private Long Id;
	private String username;
	private String password;
	private String address;
	private String gender;
	private String email;
	private String phone;
	private String citizenIdentificationString;
	private String dob;
	private String avatarUrl;
}


