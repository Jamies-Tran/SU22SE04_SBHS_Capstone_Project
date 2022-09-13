package com.swm.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class HomestayFilterDto {
	private String filterByStr;
	private Boolean filterByNewestPublishedDate;
	private Long lowestPrice;
	private Long highestPrice;
	private Boolean filterByHighestAveragePoint;
}
