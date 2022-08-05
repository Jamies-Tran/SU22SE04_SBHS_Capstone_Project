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
	private String passengerPhone;
	private String passengerEmail;
	private String homestayName;
	private String homestayLocation;
	private String homestayCity;
	private String homestayOwner;
	private List<HomestayAftercareDto> homestayServiceList;
	private String checkIn;
	private String checkOut;
	private Long totalPrice;
	private String status;
	private Long deposit;
}
