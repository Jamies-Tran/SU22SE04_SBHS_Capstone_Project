package com.swm.security.userdetail;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.swm.entity.UserEntity;
import com.swm.enums.AccountRole;
import com.swm.enums.UserStatus;
import com.swm.service.IUserService;

@Component
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private IUserService userService;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserEntity user = this.userService.findUserByUserInfo(username);
		Set<SimpleGrantedAuthority> authorities = new HashSet<SimpleGrantedAuthority>();
		user.getRoles().forEach(r -> {
			authorities.addAll(AccountRole.valueOf(r.getName()).getAuthorities());
		});
		boolean isDisable = user.getStatus().compareTo(UserStatus.ACTIVE.name()) != 0;

		return User.builder().username(user.getUsername()).password(user.getPassword()).authorities(authorities)
				.disabled(isDisable).build();
	}

}
