package com.swm.converter;

import java.text.SimpleDateFormat;
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
import com.swm.entity.HomestayEntity;
import com.swm.service.IHomestayService;
import com.swm.service.IUserService;
import com.swm.serviceImpl.HomestayAftercareService;
import com.swm.util.DateParsingUtil;

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
		HomestayEntity homestayEntity = homestayService.findHomestayByName(bookingDto.getHomestayName());
		bookingEntity.setBookingHomestay(homestayEntity);
		bookingEntity.setTotalPrice(bookingDto.getTotalPrice());
		bookingEntity.setDeposit(bookingDto.getDeposit());
		if(bookingDto.getHomestayServiceList() != null) {
			List<HomestayAftercareEntity> homestayServiceList = bookingDto.getHomestayServiceList().stream()
					.map(s -> homestayAftercareService.findHomestayServiceByName(s.getName(), bookingDto.getHomestayName())).collect(Collectors.toList());
			bookingEntity.setHomestayServiceBooking(homestayServiceList);
		}
		bookingEntity.setCheckIn(DateParsingUtil.parseDateTimeStr(bookingDto.getCheckIn()));
		bookingEntity.setCheckOut(DateParsingUtil.parseDateTimeStr(bookingDto.getCheckOut()));
		

		return bookingEntity;
	}

	public BookingResponseDto bookingToDto(BookingEntity bookingEntity) {
		BookingResponseDto bookingDto = new BookingResponseDto();
		bookingDto.setId(bookingEntity.getId());
		bookingDto.setPassengerName(bookingEntity.getBookingCreator().getPassengerAccount().getUsername());
		bookingDto.setPassengerPhone(bookingEntity.getBookingCreator().getPassengerAccount().getPhone());
		bookingDto.setPassengerEmail(bookingEntity.getBookingCreator().getPassengerAccount().getEmail());
		bookingDto.setHomestayName(bookingEntity.getBookingHomestay().getName());
		bookingDto.setHomestayLocation(bookingEntity.getBookingHomestay().getAddress());
		bookingDto.setHomestayCity(bookingEntity.getBookingHomestay().getCity());
		bookingDto.setHomestayAverageRating(bookingEntity.getBookingHomestay().getAverage());
		bookingDto.setHomestayOwner(bookingEntity.getBookingHomestay().getLandlordOwner().getLandlordAccount().getUsername());
		bookingDto.setHomestayOwnerPhone(bookingEntity.getBookingHomestay().getLandlordOwner().getLandlordAccount().getPhone());
		bookingDto.setHomestayOwnerEmail(bookingEntity.getBookingHomestay().getLandlordOwner().getLandlordAccount().getEmail());
		if(bookingEntity.getHomestayServiceBooking() != null) {
			List<HomestayAftercareDto> homestayServiceList = bookingEntity.getHomestayServiceBooking().stream()
					.map(s -> homestayConvert.homestayAftercareDtoConvert(s)).collect(Collectors.toList());
			bookingDto.setHomestayServiceList(homestayServiceList);
		}
		bookingDto.setCheckIn(simpleDateFormat.format(bookingEntity.getCheckIn()));
		bookingDto.setCheckOut(simpleDateFormat.format(bookingEntity.getCheckOut()));
		bookingDto.setTotalPrice(bookingEntity.getTotalPrice());
		long deposit = bookingEntity.getTotalPrice() * 50 / 100;
		bookingDto.setDeposit(deposit);
		bookingDto.setStatus(bookingEntity.getStatus());
		bookingDto.setBookingOtp(bookingEntity.getBookingOtp().getCode());
		
		return bookingDto;
	}
}
