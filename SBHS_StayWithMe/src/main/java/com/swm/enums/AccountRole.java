package com.swm.enums;

import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.google.common.collect.Sets;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
public enum AccountRole {
	PASSENGER(new HashSet<AccountPermission>(Sets.newHashSet(AccountPermission.BOOKING_CREATE,
			AccountPermission.BOOKING_DELETE, AccountPermission.BOOKING_UPDATE, AccountPermission.BOOKING_VIEW,
			AccountPermission.HOMESTAY_VIEW, AccountPermission.WALLET_VIEW, AccountPermission.WALLET_UPDATE))),
	LANDLORD(new HashSet<AccountPermission>(Sets.newHashSet(AccountPermission.BOOKING_VIEW,
			AccountPermission.BOOKING_UPDATE, AccountPermission.BOOKING_DELETE, AccountPermission.HOMESTAY_REGISTER,
			AccountPermission.HOMESTAY_VIEW, AccountPermission.HOMESTAY_UPDATE, AccountPermission.HOMESTAY_DELETE,
			AccountPermission.WALLET_VIEW, AccountPermission.WALLET_UPDATE))),
	ADMIN(new HashSet<AccountPermission>(Sets.newHashSet(AccountPermission.ACCOUNT_BAN, AccountPermission.HOMESTAY_VIEW,
			AccountPermission.BOOKING_VIEW)));

	@Getter
	@Setter
	private Set<AccountPermission> accountPermission;

	public Set<SimpleGrantedAuthority> getAuthorities() {
		Set<SimpleGrantedAuthority> authority = this.accountPermission.stream()
				.map(p -> new SimpleGrantedAuthority(p.getPermission())).collect(Collectors.toSet());
		authority.add(new SimpleGrantedAuthority("ROLE_" + this.name()));
		return authority;
	}

}
