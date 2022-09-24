package com.swm.dto.homestay;

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
	private Long lowestPrice;
	private Long highestPrice;
	private Boolean filterByTrending;
	private Boolean filterByNewestPublishedDate;
	private Boolean filterByHighestAveragePoint;
	private Boolean filterByNearestPlace;
}
