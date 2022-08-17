package com.swm.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class HomestayPriceListResponseDto {
	private Long Id;
	private Long price;
	private String type;
	private SpecialDayPriceListDto specialDayList;
}
