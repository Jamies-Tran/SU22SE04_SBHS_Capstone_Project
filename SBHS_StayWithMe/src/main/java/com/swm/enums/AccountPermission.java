package com.swm.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
public enum AccountPermission {
	HOMESTAY_REGISTER("homestay:register"),
	HOMESTAY_VIEW("homestay:view"),
	HOMESTAY_DELETE("homestay:delete"),
	HOMESTAY_UPDATE("homestay:update"),
	BOOKING_CREATE("booking:create"),
	BOOKING_VIEW("booking:view"),
	BOOKING_UPDATE("booking:update"),
	BOOKING_DELETE("booking:delete"),
	ACCOUNT_BAN("account:ban");
	
	@Getter
	@Setter
	private String permission;
}
