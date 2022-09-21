package com.swm.dto.booking;

import java.util.List;

import org.springframework.lang.Nullable;

import com.swm.dto.homestay.HomestayAftercareDto;

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
	private Long totalPrice;
	private Long deposit;
	private String checkIn;
	private String checkOut;
}
