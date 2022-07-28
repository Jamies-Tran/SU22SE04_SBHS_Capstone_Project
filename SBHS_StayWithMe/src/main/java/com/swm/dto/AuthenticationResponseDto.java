package com.swm.dto;

import java.util.Collection;
import java.util.Date;

import org.springframework.security.core.GrantedAuthority;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class AuthenticationResponseDto {
	private String username;
	private String email;
	private String loginDate;
	private String token;
	private Collection<? extends GrantedAuthority> roles;
}
