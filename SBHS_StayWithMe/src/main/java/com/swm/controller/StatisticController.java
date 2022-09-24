package com.swm.controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.swm.converter.StatisticConverter;
import com.swm.dto.statistic.LandlordStatisticDto;
import com.swm.dto.statistic.SystemStatisticDto;
import com.swm.entity.LandlordStatisticEntity;
import com.swm.entity.SystemStatisticEntity;
import com.swm.service.ILandlordStatisticService;
import com.swm.service.ISystemStatisticService;
import com.swm.util.DateParsingUtil;

@RestController
@RequestMapping("/api/statistic")
public class StatisticController {
	
	@Autowired
	private ISystemStatisticService systemStatisticService;
	
	@Autowired
	private ILandlordStatisticService landlordStatisticService;
	
	@Autowired
	private StatisticConverter statisticConvert;
	
	@GetMapping("/system-statistic")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public ResponseEntity<?> getSystemStatisticByDateTime(@RequestParam String time) {
		Date statisticTime = DateParsingUtil.statisticYearMonthTime(DateParsingUtil.parseDateTimeStr(time));
		SystemStatisticEntity systemStatistic = systemStatisticService.findSystemStatisticByTime(statisticTime);
		SystemStatisticDto systemStatisticResponseDto = statisticConvert.systemStatisticDtoConvert(systemStatistic);
		
		return new ResponseEntity<>(systemStatisticResponseDto, HttpStatus.OK);
	}
	
	@GetMapping("/landlord-statistic")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_LANDLORD')")
	public ResponseEntity<?> getLandlordStatisticByDateTime(@RequestParam String time) {
		Date statisticTime = DateParsingUtil.statisticYearMonthTime(DateParsingUtil.parseDateTimeStr(time));
		LandlordStatisticEntity landlordStatistic = landlordStatisticService.findLandlordStatisticByTime(statisticTime);
		LandlordStatisticDto landlordStatisticDto = statisticConvert.landlordStatisticDtoConvert(landlordStatistic);
		
		return new ResponseEntity<>(landlordStatisticDto, HttpStatus.OK);
	}
}
