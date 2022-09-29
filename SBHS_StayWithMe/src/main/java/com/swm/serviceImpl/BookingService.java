package com.swm.serviceImpl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.swm.entity.BookingDepositEntity;
import com.swm.entity.BookingEntity;
import com.swm.entity.BookingOtpEntity;
import com.swm.entity.HomestayEntity;
import com.swm.entity.LandlordEntity;
import com.swm.entity.LandlordStatisticEntity;
import com.swm.entity.LandlordWalletEntity;
import com.swm.entity.PassengerCancelBookingTicketEntity;
import com.swm.entity.PassengerEntity;
import com.swm.entity.PassengerWalletEntity;
import com.swm.entity.SystemStatisticEntity;
import com.swm.entity.UserEntity;
import com.swm.enums.AccountRole;
import com.swm.enums.BookingStatus;
import com.swm.enums.HomestayStatus;
import com.swm.exception.ResourceNotAllowException;
import com.swm.exception.ResourceNotFoundException;
import com.swm.repository.IBookingRepository;
import com.swm.repository.IPassengerShieldCancelBookingRepository;
import com.swm.service.IAuthenticationService;
import com.swm.service.IBookingService;
import com.swm.service.IHomestayService;
import com.swm.service.ILandlordStatisticService;
import com.swm.service.ISendMailService;
import com.swm.service.ISystemStatisticService;
import com.swm.service.IUserService;
import com.swm.util.ApplicationSendMailUtil;
import com.swm.util.DateParsingUtil;

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
	private ISystemStatisticService systemStatisticService;
	
	@Autowired
	private ILandlordStatisticService landlordStatisticService;

	@Autowired
	private IPassengerShieldCancelBookingRepository passengerShieldCancelBookingRepository;

	private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

	private Date currentDate = new Date();

	private Logger log = LoggerFactory.getLogger(BookingService.class);

	// private SimpleDateFormat simpleDateFormat = new
	// SimpleDateFormat("yyyy-MM-dd");

	private Date formatDateTime(Date dateFormat) {
		try {
			currentDate = simpleDateFormat.parse(simpleDateFormat.format(new Date()));
			return currentDate;
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}

	@Transactional
	@Override
	public BookingEntity createBooking(BookingEntity bookingEntity) {
		UserEntity userEntity = userService
				.findUserByUserInfo(authenticationService.getAuthenticatedUser().getUsername());
		PassengerEntity passengerEntity = userEntity.getPassenger();
		passengerEntity.setBooking(List.of(bookingEntity));
		HomestayEntity homestayEntity = bookingEntity.getBookingHomestay();
		currentDate = formatDateTime(currentDate);
		long totalBookingTime = homestayEntity.getTotalBookingTime() + 1;
		if (!homestayEntity.getStatus().equalsIgnoreCase(HomestayStatus.HOMESTAY_BOOKING_AVAILABLE.name())) {
			throw new ResourceNotAllowException(homestayEntity.getName(), "Homestay not active");
		}
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
		List<PassengerCancelBookingTicketEntity> passengerShiedCancelBookingList = homestayEntity
				.getTicketForCancelBooking();
		if(passengerShiedCancelBookingList.isEmpty()) {
			PassengerCancelBookingTicketEntity passengerShiedCancelBookingEntity = new PassengerCancelBookingTicketEntity();
			passengerShiedCancelBookingEntity.setActiveDate(currentDate);
			passengerShiedCancelBookingEntity.setPassengerOwnerOfTicket(passengerEntity);
			passengerShiedCancelBookingEntity.setHomestayTicketForCancel(homestayEntity);
			if(passengerEntity.getCancelTicketList().isEmpty()) {
				passengerEntity.setCancelTicketList(List.of(passengerShiedCancelBookingEntity));
			} else {
				passengerEntity.getCancelTicketList().add(passengerShiedCancelBookingEntity);
			}
			
			homestayEntity.setTicketForCancelBooking(List.of(passengerShiedCancelBookingEntity));
			passengerShiedCancelBookingEntity = passengerShieldCancelBookingRepository
					.save(passengerShiedCancelBookingEntity);
		} else {
			if(!passengerShiedCancelBookingList.stream().anyMatch(t -> t.getPassengerOwnerOfTicket().getPassengerAccount().getUsername().equals(passengerEntity.getPassengerAccount().getUsername()))) {
				PassengerCancelBookingTicketEntity passengerShiedCancelBookingEntity = new PassengerCancelBookingTicketEntity();
				passengerShiedCancelBookingEntity.setActiveDate(currentDate);
				passengerShiedCancelBookingEntity.setPassengerOwnerOfTicket(passengerEntity);
				passengerShiedCancelBookingEntity.setHomestayTicketForCancel(homestayEntity);
				passengerEntity.getCancelTicketList().add(passengerShiedCancelBookingEntity);
				passengerShiedCancelBookingEntity = passengerShieldCancelBookingRepository
						.save(passengerShiedCancelBookingEntity);
			}
		} 
		
		bookingEntity.setBookingCreator(passengerEntity);
		bookingEntity.setCreatedBy(passengerEntity.getPassengerAccount().getUsername());
		bookingEntity.setCreatedDate(currentDate);
		bookingEntity.setCheckIn(bookingEntity.getCheckIn());
		bookingEntity.setCheckOut(bookingEntity.getCheckOut());
		bookingEntity.setStatus(BookingStatus.BOOKING_PENDING.name());
		bookingEntity.setBookingPaidDeposit(bookingDepositEntity);
		bookingEntity.setBookingOtp(bookingOtpEntity);

		BookingEntity bookingPersisted = bookingRepo.save(bookingEntity);
		homestayEntity.setTotalBookingTime(totalBookingTime);
		
		return bookingPersisted;
	}

	@Override
	public BookingEntity findBookingById(Long Id) {
		BookingEntity bookingEntity = bookingRepo.findById(Id)
				.orElseThrow(() -> new ResourceNotFoundException(Id.toString(), "Booking not found"));

		return bookingEntity;
	}

	@Override
	public List<BookingEntity> getHomestayBookingList(String homestayName, String status) {
		List<BookingEntity> bookingEntityList = status
				.equals("all")
						? bookingRepo.findAll().stream()
								.filter(b -> b.getBookingHomestay().getName().equals(homestayName))
								.collect(Collectors.toList())
						: bookingRepo.findAll().stream()
								.filter(b -> b.getStatus().equalsIgnoreCase(status)
										&& b.getBookingHomestay().getName().equals(homestayName))
								.collect(Collectors.toList());

		return bookingEntityList;
	}
	
	@Override
	public List<BookingEntity> getHomestayBookingListForLandlord(String homestayName, String status) {
		UserEntity user = userService.findUserByUserInfo(authenticationService.getAuthenticatedUser().getUsername());
		List<BookingEntity> bookingList = bookingRepo.findAll();
		if(homestayName.equalsIgnoreCase("all") && status.equalsIgnoreCase("all")) {
			bookingList = bookingRepo.getAllBookingListByLandlord(user.getUsername()).orElseThrow(() -> new ResourceNotFoundException("No booking found"));
		} else if(!homestayName.equalsIgnoreCase("all") && !status.equalsIgnoreCase("all")) {
			bookingList = bookingRepo.getAllBookingListByHomestayAndStatus(homestayName, status).orElseThrow(() -> new ResourceNotFoundException("No booking found"));
		} else if(!homestayName.equalsIgnoreCase("all") && status.equalsIgnoreCase("all")) {
			bookingList = bookingRepo.getAllBookingListByHomestay(homestayName).orElseThrow(() -> new ResourceNotFoundException("No booking found"));
		} else if(homestayName.equalsIgnoreCase("all") && !status.equalsIgnoreCase("all")) {
			bookingList = bookingRepo.getAllBookingListByLandlordAndStatus(user.getUsername(), status).orElseThrow(() -> new ResourceNotFoundException("No booking found"));
		}

		return bookingList;
	}

	@Transactional
	@Override
	public BookingEntity checkInByPassengerOrLandlord(Long bookingId, String bookingOtp) {
		String msg = "";
		String bookingStatus = "";
		BookingEntity bookingEntity = this.findBookingById(bookingId);
		BookingOtpEntity bookingOtpEntity = bookingEntity.getBookingOtp();
		HomestayEntity homestayEntity = bookingEntity.getBookingHomestay();
		UserEntity checkInUserEntity = userService
				.findUserByUserInfo(authenticationService.getAuthenticatedUser().getUsername());
		UserEntity bookingUserEntity = bookingEntity.getBookingCreator().getPassengerAccount();
		UserEntity homestayOwnerEntity = homestayEntity.getLandlordOwner().getLandlordAccount();
		String subject = "Check-in confirm";

		if (checkInUserEntity.getUsername().equals(homestayOwnerEntity.getUsername())) {
			// chủ homestay check-in cho khách
			msg = ApplicationSendMailUtil.generateConfirmCheckInMessage(checkInUserEntity, homestayEntity,
					bookingEntity, AccountRole.LANDLORD.name());
			bookingStatus = BookingStatus.BOOKING_CHECKIN_BY_LANDLORD.name();
			bookingEntity.setStatus(bookingStatus);
			bookingEntity.setCheckInBy(checkInUserEntity.getUsername());
			bookingEntity.setModifiedBy(checkInUserEntity.getUsername());
			bookingEntity.setModifiedDate(currentDate);
			sendMailService.sendMail(bookingUserEntity.getUsername(), msg, subject);
			return bookingEntity;
		} else {
			bookingStatus = BookingStatus.BOOKING_CONFIRM_CHECKIN.name();
			if (bookingOtpEntity.getCode().equals(bookingOtp)) {
				// người đặt check-in
				msg = ApplicationSendMailUtil.generateConfirmCheckInMessage(checkInUserEntity, homestayEntity,
						bookingEntity, AccountRole.PASSENGER.name());
				bookingEntity.setStatus(bookingStatus);
				bookingEntity.setCheckInBy(checkInUserEntity.getUsername());
				bookingEntity.setModifiedBy(checkInUserEntity.getUsername());
				bookingEntity.setModifiedDate(currentDate);
				sendMailService.sendMail(bookingUserEntity.getUsername(), msg, subject);
				return bookingEntity;
			} else {
				throw new ResourceNotFoundException(bookingOtp, "Booking otp not correct");
			}

		}
	}

	@Transactional
	@Override
	public BookingEntity confirmBooking(Long BookingId, boolean isAccepted, @Nullable String rejectMessage) {
		BookingEntity bookingEntity = this.findBookingById(BookingId);
		HomestayEntity homestayEntity = bookingEntity.getBookingHomestay();
		LandlordEntity landlordEntity = homestayEntity.getLandlordOwner();
		PassengerEntity passengerEntity = bookingEntity.getBookingCreator();
		long increasedTotalBookingTime = homestayEntity.getTotalBookingTime() + 1;
		if (isAccepted) {
			bookingEntity.setStatus(BookingStatus.BOOKING_PENDING_CHECKIN.name());
			bookingEntity.setModifiedBy(landlordEntity.getLandlordAccount().getUsername());
			bookingEntity.setModifiedDate(currentDate);
			homestayEntity.setTotalBookingTime(increasedTotalBookingTime);
			String message = ApplicationSendMailUtil.generateAcceptBookingMessage(bookingEntity);
			String subject = "Your booking has been approved";
			sendMailService.sendMail(passengerEntity.getPassengerAccount().getUsername(), message, subject);
		} else {
			if (!StringUtils.hasLength(rejectMessage)) {
				throw new ResourceNotFoundException("Reject message empty");
			}
			long bookingDeposit = bookingEntity.getBookingPaidDeposit().getDepositPaidAmount();
			long totalBookingPrice = bookingEntity.getTotalPrice();
			long passengerWalletCurrentBalance = passengerEntity.getWallet().getBalance();
			long passengerWalletCurrentFuturePay = passengerEntity.getWallet().getFuturePay();
			long passengerTotalBalanceAfterDepositRetur = passengerWalletCurrentBalance + bookingDeposit;
			long passengerTotalFuturePayAfterDecrease = passengerWalletCurrentFuturePay - (totalBookingPrice - bookingDeposit);
			passengerEntity.getWallet().setBalance(passengerTotalBalanceAfterDepositRetur);
			passengerEntity.getWallet().setFuturePay(passengerTotalFuturePayAfterDecrease);
			bookingEntity.setStatus(BookingStatus.BOOKING_REJECTED.name());
			bookingEntity.setModifiedBy(landlordEntity.getLandlordAccount().getUsername());
			bookingEntity.setModifiedDate(currentDate);
			String message = ApplicationSendMailUtil.generateRejectBookingMessage(bookingEntity, rejectMessage);
			String subject = "Your booking has been denied";
			sendMailService.sendMail(passengerEntity.getPassengerAccount().getUsername(), message, subject);
		}

		return bookingEntity;
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

	@Override
	@Transactional
	public BookingEntity checkOut(Long bookingId) {
		BookingEntity bookingEntity = this.findBookingById(bookingId);
		PassengerEntity userBookingHomestay = bookingEntity.getBookingCreator();
		BookingDepositEntity bookingDepositEntity = bookingEntity.getBookingPaidDeposit();
		LandlordEntity homestayOwner = bookingEntity.getBookingHomestay().getLandlordOwner();
		UserEntity userCheckOut = userService
				.findUserByUserInfo(authenticationService.getAuthenticatedUser().getUsername());
		SystemStatisticEntity systemStatistic = this.systemStatisticService.findSystemStatisticByTime(DateParsingUtil.statisticYearMonthTime(bookingEntity.getCreatedDate()));
		LandlordStatisticEntity landlordStatistic = this.landlordStatisticService.findLandlordStatisticByTime(DateParsingUtil.statisticYearMonthTime(bookingEntity.getCreatedDate()));
		String status;
		Long totalRemainAmount = bookingEntity.getTotalPrice() - bookingDepositEntity.getDepositPaidAmount();
		Long currentPassengerWalletAmount = userBookingHomestay.getWallet().getBalance() - totalRemainAmount;
		Long currentFuturePay = userBookingHomestay.getWallet().getFuturePay() - totalRemainAmount;
		Long totalSystemCommission = (bookingEntity.getTotalPrice() * 10) / 100;
		Long totalLandlordProfit = bookingEntity.getTotalPrice() - totalSystemCommission;
		Long landlordWalletBalanceAfterBookingSuccess = homestayOwner.getWallet().getBalance() + totalLandlordProfit;
		
		Long systemTotalProfitAfterBookingSuccess = systemStatistic.getTotalProfit() + totalSystemCommission;
		
		Long landlordTotalSuccessBooking = landlordStatistic.getTotalSuccessBooking() + 1;
		Long landlordTotalProfitAfterSuccessBooking = landlordStatistic.getTotalProfit() + totalLandlordProfit;
		Long landlordTotalCommissionAfterSuccessBooking = landlordStatistic.getTotalCommissionProfit() + totalSystemCommission;

		if (bookingEntity.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_CONFIRM_CHECKIN.name())
				|| bookingEntity.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_CHECKIN_BY_LANDLORD.name())
				|| bookingEntity.getStatus().equals(BookingStatus.BOOKING_CHECKIN_BY_PASSENGER_RELATIVE.name())) {

			if (bookingEntity.getBookingCreator().getPassengerAccount().getUsername()
					.equals(userCheckOut.getUsername())) {

				status = BookingStatus.BOOKING_CONFIRM_CHECKOUT.name();

			} else if (bookingEntity.getBookingHomestay().getLandlordOwner().getLandlordAccount().getUsername()
					.equals(userCheckOut.getUsername())) {

				status = BookingStatus.BOOKING_CHECKOUT_BY_LANDLORD.name();

			} else {

				status = BookingStatus.BOOKING_CHECKOUT_BY_PASSENGER_RELATIVE.name();

			}
			bookingEntity.setStatus(status);
			bookingEntity.setCheckOutBy(userCheckOut.getUsername());
			bookingEntity.setModifiedBy(userCheckOut.getUsername());
			bookingEntity.setModifiedDate(currentDate);
			userBookingHomestay.getWallet().setBalance(currentPassengerWalletAmount);
			userBookingHomestay.getWallet().setFuturePay(currentFuturePay);
			userBookingHomestay.getWallet().setModifiedBy(userBookingHomestay.getPassengerAccount().getUsername());
			userBookingHomestay.getWallet().setModifiedDate(currentDate);
			homestayOwner.getWallet().setBalance(landlordWalletBalanceAfterBookingSuccess);
			homestayOwner.getWallet().setModifiedBy(userBookingHomestay.getPassengerAccount().getUsername());
			homestayOwner.getWallet().setModifiedDate(currentDate);
			systemStatistic.setTotalProfit(systemTotalProfitAfterBookingSuccess);
			landlordStatistic.setTotalSuccessBooking(landlordTotalSuccessBooking);
			landlordStatistic.setTotalProfit(landlordTotalProfitAfterSuccessBooking);
			landlordStatistic.setTotalCommissionProfit(landlordTotalCommissionAfterSuccessBooking);
		}

		return bookingEntity;
	}

	@Transactional
	@Override
	public BookingDepositEntity payForBookingDeposit(Long bookingId, Long amount) {
		BookingEntity bookingEntity = this.findBookingById(bookingId);
		BookingDepositEntity bookingDepositEntity = bookingEntity.getBookingPaidDeposit();
		PassengerEntity passengerEntity = bookingEntity.getBookingCreator();
		PassengerWalletEntity passengerWalletEntity = passengerEntity.getWallet();
		Long newPassengerWalletBalance = passengerWalletEntity.getBalance() - amount;
		Long futurePayTotalAmount = passengerWalletEntity.getFuturePay() + (bookingEntity.getTotalPrice() - amount);
		passengerWalletEntity.setBalance(newPassengerWalletBalance);
		passengerWalletEntity.setFuturePay(futurePayTotalAmount);
		passengerWalletEntity.setModifiedBy(passengerEntity.getPassengerAccount().getUsername());
		passengerWalletEntity.setModifiedDate(currentDate);
		bookingEntity.setStatus(BookingStatus.BOOKING_PENDING.name());
		bookingDepositEntity.setDepositPaidAmount(amount);

		return bookingDepositEntity;
	}

	@Transactional
	@Override
	public BookingEntity passengerCancelBooking(Long bookingId) {
		BookingEntity bookingEntity = this.findBookingById(bookingId);
		PassengerEntity userCancelBooking = bookingEntity.getBookingCreator();
		LandlordEntity homestayOwner = bookingEntity.getBookingHomestay().getLandlordOwner();
		LandlordStatisticEntity landlordStatistic = this.landlordStatisticService.findLandlordStatisticByTime(DateParsingUtil.statisticYearMonthTime(currentDate));
		PassengerCancelBookingTicketEntity passengerTicketCancelBookingEntity = this
				.findPassengerCancelBookingTicketByBookingId(bookingId);
		PassengerWalletEntity passengerWallet = userCancelBooking.getWallet();
		LandlordWalletEntity landlordWallet = homestayOwner.getWallet();
		BookingDepositEntity bookingDeposit = bookingEntity.getBookingPaidDeposit();
		Long depositAmount = bookingDeposit.getDepositPaidAmount();
		Long futurePayTotalAmount = passengerWallet.getFuturePay()
				- (bookingEntity.getTotalPrice() - bookingDeposit.getDepositPaidAmount());
		Long passengerWalletCurrentBalance = passengerWallet.getBalance();
		Long landlordWalletCurrentBalance = landlordWallet.getBalance();
		
		Long totalCancelBooking = landlordStatistic.getTotalCancelBooking() + 1;

//		if (!bookingEntity.getStatus().equals(BookingStatus.BOOKING_PENDING_CHECKIN.name())) {
//			throw new ResourceNotAllowException("Not avalable cancel request");
//		}

		// huy truoc khi landlord xac nhan booking
		if (!(bookingEntity.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_PENDING.name())
				|| bookingEntity.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_PENDING_ALERT_SENT.name()))) {
			// truoc 7 ngay
			if (!this.isAfterSevenDay(passengerTicketCancelBookingEntity.getActiveDate(), bookingEntity.getCheckIn())) {
				// hủy lần đầu
				if (passengerTicketCancelBookingEntity.getFirstTimeCancelActive()) {
					System.out.println("First cancel");
					passengerWalletCurrentBalance = passengerWalletCurrentBalance + depositAmount;
					passengerWallet.setBalance(passengerWalletCurrentBalance);
					passengerWallet.setFuturePay(futurePayTotalAmount);
					passengerTicketCancelBookingEntity.setFirstTimeCancelActive(false);
					// hủy lần hai
				} else if (passengerTicketCancelBookingEntity.getSecondTimeCancelActive()) {
					System.out.println("Second cancel");
					passengerWalletCurrentBalance = passengerWalletCurrentBalance + (depositAmount * 95) / 100;
					landlordWalletCurrentBalance = landlordWalletCurrentBalance + (depositAmount * 5) / 100;
					passengerWallet.setBalance(passengerWalletCurrentBalance);
					passengerWallet.setFuturePay(futurePayTotalAmount);
					landlordWallet.setBalance(landlordWalletCurrentBalance);
					passengerTicketCancelBookingEntity.setSecondTimeCancelActive(false);
					// hủy lần 2 trở lên
				} else {
					System.out.println("Above second cancel");
					landlordWalletCurrentBalance = landlordWalletCurrentBalance + depositAmount;
					passengerWallet.setFuturePay(futurePayTotalAmount);
					landlordWallet.setBalance(landlordWalletCurrentBalance);
				}
			} else {
				landlordWalletCurrentBalance = landlordWalletCurrentBalance + depositAmount;
				passengerWallet.setFuturePay(futurePayTotalAmount);
				landlordWallet.setBalance(landlordWalletCurrentBalance);
			}
		} else {
			passengerWalletCurrentBalance = passengerWalletCurrentBalance + depositAmount;
			passengerWallet.setBalance(passengerWalletCurrentBalance);
			passengerWallet.setFuturePay(futurePayTotalAmount);
		}
		
		landlordStatistic.setTotalCancelBooking(totalCancelBooking);

		bookingEntity.setStatus(BookingStatus.BOOKING_CANCELED.name());

		return bookingEntity;
	}

	private boolean isAfterSevenDay(Date shieldBookingActiveDate, Date bookingCheckInDate) {
		long differentInTime = bookingCheckInDate.getTime() - shieldBookingActiveDate.getTime();
		long differentInDay = (differentInTime / (1000 * 60 * 60 * 24)) % 365;
		return differentInDay <= 7;
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
	public List<BookingEntity> getUserBookingList(String status) {
		UserEntity userEntity = userService
				.findUserByUserInfo(authenticationService.getAuthenticatedUser().getUsername());

		List<BookingEntity> bookingEntityList = status.equals("all")
				? this.bookingRepo.findAll().stream()
						.filter(b -> b.getBookingCreator().getPassengerAccount().getUsername()
								.equals(userEntity.getUsername()))
						.collect(Collectors.toList())
				: userEntity.getPassenger().getBooking().stream().filter(b -> b.getStatus().equalsIgnoreCase(status))
						.collect(Collectors.toList());

//		if (bookingEntityList.isEmpty()) {
//			throw new ResourceNotFoundException("There is no booking yet");
//		}

		return bookingEntityList;
	}

	@Override
	@Transactional
	public BookingEntity checkInByPassengerRelative(String bookingOtp) {
		UserEntity userCheckIn = userService
				.findUserByUserInfo(authenticationService.getAuthenticatedUser().getUsername());
		BookingEntity bookingEntity = this.findBookingByOtp(bookingOtp);
		if (bookingEntity != null && userCheckIn != null) {
			bookingEntity.setStatus(BookingStatus.BOOKING_CHECKIN_BY_PASSENGER_RELATIVE.name());
			bookingEntity.setCheckInBy(userCheckIn.getUsername());
			bookingEntity.setModifiedBy(userCheckIn.getUsername());
			bookingEntity.setModifiedDate(currentDate);
			return bookingEntity;
		} else {
			throw new ResourceNotFoundException("Booking or username not found");
		}
	}

	@Override
	public BookingEntity findBookingByOtp(String otp) {
		BookingEntity bookingEntity = bookingRepo.findBookingByOtp(otp)
				.orElseThrow(() -> new ResourceNotFoundException(otp, "Invalid booking otp"));

		return bookingEntity;
	}

	@Override
	public PassengerCancelBookingTicketEntity findPassengerCancelBookingTicketByBookingId(Long bookingId) {
		BookingEntity bookingEntity = this.findBookingById(bookingId);
		PassengerEntity userCancelBooking = bookingEntity.getBookingCreator();
		PassengerCancelBookingTicketEntity passengerTicketCancelBookingEntity = userCancelBooking.getCancelTicketList()
				.stream()
				.filter(s -> s.getHomestayTicketForCancel().getId().equals(bookingEntity.getBookingHomestay().getId()))
				.findAny().orElseThrow(() -> new ResourceNotFoundException("Shield not found"));

		return passengerTicketCancelBookingEntity;
	}

	@Override
	@Transactional
	public void remindPassengerBookingDate() {
		List<BookingEntity> bookingList = bookingRepo.findAll();
		String subject = "Reminder";
		for (BookingEntity bookingEntity : bookingList) {
			if (differentFromCurrentDateToCheckInDate(bookingEntity.getCheckIn()) == 7
					&& bookingEntity.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_PENDING_CHECKIN.name())) {
				log.info("mail send to passenger");
				String msg = ApplicationSendMailUtil.generateBookingDayRemainPassenger(
						differentFromCurrentDateToCheckInDate(bookingEntity.getCheckIn()),
						simpleDateFormat.format(bookingEntity.getCheckIn()));
				sendMailService.sendMail(bookingEntity.getBookingCreator().getPassengerAccount().getUsername(), msg,
						subject);
				bookingEntity.setStatus(BookingStatus.BOOKING_PENDING_CHECKIN_REMAIN_SENT.name());
			} else if (differentFromCurrentDateToCheckInDate(bookingEntity.getCheckIn()) == 7
					&& bookingEntity.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_PENDING.name())) {
				log.info("mail send to landlord");
				String msg = ApplicationSendMailUtil.generateBookingDayExpireLandlord(
						differentFromCurrentDateToCheckInDate(bookingEntity.getCheckIn()),
						simpleDateFormat.format(bookingEntity.getCheckIn()), bookingEntity.getId());
				sendMailService.sendMail(
						bookingEntity.getBookingHomestay().getLandlordOwner().getLandlordAccount().getUsername(), msg,
						subject);
				bookingEntity.setStatus(BookingStatus.BOOKING_PENDING_ALERT_SENT.name());
			} else if (differentFromCurrentDateToCheckInDate(bookingEntity.getCheckIn()) == 0
					&& bookingEntity.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_PENDING_CHECKIN.name())) {
				log.info("mail send to passenger");
				String msg = ApplicationSendMailUtil.generateStartBookingDatePassenger();
				sendMailService.sendMail(bookingEntity.getBookingCreator().getPassengerAccount().getUsername(), msg,
						subject);
				bookingEntity.setStatus(BookingStatus.BOOKING_PENDING_CHECKIN_APPOINTMENT_SENT.name());
			} else if (differentFromCurrentDateToCheckInDate(bookingEntity.getCheckIn()) < 0
					&& (bookingEntity.getStatus().equalsIgnoreCase(BookingStatus.BOOKING_PENDING_CHECKIN.name())
							|| bookingEntity.getStatus()
									.equalsIgnoreCase(BookingStatus.BOOKING_PENDING_CHECKIN_REMAIN_SENT.name())
							|| bookingEntity.getStatus()
									.equalsIgnoreCase(BookingStatus.BOOKING_PENDING_CHECKIN_APPOINTMENT_SENT.name()))) {
				this.passengerCancelBooking(bookingEntity.getId());
				String msg = ApplicationSendMailUtil.generateCancelBookingPassenger();
				sendMailService.sendMail(bookingEntity.getBookingCreator().getPassengerAccount().getUsername(), msg,
						subject);
			}
		}
	}

	private long differentFromCurrentDateToCheckInDate(Date checkIn) {
		long differentInTime = checkIn.getTime() - currentDate.getTime();
		long differentInDay = (differentInTime / (1000 * 60 * 60 * 24)) % 365;

		return differentInDay;
	}

	@Override
	public List<BookingEntity> getBookingPage(int page, int size) {
		Pageable bookingPage = PageRequest.of(page, size);
		List<BookingEntity> bookingList = bookingRepo.bookingPaging(bookingPage).getContent();

		return bookingList;
	}
	
}
