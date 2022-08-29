package com.swm.serviceImpl;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.swm.entity.BookingDepositEntity;
import com.swm.entity.BookingEntity;
import com.swm.entity.BookingOtpEntity;
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

	// private Logger log = LoggerFactory.getLogger(BookingService.class);

	//private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

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
		bookingEntity.setBookingCreator(passengerEntity);
		bookingEntity.setCreatedBy(passengerEntity.getPassengerAccount().getUsername());
		bookingEntity.setCreatedDate(currentDate);
		bookingEntity.setCheckIn(bookingEntity.getCheckIn());
		bookingEntity.setCheckOut(bookingEntity.getCheckOut());
		bookingEntity.setStatus(BookingStatus.BOOKING_PENDING.name());
		bookingEntity.setBookingPaidDeposit(bookingDepositEntity);
		bookingEntity.setBookingOtp(bookingOtpEntity);

		BookingEntity bookingPersisted = bookingRepo.save(bookingEntity);

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
		if (!bookingEntity.getStatus().equals(BookingStatus.BOOKING_PENDING_CHECKIN.name())) {
			throw new ResourceNotAllowException("Check-in not availanle due to landlord haven't apporove your booking request");
		}
		
		if (checkInUserEntity.getUsername().equals(homestayOwnerEntity.getUsername())) {
			// chủ homestay check-in cho khách
			msg = ApplicationSendMailUtil.generateConfirmCheckInMessage(checkInUserEntity, homestayEntity,
					bookingEntity, AccountRole.LANDLORD.name());
			bookingStatus = BookingStatus.BOOKING_CHECKIN_BY_LANDLORD.name();
			bookingEntity.setStatus(bookingStatus);
			bookingEntity.setCheckInBy(checkInUserEntity.getUsername());
			bookingEntity.setModifiedBy(checkInUserEntity.getUsername());
			bookingEntity.setModifiedDate(currentDate);
			sendMailService.sendMail(bookingUserEntity.getUsername(), msg, "Booking confirm");
			return bookingEntity;
		} else {
			
			if(bookingEntity.getBookingCreator().getPassengerAccount().getUsername().equals(checkInUserEntity.getUsername())) {
				bookingStatus = BookingStatus.BOOKING_CONFIRM_CHECKIN.name();
			} else {
				bookingStatus = BookingStatus.BOOKING_CHECKIN_BY_PASSENGER_RELATIVE.name();
			}
			if(bookingOtpEntity.getCode().equals(bookingOtp)) {
				
				// người đặt check-in
				bookingEntity.setStatus(bookingStatus);
				bookingEntity.setCheckInBy(checkInUserEntity.getUsername());
				bookingEntity.setModifiedBy(checkInUserEntity.getUsername());
				bookingEntity.setModifiedDate(currentDate);
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
		if (isAccepted) {
			bookingEntity.setStatus(BookingStatus.BOOKING_PENDING_CHECKIN.name());
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
		if (amount.longValue() > passengerWalletEntity.getBalance().longValue()) {
			throw new InvalidBalanceException("Wallet ballance is not enough to make a transaction");
		} else if (!bookingEntity.getDeposit().equals(amount)) {
			throw new InvalidBalanceException("The amount must be equal to booking deposit");
		}
		Long newPassengerWalletBalance = passengerWalletEntity.getBalance() - amount;
		passengerWalletEntity.setBalance(newPassengerWalletBalance);
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
	public List<BookingEntity> getUserBookingList(String username, String status) {
		List<BookingEntity> bookingEntityList = status.equals("all")
				? bookingRepo.findAll().stream()
						.filter(b -> b.getBookingCreator().getPassengerAccount().getUsername().equals(username))
						.collect(Collectors.toList())
				: bookingRepo.findAll().stream()
						.filter(b -> b.getBookingCreator().getPassengerAccount().getUsername().equals(username)
								&& b.getStatus().equalsIgnoreCase(status))
						.collect(Collectors.toList());
		if (bookingEntityList.isEmpty()) {
			throw new ResourceNotFoundException("There is no booking yet");
		}

		return bookingEntityList;
	}

	@Override
	@Transactional
	public BookingEntity checkInByPassengerRelative(Long bookingId, String bookingOtp) {
		UserEntity userCheckIn = (UserEntity)authenticationService.getAuthenticatedUser();
		BookingEntity bookingEntity = this.findBookingById(bookingId);
		if(bookingEntity != null && userCheckIn != null) {
			if(userCheckIn.getUsername().equals(bookingEntity.getBookingCreator().getPassengerAccount().getUsername())) {
				return this.checkInByPassengerOrLandlord(bookingId, bookingOtp);
			} else {
				if(bookingOtp.equals(bookingEntity.getBookingOtp().getCode())) {
					bookingEntity.setStatus(BookingStatus.BOOKING_CHECKIN_BY_PASSENGER_RELATIVE.name());
					bookingEntity.setCheckInBy(userCheckIn.getUsername());
					bookingEntity.setModifiedBy(userCheckIn.getUsername());
					bookingEntity.setModifiedDate(currentDate);
					return bookingEntity;
				} else {
					throw new ResourceNotFoundException(bookingOtp, "Booking otp not correct");
				}
			}
		} else {
			throw new ResourceNotFoundException("Booking or username not found");
		}
	}

}
