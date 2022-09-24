package com.swm.converter;

import org.springframework.stereotype.Component;

import com.swm.dto.statistic.LandlordStatisticDto;
import com.swm.dto.statistic.SystemStatisticDto;
import com.swm.entity.LandlordStatisticEntity;
import com.swm.entity.SystemStatisticEntity;
import com.swm.util.DateParsingUtil;

@Component
public class StatisticConverter {
	public SystemStatisticDto systemStatisticDtoConvert(SystemStatisticEntity systemStatistic) {
		SystemStatisticDto systemStatisticDto = new SystemStatisticDto();
		systemStatisticDto.setId(systemStatistic.getId());
		systemStatisticDto.setTotalActiveHomestay(systemStatistic.getTotalActiveHomestay());
		systemStatisticDto.setTotalActiveLandlord(systemStatistic.getTotalActiveLandlord());
		systemStatisticDto.setTotalHomestayRequest(systemStatistic.getTotalHomestayRequest());
		systemStatisticDto.setTotalLandlordRequest(systemStatistic.getTotalLandlordRequest());
		systemStatisticDto.setTotalProfit(systemStatistic.getTotalProfit());
		systemStatisticDto.setTotalRejectedHomestay(systemStatistic.getTotalRejectedHomestay());
		systemStatisticDto.setTotalRejectedLandlordRequest(systemStatistic.getTotalRejectedLandlordRequest());
		systemStatisticDto.setStatisticTime(DateParsingUtil.parseDateTimeToStr(systemStatistic.getStatisticTime()));
		
		return systemStatisticDto;
	}
	
	public LandlordStatisticDto landlordStatisticDtoConvert(LandlordStatisticEntity landlordStatistic) {
		LandlordStatisticDto landlordStatisticDto = new LandlordStatisticDto();
		landlordStatisticDto.setId(landlordStatistic.getId());
		landlordStatisticDto.setTotalCancelBooking(landlordStatistic.getTotalCancelBooking());
		landlordStatisticDto.setTotalCommissionProfit(landlordStatistic.getTotalCommissionProfit());
		landlordStatisticDto.setTotalProfit(landlordStatistic.getTotalProfit());
		landlordStatisticDto.setTotalSuccessBooking(landlordStatistic.getTotalSuccessBooking());
		landlordStatisticDto.setStatisticTime(DateParsingUtil.parseDateTimeToStr(landlordStatistic.getStatisticTime()));
		
		return landlordStatisticDto;
	}
}
