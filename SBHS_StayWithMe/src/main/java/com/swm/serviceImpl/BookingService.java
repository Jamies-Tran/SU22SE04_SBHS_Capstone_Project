package com.swm.serviceImpl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.swm.entity.BookingDepositEntity;
import com.swm.entity.BookingEntity;
import com.swm.entity.BookingOtpEntity;
import com.swm.entity.HomestayAftercareEntity;
import com.swm.entity.HomestayEntity;
import com.swm.entity.LandlordEntity;
import com.swm.entity.LandlordWalletEntity;
import com.swm.entity.PassengerEntity;
import com.swm.entity.PassengerShieldCancelBookingEntity;
import com.swm.entity.PassengerWalletEntity;
import com.swm.entity.UserEntity;
import com.swm.enums.AccountRole;
import com.swm.enums.BookingStatus;
import com.swm.enums.HomestayStatus;
import com.swm.exception.DuplicateResourceException;
import com.swm.exception.InvalidBalanceException;
import com.swm.exception.ResourceNotAllowException;
import com.swm.exception.ResourceNotFoundException;
import com.swm.repository.IBookingRepository;
import com.swm.repository.IPassengerShieldCancelBookingRepository;
import com.swm.service.IAuthenticationService;
import com.swm.service.IBookingService;
import com.swm.service.IHomestayService;
import com.swm.service.ISendMailService;
import com.swm.service.IUserService;
import com.swm.util.ApplicationSendMailUtil;

import net.bytebuddy.utility.RandomString;

@Service
public class BookingService implements IBookingService {

	@Autowired
	private IBookingRepository bookingRepo;

	@Autowired
	@Lazy
	private IUserService userService;

	@Autowired
	@Lazy
	private IHomestayService homestayService;

	@Autowired
	private ISendMailService sendMailService;

	@Autowired
	private IAuthenticationService authenticationService;

	@Autowired
	private IPassengerShieldCancelBookingRepository passengerShieldCancelBookingRepository;

	private Date currentDate = new Date();

	private Logger log = LoggerFactory.getLogger(BookingService.class);

	private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

	@Override
	public BookingEntity createBooking(BookingEntity bookingEntity) {
		UserEntity userEntity = userService
				.findUserByUserInfo(authenticationService.getAuthenticatedUser().getUsername());
		PassengerEntity passengerEntity = userEntity.getPassenger();
		passengerEntity.setBooking(List.of(bookingEntity));
		HomestayEntity homestayEntity = bookingEntity.getBookingHomestay();
		if (!homestayEntity.getStatus().equalsIgnoreCase(HomestayStatus.HOMESTAY_BOOKING_AVAILABLE.name())) {
			throw new ResourceNotAllowException(homestayEntity.getName(), "Homestay not active");
		}
		boolean isHomestayScheduleAvailable = this.isBookingDateValid(homestayEntity, bookingEntity.getCheckIn(),
				bookingEntity.getCheckOut());
		if (isHomestayScheduleAvailable) {
			homestayEntity.setBooking(List.of(bookingEntity));
			if (bookingEntity.getHomestayServiceBooking() != null) {
				bookingEntity.getHomestayServiceBooking().forEach(s -> {
					s.setBookingService(List.of(bookingEntity));
				});
			}
			BookingDepositEntity bookingDepositEntity = new BookingDepositEntity();
			bookingDepositEntity.setBookingDeposit(bookingEntity);
			BookingOtpEntity bookingOtpEntity = new BookingOtpEntity();
			String randomBookingOtp = RandomString.make(6);
			bookingOtpEntity.setCode(randomBookingOtp);
			bookingOtpEntity.setBookingContainer(bookingEntity);
			bookingOtpEntity.setCreatedBy(passengerEntity.getPassengerAccount().getUsername());
			bookingOtpEntity.setCreatedDate(currentDate);
			// PassengerShieldCancelBookingEntity passengerShiedCancelBookingEntity = new
			// PassengerShieldCancelBookingEntity();
			PassengerShieldCancelBookingEntity passengerShiedCancelBookingEntity = homestayEntity
					.getShieldForCancelBooking();
			if (passengerShiedCancelBookingEntity == null) {
				passengerShiedCancelBookingEntity = new PassengerShieldCancelBookingEntity();
				passengerShiedCancelBookingEntity.setActiveDate(currentDate);
				passengerShiedCancelBookingEntity.setPassengerOwnerOfShield(passengerEntity);
				passengerShiedCancelBookingEntity.setHomestayShieldForCancel(homestayEntity);
				passengerEntity.setShieldList(List.of(passengerShiedCancelBookingEntity));
				homestayEntity.setShieldForCancelBooking(passengerShiedCancelBookingEntity);
				passengerShiedCancelBookingEntity = passengerShieldCancelBookingRepository
						.save(passengerShiedCancelBookingEntity);
				passengerEntity.setShieldList(List.of(passengerShiedCancelBookingEntity));
				homestayEntity.setShieldForCancelBooking(passengerShiedCancelBookingEntity);
			}
//			passengerShiedCancelBookingEntity.setActiveDate(currentDate);
//			passengerShiedCancelBookingEntity.setPassengerOwnerOfShield(passengerEntity);
//			passengerShiedCancelBookingEntity.setHomestayShieldForCancel(homestayEntity);
//			passengerEntity.setShieldList(List.of(passengerShiedCancelBookingEntity));
//			homestayEntity.setShieldForCancelBooking(passengerShiedCancelBookingEntity);

//			PassengerShieldCancelBookingEntity passengerShieldCancelBookingPersisted = passengerShieldCancelBookingRepository
//					.save(passengerShiedCancelBookingEntity);
//			passengerEntity.setShieldList(List.of(passengerShiedCancelBookingEntity));
//			homestayEntity.setShieldForCancelBooking(passengerShiedCancelBookingEntity);
			long totalPrice = this.calculateTotalPrice(bookingEntity.getHomestayServiceBooking(), homestayEntity,
					bookingEntity.getCheckIn(), bookingEntity.getCheckOut());
			long depositAmount = totalPrice * 50 / 100;
			bookingEntity.setBookingCreator(passengerEntity);
			bookingEntity.setCreatedBy(passengerEntity.getPassengerAccount().getUsername());
			bookingEntity.setCreatedDate(currentDate);
			bookingEntity.setCheckIn(bookingEntity.getCheckIn());
			bookingEntity.setCheckOut(bookingEntity.getCheckOut());
			bookingEntity.setTotalPrice(totalPrice);
			bookingEntity.setDeposit(depositAmount);
			bookingEntity.setStatus(BookingStatus.BOOKING_PENDING.name());
			bookingEntity.setBookingPaidDeposit(bookingDepositEntity);
			bookingEntity.setBookingOtp(bookingOtpEntity);

			BookingEntity bookingPersisted = bookingRepo.save(bookingEntity);

			return bookingPersisted;
		}

		return null;
	}

	@Override
	public BookingEntity findBookingById(Long Id) {
		BookingEntity bookingEntity = bookingRepo.findById(Id)
				.orElseThrow(() -> new ResourceNotFoundException(Id.toString(), "Booking not found"));

		return bookingEntity;
	}

	@Override
	public List<BookingEntity> getHomestayBookingList(String homestayName) {
		List<BookingEntity> bookingEntityList = bookingRepo.findAll().stream()
				.filter(b -> b.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_PENDING_CHECKIN.name())
						&& b.getBookingHomestay().getName().equals(homestayName))
				.collect(Collectors.toList());

		return bookingEntityList;
	}

	@Transactional
	@Override
	public BookingEntity verifyBookingCheckIn(Long bookingId, String bookingOtp) {
		String msg = "";
		BookingEntity bookingEntity = this.findBookingById(bookingId);
		BookingOtpEntity bookingOtpEntity = bookingEntity.getBookingOtp();
		HomestayEntity homestayEntity = bookingEntity.getBookingHomestay();
		UserEntity checkInUserEntity = userService
				.findUserByUserInfo(authenticationService.getAuthenticatedUser().getUsername());
		UserEntity bookingUserEntity = bookingEntity.getBookingCreator().getPassengerAccount();
		UserEntity homestayOwnerEntity = homestayEntity.getLandlordOwner().getLandlordAccount();
		if (!bookingEntity.getStatus().equals(BookingStatus.BOOKING_PENDING_CHECKIN.name())) {
			throw new ResourceNotAllowException("You haven't pay deposit yet");
		}
		if (bookingOtpEntity.getCode().equals(bookingOtp)) {
			if (!checkInUserEntity.getUsername().equals(bookingUserEntity.getUsername())) {
				if (checkInUserEntity.getUsername().equals(homestayOwnerEntity.getUsername())) {
					// chủ homestay check-in cho khách
					msg = ApplicationSendMailUtil.generateConfirmCheckInMessage(checkInUserEntity, homestayEntity,
							bookingEntity, AccountRole.LANDLORD.name());
					bookingEntity.setStatus(BookingStatus.BOOKING_CHECKIN_BY_LANDLORD.name());
					bookingEntity.setCheckInBy(checkInUserEntity.getUsername());
					sendMailService.sendMail(bookingUserEntity.getUsername(), msg, "Booking confirm");
				} else if (!checkInUserEntity.getUsername().equals(bookingUserEntity.getUsername())) {
					// người quen của passenger người có otp code
					msg = ApplicationSendMailUtil.generateConfirmCheckInMessage(checkInUserEntity, homestayEntity,
							bookingEntity, AccountRole.PASSENGER.name());
					bookingEntity.setStatus(BookingStatus.BOOKING_CHECKIN_BY_PASSENGER_RELATIVE.name());
					bookingEntity.setCheckInBy(checkInUserEntity.getUsername());
					sendMailService.sendMail(bookingUserEntity.getUsername(), msg, "Booking confirm");
				}
			} else {
				// người đặt check-in
				bookingEntity.setStatus(BookingStatus.BOOKING_CONFIRM_CHECKIN.name());
				bookingEntity.setCheckInBy(checkInUserEntity.getUsername());

			}
			return bookingEntity;
		} else {
			throw new ResourceNotFoundException(bookingOtp, "Booking otp not correct");
		}
	}

	@Transactional
	@Override
	public BookingEntity confirmBooking(Long BookingId, boolean isAccepted, @Nullable String rejectMessage) {
		BookingEntity bookingEntity = this.findBookingById(BookingId);
		HomestayEntity homestayEntity = bookingEntity.getBookingHomestay();
		LandlordEntity landlordEntity = homestayEntity.getLandlordOwner();
		PassengerEntity passengerEntity = bookingEntity.getBookingCreator();
		if (isAccepted) {
			bookingEntity.setStatus(BookingStatus.BOOKING_PENDING_DEPOSIT.name());
			bookingEntity.setModifiedBy(landlordEntity.getLandlordAccount().getUsername());
			bookingEntity.setModifiedDate(currentDate);
			String message = ApplicationSendMailUtil.generateAcceptBookingMessage(bookingEntity);
			String subject = "Your booking has been approved";
			sendMailService.sendMail(passengerEntity.getPassengerAccount().getUsername(), message, subject);
		} else {
			if (!StringUtils.hasLength(rejectMessage)) {
				throw new ResourceNotFoundException("Reject message empty");
			}
			bookingEntity.setStatus(BookingStatus.BOOKING_REJECTED.name());
			bookingEntity.setModifiedBy(landlordEntity.getLandlordAccount().getUsername());
			bookingEntity.setModifiedDate(currentDate);
			String message = ApplicationSendMailUtil.generateRejectBookingMessage(bookingEntity, rejectMessage);
			String subject = "Your booking has been denied";
			sendMailService.sendMail(passengerEntity.getPassengerAccount().getUsername(), message, subject);
		}

		return bookingEntity;
	}

	@Override
	public boolean isBookingDateValid(HomestayEntity homestayEntity, Date checkIn, Date checkOut) {
		Map<Date, Date> bookingDateKeyValuePair = this.getBookingDateKeyValuePair(homestayEntity);
		for (Entry<Date, Date> bookingEntry : bookingDateKeyValuePair.entrySet()) {
			System.out.println((bookingEntry.getValue().before(checkOut)));
			if (bookingEntry.getKey().equals(checkIn) || bookingEntry.getValue().equals(checkOut)) {
				// ngày check-in, check-out trùng luông lịch của booking khác
				throw new DuplicateResourceException("Reservation schedule is duplicated");
			} else if ((bookingEntry.getKey().before(checkIn) && bookingEntry.getValue().after(checkIn))
					|| (bookingEntry.getKey().before(checkOut) && bookingEntry.getValue().after(checkOut)
							|| (bookingEntry.getKey().after(checkIn) && bookingEntry.getValue().before(checkOut)))) {
				// ngày check-in, check-out nằm trong ngày homestay có lịch booking từ trước
				throw new ResourceNotAllowException("Homestay is on the reservation schedule");
			} else if (checkIn.before(currentDate) || checkOut.before(currentDate) || checkOut.before(checkIn)) {
				// check=in, check-out ngày quá khứ, check-out sau ngày check-in
				throw new ResourceNotAllowException("Invalid booking schedule");
			}
		}
		return true;
	}

	@Transactional
	@Override
	public void confirmCheckIn(Long bookingId, boolean isAccepted) {
		BookingEntity bookingEntity = this.findBookingById(bookingId);
		if (isAccepted) {
			bookingEntity.setStatus(BookingStatus.BOOKING_CONFIRM_CHECKIN.name());
		} else {
			bookingEntity.setCheckInBy(null);
			bookingEntity.setStatus(BookingStatus.BOOKING_PENDING_CHECKIN.name());
		}
	}

	private Long differentInDay(Date checkIn, Date checkOut) {
		long difference_in_time = checkOut.getTime() - checkIn.getTime();
		long difference_in_day = (difference_in_time / (1000 * 60 * 60 * 24)) % 365;

		return difference_in_day;
	}

	private Long calculateTotalPrice(@Nullable List<HomestayAftercareEntity> homestayServiceList,
			HomestayEntity homestayBooking, Date checkIn, Date checkOut) {
		long totalPrice = 0;
		if (homestayServiceList != null) {
			for (int i = 0; i < homestayServiceList.size(); i++) {
				totalPrice = totalPrice + homestayServiceList.get(i).getPrice();
			}
		}

		Long numberOfBookingDate = this.differentInDay(checkIn, checkOut);
		long totalBookingDatePrice = homestayBooking.getPrice() * numberOfBookingDate;
		totalPrice = totalPrice + totalBookingDatePrice;

		return totalPrice;
	}

	/*
	 * Key là checkin, value là checkout
	 */
	private Map<Date, Date> getBookingDateKeyValuePair(HomestayEntity homestayEntity) {
		Map<Date, Date> bookingDateKeyValuePair = new HashMap<Date, Date>();
		List<BookingEntity> bookingEntityList = homestayEntity.getBooking();
		bookingEntityList.forEach(b -> {
			bookingDateKeyValuePair.put(b.getCheckIn(), b.getCheckOut());
		});

		return bookingDateKeyValuePair;
	}

	@Override
	public BookingEntity checkOutRequest(Long bookingId, String paymentMethod) {
		BookingEntity bookingEntity = this.findBookingById(bookingId);
		String checkOutUser = authenticationService.getAuthenticatedUser().getUsername();
		PassengerEntity homestayBookingUser = bookingEntity.getBookingCreator();
		LandlordEntity homestayOwner = bookingEntity.getBookingHomestay().getLandlordOwner();
		if (homestayBookingUser.getPassengerAccount().getUsername().equals(checkOutUser)
				|| homestayOwner.getLandlordAccount().getUsername().equals(checkOutUser)) {

		}

		return null;
	}

	@Transactional
	@Override
	public BookingDepositEntity payForBookingDeposit(Long bookingId, Long amount) {
		BookingEntity bookingEntity = this.findBookingById(bookingId);
		BookingDepositEntity bookingDepositEntity = bookingEntity.getBookingPaidDeposit();
		PassengerEntity passengerEntity = bookingEntity.getBookingCreator();
		PassengerWalletEntity passengerWalletEntity = passengerEntity.getWallet();
		if (!bookingEntity.getStatus().equals(BookingStatus.BOOKING_PENDING_DEPOSIT.name())) {
			throw new ResourceNotAllowException("Landlord haven't confirm booking yet");
		} else if (amount.longValue() > passengerWalletEntity.getBalance().longValue()) {
			throw new InvalidBalanceException("Wallet ballance is not enough to make a transaction");
		} else if (!bookingEntity.getDeposit().equals(amount)) {
			throw new InvalidBalanceException("The amount must be equal to booking deposit");
		}
		Long newPassengerWalletBalance = passengerWalletEntity.getBalance() - amount;
		passengerWalletEntity.setBalance(newPassengerWalletBalance);
		bookingEntity.setStatus(BookingStatus.BOOKING_PENDING_CHECKIN.name());
		bookingDepositEntity.setDepositPaidAmount(amount);

		return bookingDepositEntity;
	}

	@Transactional
	@Override
	public BookingEntity passengerCancelBooking(Long bookingId) {
		BookingEntity bookingEntity = this.findBookingById(bookingId);
		PassengerEntity userCancelBooking = bookingEntity.getBookingCreator();
		LandlordEntity homestayOwner = bookingEntity.getBookingHomestay().getLandlordOwner();
		PassengerShieldCancelBookingEntity passengerShieldBookingEntity = userCancelBooking.getShieldList().stream()
				.filter(s -> s.getHomestayShieldForCancel().getId().equals(bookingEntity.getBookingHomestay().getId()))
				.findAny().orElseThrow(() -> new ResourceNotFoundException("Shield not found"));
		PassengerWalletEntity passengerWallet = userCancelBooking.getWallet();
		LandlordWalletEntity landlordWallet = homestayOwner.getWallet();
		BookingDepositEntity bookingDeposit = bookingEntity.getBookingPaidDeposit();
		long depositAmount = bookingDeposit.getDepositPaidAmount();
		long passengerWalletCurrentBalance = passengerWallet.getBalance();
		long landlordWalletCurrentBalance = landlordWallet.getBalance();

		if (!bookingEntity.getStatus().equals(BookingStatus.BOOKING_PENDING_CHECKIN.name())) {
			throw new ResourceNotAllowException("Not avalable cancel request");
		}

		// 24h đầu tiên
		if (!passengerShieldBookingEntity.getActiveDate().after(currentDate)) {
			// hủy lần đầu
			if (passengerShieldBookingEntity.getFirstTimeShieldActive()) {
				passengerWalletCurrentBalance = passengerWalletCurrentBalance + depositAmount;
				depositAmount = 0;
				passengerWallet.setBalance(passengerWalletCurrentBalance);
				bookingDeposit.setDepositPaidAmount(depositAmount);
				passengerShieldBookingEntity.setFirstTimeShieldActive(false);
				// hủy lần hai
			} else if (passengerShieldBookingEntity.getSencondTimeShieldActive()) {
				passengerWalletCurrentBalance = passengerWalletCurrentBalance + (depositAmount * 95) / 100;
				landlordWalletCurrentBalance = landlordWalletCurrentBalance + (depositAmount * 5) / 100;
				depositAmount = 0;
				passengerWallet.setBalance(passengerWalletCurrentBalance);
				landlordWallet.setBalance(landlordWalletCurrentBalance);
				bookingDeposit.setDepositPaidAmount(depositAmount);
				passengerShieldBookingEntity.setSencondTimeShieldActive(false);
				// hủy lần 2 trở lên
			} else {
				landlordWalletCurrentBalance = landlordWalletCurrentBalance + depositAmount;
				depositAmount = 0;
				landlordWallet.setBalance(landlordWalletCurrentBalance);
				bookingDeposit.setDepositPaidAmount(depositAmount);
			}
			// sau 24h
		} else {
			landlordWalletCurrentBalance = landlordWalletCurrentBalance + depositAmount;
			depositAmount = 0;
			landlordWallet.setBalance(landlordWalletCurrentBalance);
			bookingDeposit.setDepositPaidAmount(depositAmount);
		}

		bookingEntity.setStatus(BookingStatus.BOOKING_REJECTED.name());

		return bookingEntity;
	}

	@Override
	public BookingEntity deleteBooking(Long bookingId) {
		BookingEntity bookingEntity = this.findBookingById(bookingId);
		if (!bookingEntity.getStatus().equals(BookingStatus.BOOKING_CONFIRM_CHECKOUT.name())
				&& !bookingEntity.getStatus().equals(BookingStatus.BOOKING_REJECTED.name())) {
			throw new ResourceNotAllowException("Error when deleting booking");
		}

		bookingRepo.delete(bookingEntity);

		return bookingEntity;
	}

	@Override
	public List<String> getHomestayBookingDate(Long homestayId) {
		HomestayEntity homestayEntity = homestayService.findHomestayById(homestayId);
		List<BookingEntity> bookingEntityList = homestayEntity.getBooking();
		List<String> bookingDateList = new ArrayList<String>();
		bookingEntityList.stream().filter(b -> b.getStatus().equals(BookingStatus.BOOKING_PENDING_CHECKIN.name()))
				.collect(Collectors.toList()).forEach(b -> {
					Date currentDate = b.getCheckIn();
					bookingDateList.add(simpleDateFormat.format(currentDate));
					Long differentInDate = this.differentInDay(b.getCheckIn(), b.getCheckOut());
					Calendar cal = Calendar.getInstance();
					cal.setTime(currentDate);
					for (long i = 0; i < differentInDate; i++) {
						// log.info("Date increase: " + currentDate);
						cal.add(Calendar.DATE, 1);
						currentDate = cal.getTime();
						bookingDateList.add(simpleDateFormat.format(currentDate));
					}
				});

		return bookingDateList;
	}

}
