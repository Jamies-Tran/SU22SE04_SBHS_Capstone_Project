package com.swm.dto.homestay;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class HomestayCommonFacilityDto {
	private Long Id;
	private String name;
	private Integer amount;
}
