package com.swm.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class SpecialDayPriceListDto {
	private Long Id;
	private int startDay;
	private int endDay;
	private int startMonth;
	private int endMonth;
	private String description;
}
