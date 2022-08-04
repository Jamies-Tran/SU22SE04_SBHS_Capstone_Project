package com.swm.security.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.context.annotation.Bean;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.swm.filter.JwtAuthenticationFilter;

@EnableWebSecurity
@Configurable
@EnableMethodSecurity(prePostEnabled = true)
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

	@Autowired
	private UserDetailsService userDetailsService;
	
	@Bean
	public JwtAuthenticationFilter jwtAuthenticationFilter() {
		return new JwtAuthenticationFilter();
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService).passwordEncoder(this.passwordEncoder());
	}

	

	@Override
	@Bean
	protected AuthenticationManager authenticationManager() throws Exception {
		// TODO Auto-generated method stub
		return super.authenticationManager();
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
		  		.cors()
		  		.and()
		  		.csrf().disable()
		  		.addFilterBefore(jwtAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class)
		  		.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
		  		.and()
		  		.authorizeRequests()
		  		.antMatchers(
		  				"/api/user/**", "/api/user/register/*", "/api/homestay/permit-all/**", "/api/booking/permit-all/**",
		  				"/api/user/login/*", "/swagger-ui/*", "/v3/api-docs", "/v3/api-docs/swagger-config", 
		  				"/api/payment", "/api/payment/**",
		  				"/checkin/redirect/**", "/checkin/confirm", "/momo/redirect", "/background/*", 
		  				"/favicon.ico",  "/error", "/role").permitAll()
		  		.anyRequest().authenticated();
	}
	
	
	
}
