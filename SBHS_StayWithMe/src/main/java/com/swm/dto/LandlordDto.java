package com.swm.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class LandlordDto extends UserDto {	
	private String citizenIdentificationUrlFront;
	private String citizenIdentificationUrlBack;
}
