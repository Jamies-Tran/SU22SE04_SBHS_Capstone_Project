package com.swm.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import com.swm.service.IBookingService;
import com.swm.service.ILandlordStatisticService;
import com.swm.service.IRequestService;
import com.swm.service.ISystemStatisticService;

@Configuration
@EnableScheduling
public class SystemHandlerUtil {
	
	@Autowired
	private IBookingService bookingService;
	
	@Autowired
	private IRequestService requestService;
	
	@Autowired
	private ISystemStatisticService systemStatisticService;
	
	@Autowired
	private ILandlordStatisticService landlordStatisticService;
	
	@Scheduled(fixedDelay = 1000)
	public void cautionCheckInTask() {
		bookingService.remindPassengerBookingDate();
	}
	
	@Scheduled(fixedDelay = 5000)
	public void autoAcceptHomestayUpdateRequest() {
		requestService.autoAcceptHomestayUpdateRequest();
	}
	
	@Scheduled(fixedDelay = 5000)
	public void autoDeleteHomestayUpdateRequest() {
		requestService.autoDeleteHomestayUpdateRequest();
	}
	
	@Scheduled(fixedDelay = 5000)
	public void autoCreateStatistic() {
		systemStatisticService.createSystemStatistic();
		landlordStatisticService.createLandlordStatistic();
	}
}
