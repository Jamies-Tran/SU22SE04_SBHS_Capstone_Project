package com.swm.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.filter.OncePerRequestFilter;

import com.swm.exception.JwtTokenException;
import com.swm.exception.ResourceNotAllowException;
import com.swm.exception.UsernamePasswordNotCorrectException;
import com.swm.security.token.JwtTokenUtil;


public class JwtAuthenticationFilter extends OncePerRequestFilter {

	@Autowired
	private UserDetailsService userDetailsService;
	
	@Autowired
	private JwtTokenUtil jwtUtil;
	
	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		try {
			String getTokenString = jwtUtil.getJwtTokenStringFromRequestHeader(request);
			String username = jwtUtil.getUsernameFromToken(getTokenString);
			UserDetails userDetails = userDetailsService.loadUserByUsername(username);
			if(jwtUtil.validateJwtTokenString(getTokenString)) {
				UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(userDetails, 
						null, userDetails.getAuthorities());
				SecurityContext context = SecurityContextHolder.createEmptyContext();
				context.setAuthentication(authToken);
				SecurityContextHolder.setContext(context);
			} else  {
				throw new ResourceNotAllowException(username, "account not active");
			}
		} catch (JwtTokenException e) {
			System.err.println(e.getMessage());
			SecurityContextHolder.clearContext();
		}
		
		filterChain.doFilter(request, response);
	}

}
