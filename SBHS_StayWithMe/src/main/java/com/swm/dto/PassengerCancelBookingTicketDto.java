package com.swm.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class PassengerCancelBookingTicketDto {
	private Long id;
	private Boolean firstTimeCancelActive;
	private Boolean secondTimeCancelActive;
	private String activeDate;
}
