package com.swm.service;

import org.springframework.security.core.userdetails.UserDetails;

public interface IAuthenticationService {
	UserDetails loginAuthentication(String username, String password);
	
	UserDetails getAuthenticatedUser();
}
