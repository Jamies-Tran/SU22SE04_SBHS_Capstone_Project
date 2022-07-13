package com.swm.serviceImpl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.swm.entity.BookingDepositEntity;
import com.swm.entity.BookingEntity;
import com.swm.entity.BookingOtpEntity;
import com.swm.entity.HomestayAftercareEntity;
import com.swm.entity.HomestayEntity;
import com.swm.entity.LandlordEntity;
import com.swm.entity.PassengerEntity;
import com.swm.enums.BookingStatus;
import com.swm.enums.HomestayStatus;
import com.swm.exception.ResourceNotAllowException;
import com.swm.exception.ResourceNotFoundException;
import com.swm.repository.IBookingRepository;
import com.swm.service.IBookingService;
import com.swm.service.IHomestayService;
import com.swm.service.ISendMailService;
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
	
	@Autowired
	private ISendMailService sendMailService;

	private Date currentDate = new Date();
	
	private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	

	@Override
	public BookingEntity createBooking(BookingEntity bookingEntity) {
		PassengerEntity passengerEntity = bookingEntity.getBookingCreator();
		passengerEntity.setBooking(List.of(bookingEntity));
		HomestayEntity homestayEntity = bookingEntity.getBookingHomestay();
		if(!homestayEntity.getStatus().equalsIgnoreCase(HomestayStatus.HOMESTAY_BOOKING_AVAILABLE.name())) {
			throw new ResourceNotAllowException(homestayEntity.getName(), "Homestay not active");
		}
		homestayEntity.setBooking(List.of(bookingEntity));
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
		bookingEntity.setBookingDeposit(bookingDepositEntity);
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

	@Override
	public BookingEntity checkInHomestay(Long bookingId, String bookingOtp) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BookingEntity confirmBooking(Long BookingId, boolean isAccepted, @Nullable String rejectMessage) {
		BookingEntity bookingEntity = this.findBookingById(BookingId);
		HomestayEntity homestayEntity = bookingEntity.getBookingHomestay();
		LandlordEntity landlordEntity = homestayEntity.getLandlordOwner();
		PassengerEntity passengerEntity = bookingEntity.getBookingCreator();
		if(isAccepted) {
			bookingEntity.setStatus(BookingStatus.BOOKING_PENDING_DEPOSIT.name());
			bookingEntity.setModifiedBy(landlordEntity.getLandlordAccount().getUsername());
			bookingEntity.setModifiedDate(currentDate);
			String message = this.generateConfirmBookingMessage(bookingEntity);
			String subject = "Your booking has been approved";
			sendMailService.sendMail(passengerEntity.getPassengerAccount().getUsername(), message, subject);
		} else {
			if(!StringUtils.hasLength(rejectMessage)) {
				throw new ResourceNotFoundException("Reject message empty");
			}
			bookingEntity.setStatus(BookingStatus.BOOKING_REJECTED.name());
			bookingEntity.setModifiedBy(landlordEntity.getLandlordAccount().getUsername());
			bookingEntity.setModifiedDate(currentDate);
			String message = "<p>Your booking has been denied by homestay owner with reason:<p/>\r\n"
					+ "<p>" + rejectMessage + "</p>";
			String subject = "Your booking has been denied";
			sendMailService.sendMail(passengerEntity.getPassengerAccount().getUsername(), message, subject);
		}
		
		return bookingEntity;
	}
	
	
	private String generateConfirmBookingMessage(BookingEntity bookingEntity) {
		List<HomestayAftercareEntity> homestayServiceList = bookingEntity.getHomestayServiceBooking();
		HomestayEntity homestayEntity = bookingEntity.getBookingHomestay();
		String message;
		if(homestayServiceList.isEmpty()) {
			message = "<p>We please to send you your booking information:<p>\r\n"
					+ "<p><span style='font-weight:bold'>Homestay:</span>" + homestayEntity.getName() + "</p>\r\n"
					+ "<p><span style='font-weight:bold'>Check-in:</span>" + simpleDateFormat.format(bookingEntity.getCheckIn()) + "</p>\r\n"
					+ "<p><span style='font-weight:bold'>Check-out:</span>" + simpleDateFormat.format(bookingEntity.getCheckOut()) + "</p>\r\n"
					+ "<p><span style='font-weight:bold'>Total: </span>" + bookingEntity.getTotalPrice() + "VND</p>\r\n"
					+ "<p><span style='font-weight:bold'>Deposit: </span>" + bookingEntity.getBookingDeposit().getDepositAmount() + "</p>\r\n"
					+ "<p>P.S: You must pay deposit to complete the booking.</p>\r\n"
					+ "<p>We wish your journey safe and sound. Enjoy your time.</p>";
		} else {
			String serviceListString = "";
			for(int i = 0; i < homestayServiceList.size(); i++) {
				serviceListString += String.format("<li>%s : %s</li>\r\n", homestayServiceList.get(i).getServiceName(), homestayServiceList.get(i).getPrice().toString());
			}
			message = "<p>We please to send you your booking information:<p>\r\n"
					+ "<p><span style='font-weight:bold'>Homestay:</span>" + homestayEntity.getName() + "</p>\r\n"
					+ "<p><span style='font-weight:bold'>Your chosen services:</span></p>\r\n"
					+ "<ol>\r\n"
					+ serviceListString
					+ "</ol>"
					+ "<p><span style='font-weight:bold'>Check-in:</span>" + simpleDateFormat.format(bookingEntity.getCheckIn()) + "</p>\r\n"
					+ "<p><span style='font-weight:bold'>Check-out:</span>" + simpleDateFormat.format(bookingEntity.getCheckOut()) + "</p>\r\n"
					+ "<p><span style='font-weight:bold'>Total: </span>" + bookingEntity.getTotalPrice() + "VND</p>\r\n"
					+ "<p><span style='font-weight:bold'>Deposit: </span>" + bookingEntity.getBookingDeposit().getDepositAmount() + "</p>\r\n"
					+ "<p>P.S: You must pay deposit to complete the booking.</p>\r\n"
					+ "<p>We wish your journey safe and sound. Enjoy your time.</p>";
		}
		
		return message;
	}

}
