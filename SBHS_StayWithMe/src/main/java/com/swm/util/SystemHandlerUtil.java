package com.swm.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import com.swm.service.IBookingService;

@Configuration
@EnableScheduling
public class SystemHandlerUtil {
	
	@Autowired
	private IBookingService bookingService;
	
	@Scheduled(fixedDelay = 1000)
	public void cautionCheckInTask() {
		bookingService.remindPassengerBookingDate();
	}
	
	
}
