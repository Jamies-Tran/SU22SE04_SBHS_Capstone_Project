package com.swm.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class BookingResponseDto {
	private Long Id;
	private String passengerName;
	private String homestayName;
	private List<HomestayAftercareDto> homestayServiceDto;
	private String checkIn;
	private String checkOut;
	private Long totalPrice;
	private Long deposit;
}
