package com.swm.dto.statistic;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class SystemStatisticDto {
	private Long Id;
	private Long totalHomestayRequest;
	private Long totalActiveHomestay;
	private Long totalRejectedHomestay;
	private Long totalProfit;
	private Long totalLandlordRequest;
	private Long totalActiveLandlord;
	private Long totalRejectedLandlordRequest;	
	private String statisticTime;
}
