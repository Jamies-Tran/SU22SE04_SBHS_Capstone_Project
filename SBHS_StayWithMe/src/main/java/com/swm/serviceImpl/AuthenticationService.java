package com.swm.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.swm.exception.ResourceNotAllowException;
import com.swm.exception.UsernamePasswordNotCorrectException;
import com.swm.service.IAuthenticationService;

@Service
public class AuthenticationService implements IAuthenticationService {

	@Autowired
	private UserDetailsService userDetailsService;
	
	@Autowired
	private AuthenticationManager authenticationManager;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Override
	public UserDetails loginAuthentication(String username, String password) {
		UserDetails userDetails = userDetailsService.loadUserByUsername(username);
		if(!userDetails.isEnabled()) {
			throw new ResourceNotAllowException(username, "account not active");
		} else if(!passwordEncoder.matches(password, userDetails.getPassword()))  {
			throw new UsernamePasswordNotCorrectException("Password not correct");
		}
		Authentication auth = authenticationManager.authenticate(
				new UsernamePasswordAuthenticationToken(username, password));
		SecurityContext context = SecurityContextHolder.createEmptyContext();
		context.setAuthentication(auth);
		SecurityContextHolder.setContext(context);
		return userDetails;
	}

	@Override
	public UserDetails getAuthenticatedUser() {
		UserDetails authenticatedUser = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		return authenticatedUser;
	}

}
