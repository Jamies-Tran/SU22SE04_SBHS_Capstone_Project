package com.swm.dto.user;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UserRatingDto {
	private Long Id;
	private double convenientPoint;
	private double securityPoint;
	private double positionPoint;
	private String homestayName;
}
