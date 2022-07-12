package com.swm.serviceImpl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import com.swm.entity.BookingDepositEntity;
import com.swm.entity.BookingEntity;
import com.swm.entity.BookingOtpEntity;
import com.swm.entity.HomestayAftercareEntity;
import com.swm.entity.HomestayEntity;
import com.swm.entity.PassengerEntity;
import com.swm.enums.BookingStatus;
import com.swm.enums.HomestayStatus;
import com.swm.exception.ResourceNotAllowException;
import com.swm.exception.ResourceNotFoundException;
import com.swm.repository.IBookingRepository;
import com.swm.service.IBookingService;
import com.swm.service.IHomestayService;
import com.swm.service.IUserService;

import net.bytebuddy.utility.RandomString;

@Service
public class BookingService implements IBookingService {

	@Autowired
	private IBookingRepository bookingRepo;

	@Autowired
	@Lazy
	private IUserService userServcie;

	@Autowired
	@Lazy
	private IHomestayService homestayService;

	private Date currentDate = new Date();

	@Override
	public BookingEntity createBooking(BookingEntity bookingEntity) {
		// BookingEntity bookingEntity = new BookingEntity();
		// UserEntity userEntity = userServcie.findUserByUsername(passengerName);
		// PassengerEntity passengerEntity = userEntity.getPassenger();
		PassengerEntity passengerEntity = bookingEntity.getBookingCreator();
		passengerEntity.setBooking(List.of(bookingEntity));
		// HomestayEntity homestayEntity =
		// homestayService.findHomestayByName(homestayName);
		HomestayEntity homestayEntity = bookingEntity.getBookingHomestay();
		if(!homestayEntity.getStatus().equalsIgnoreCase(HomestayStatus.HOMESTAY_BOOKING_AVAILABLE.name())) {
			throw new ResourceNotAllowException(homestayEntity.getName(), "Homestay not active");
		}
		homestayEntity.setBooking(List.of(bookingEntity));
//		List<HomestayAftercareEntity> homestayServicesList = serviceNameList.stream()
//				.map(s -> homestayAftercareService.findHomestayServiceByName(s)).collect(Collectors.toList());
		bookingEntity.getHomestayServiceBooking().forEach(s -> {
			s.setBookingService(List.of(bookingEntity));
		});
		BookingDepositEntity bookingDepositEntity = new BookingDepositEntity();
		bookingDepositEntity.setBookingDeposit(bookingEntity);
		BookingOtpEntity bookingOtpEntity = new BookingOtpEntity();
		String randomBookingOtp = RandomString.make(6);
		bookingOtpEntity.setCode(randomBookingOtp);
		bookingOtpEntity.setBookingContainer(bookingEntity);
		bookingOtpEntity.setCreatedBy(passengerEntity.getPassengerAccount().getUsername());
		bookingOtpEntity.setCreatedDate(currentDate);
		long totalPrice = this.calculateTotalPrice(bookingEntity.getHomestayServiceBooking(), homestayEntity,
				bookingEntity.getCheckIn(), bookingEntity.getCheckOut());
		bookingEntity.setCreatedBy(passengerEntity.getPassengerAccount().getUsername());
		bookingEntity.setCreatedDate(currentDate);
		bookingEntity.setCheckIn(bookingEntity.getCheckIn());
		bookingEntity.setCheckOut(bookingEntity.getCheckOut());
		bookingEntity.setTotalPrice(totalPrice);
		bookingEntity.setStatus(BookingStatus.BOOKING_PENDING.name());
//		bookingEntity.setBookingHomestay(homestayEntity);
//		bookingEntity.setBookingCreator(passengerEntity);
		bookingEntity.setBookingDeposit(bookingDepositEntity);
//		bookingEntity.setHomestayServiceBooking(homestayServicesList);
		bookingEntity.setBookingOtp(bookingOtpEntity);
		BookingEntity bookingPersisted = bookingRepo.save(bookingEntity);

		return bookingPersisted;
	}

	private Long differentInDay(Date checkIn, Date checkOut) {
		long difference_in_time = checkOut.getTime() - checkIn.getTime();
		long difference_in_day = (difference_in_time / (1000 * 60 * 60 * 24)) % 365;

		return difference_in_day;
	}

	private Long calculateTotalPrice(List<HomestayAftercareEntity> homestayServiceList, HomestayEntity homestayBooking,
			Date checkIn, Date checkOut) {
		long totalPrice = 0;
		for (int i = 0; i < homestayServiceList.size(); i++) {
			totalPrice = totalPrice + homestayServiceList.get(i).getPrice();
		}
		Long numberOfBookingDate = this.differentInDay(checkIn, checkOut);
		long totalBookingDatePrice = homestayBooking.getPrice() * numberOfBookingDate;
		totalPrice = totalPrice + totalBookingDatePrice;
		
		return totalPrice;
	}

	@Override
	public BookingEntity findBookingById(Long Id) {
		BookingEntity bookingEntity = bookingRepo.findById(Id)
				.orElseThrow(() -> new ResourceNotFoundException(Id.toString(), "Booking not found"));
		
		return bookingEntity;
	}

	@Override
	public List<BookingEntity> getBookingList() {
		List<BookingEntity> bookingEntityList = bookingRepo.findAll(); 
		
		return bookingEntityList;
	}

}
