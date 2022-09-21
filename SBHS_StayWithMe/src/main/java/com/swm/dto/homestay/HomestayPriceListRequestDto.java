package com.swm.dto.homestay;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class HomestayPriceListRequestDto {
	private Long Id;
	private Long price;
	private String type;
	private String specialDayCode;
}
