package com.swm.converter;

import java.text.SimpleDateFormat;

import org.springframework.stereotype.Component;

import com.swm.dto.PassengerCancelBookingTicketDto;
import com.swm.entity.PassengerCancelBookingTicketEntity;

@Component
public class PassengerCancelBookingTicketConverter {
	
	private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	public PassengerCancelBookingTicketDto cancelBookingToDto(PassengerCancelBookingTicketEntity cancelBookingTicketEntity) {
		PassengerCancelBookingTicketDto cancelBookingTicketDto = new PassengerCancelBookingTicketDto();
		cancelBookingTicketDto.setId(cancelBookingTicketEntity.getId());
		cancelBookingTicketDto.setFirstTimeCancelActive(cancelBookingTicketEntity.getFirstTimeCancelActive());
		cancelBookingTicketDto.setSecondTimeCancelActive(cancelBookingTicketEntity.getSecondTimeCancelActive());
		cancelBookingTicketDto.setActiveDate(simpleDateFormat.format(cancelBookingTicketEntity.getActiveDate()));
		
		return cancelBookingTicketDto;
	}
}
