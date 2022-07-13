package com.swm.converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import com.swm.dto.BookingRequestDto;
import com.swm.dto.BookingResponseDto;
import com.swm.dto.HomestayAftercareDto;
import com.swm.entity.BookingEntity;
import com.swm.entity.HomestayAftercareEntity;
import com.swm.exception.ParseDateException;
import com.swm.service.IHomestayService;
import com.swm.service.IUserService;
import com.swm.serviceImpl.HomestayAftercareService;

@Component
public class BookingConverter {

	@Autowired
	@Lazy
	private IUserService userService;

	@Autowired
	@Lazy
	private IHomestayService homestayService;

	@Autowired
	private HomestayConverter homestayConvert;

	private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

	@Autowired
	private HomestayAftercareService homestayAftercareService;
	
	public BookingEntity bookingToEntity(BookingRequestDto bookingDto) {
		BookingEntity bookingEntity = new BookingEntity();
		bookingEntity.setBookingCreator(userService.findUserByUserInfo(bookingDto.getPassengerName()).getPassenger());
		bookingEntity.setBookingHomestay(homestayService.findHomestayByName(bookingDto.getHomestayName()));
		bookingDto.getHomestayServiceDto().forEach(s -> System.err.println(s.getName()));
		List<HomestayAftercareEntity> homestayServiceList = bookingDto.getHomestayServiceDto().stream()
				.map(s -> homestayAftercareService.findHomestayServiceByName(s.getName())).collect(Collectors.toList());
		bookingEntity.setHomestayServiceBooking(homestayServiceList);
		try {
			Date checkIn = simpleDateFormat.parse(bookingDto.getCheckIn());
			bookingEntity.setCheckIn(checkIn);
		} catch (ParseException e) {
			throw new ParseDateException(bookingDto.getCheckIn());
		}
		try {
			Date checkOut = simpleDateFormat.parse(bookingDto.getCheckOut());
			bookingEntity.setCheckOut(checkOut);
		} catch (ParseException e) {
			throw new ParseDateException(bookingDto.getCheckOut());
		}

		return bookingEntity;
	}

	public BookingResponseDto bookingToDto(BookingEntity bookingEntity) {
		BookingResponseDto bookingDto = new BookingResponseDto();
		bookingDto.setId(bookingEntity.getId());
		bookingDto.setPassengerName(bookingEntity.getBookingCreator().getPassengerAccount().getUsername());
		bookingDto.setHomestayName(bookingEntity.getBookingHomestay().getName());
		List<HomestayAftercareDto> homestayServiceList = bookingEntity.getHomestayServiceBooking().stream()
				.map(s -> homestayConvert.homestayAftercareDtoConvert(s)).collect(Collectors.toList());
		bookingDto.setHomestayServiceDto(homestayServiceList);
		bookingDto.setCheckIn(bookingEntity.getCheckIn().toString());
		bookingDto.setCheckOut(bookingEntity.getCheckOut().toString());
		bookingDto.setTotalPrice(bookingEntity.getTotalPrice());
		long deposit = bookingEntity.getTotalPrice() * 50 / 100;
		bookingDto.setDeposit(deposit);
		
		return bookingDto;
	}
}
