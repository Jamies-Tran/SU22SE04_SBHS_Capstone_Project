package com.swm.dto;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
public class BookingRequestDto {
	private String passengerName;
	private String homestayName;
	private List<HomestayAftercareDto> homestayServiceDto;
	private String checkIn;
	private String checkOut;
}
