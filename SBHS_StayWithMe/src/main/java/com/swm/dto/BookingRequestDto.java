package com.swm.dto;

import java.util.List;

import org.springframework.lang.Nullable;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
public class BookingRequestDto {
	private String homestayName;
	@Nullable
	private List<HomestayAftercareDto> homestayServiceList;
	private String checkIn;
	private String checkOut;
}
