package com.swm.dto.statistic;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class LandlordStatisticDto {
	private Long Id;
	private Long totalSuccessBooking;
	private Long totalCancelBooking;
	private Long totalProfit;
	private Long totalCommissionProfit;
	private String statisticTime;
}
