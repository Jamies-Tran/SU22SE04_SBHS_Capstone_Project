package com.swm.serviceImpl;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.swm.entity.AdminEntity;
import com.swm.entity.AvatarEntity;
import com.swm.entity.BaseWalletEntity;
import com.swm.entity.CitizenIdentificationEntity;
import com.swm.entity.LandlordAccountRequestEntity;
import com.swm.entity.LandlordEntity;
import com.swm.entity.LandlordWalletEntity;
import com.swm.entity.PassengerEntity;
import com.swm.entity.PassengerWalletEntity;
import com.swm.entity.UserEntity;
import com.swm.entity.UserOtpEntity;
import com.swm.entity.VoucherWalletEntity;
import com.swm.enums.RequestStatus;
import com.swm.enums.RequestType;
import com.swm.enums.UserStatus;
import com.swm.enums.WalletType;
import com.swm.exception.DuplicateResourceException;
import com.swm.exception.ResourceNotAllowException;
import com.swm.exception.ResourceNotFoundException;
import com.swm.repository.IUserOtpRepository;
import com.swm.repository.IUserRepository;
import com.swm.service.IAuthenticationService;
import com.swm.service.ISendMailService;
import com.swm.service.IUserService;

import net.bytebuddy.utility.RandomString;

@Service
public class UserService implements IUserService {

	@Autowired
	private IUserRepository userRepo;

	@Autowired
	private IUserOtpRepository userOtpRepo;

	@Autowired
	private ISendMailService sendMailService;

	@Autowired
	@Lazy
	private PasswordEncoder passwordEncoder;

	@Autowired
	@Lazy
	private IAuthenticationService authenticationService;

	private final String sendOtpToUserSubject = "Change password OTP";

	private Date currentDate = new Date();

	// private Logger log = LoggerFactory.getLogger(UserService.class);

	@Override
	public UserEntity findUserByUserInfo(String userInfo) {
		UserEntity userEntity;
		if (userInfo.contains("@")) {
			userEntity = userRepo.findUserByEmail(userInfo)
					.orElseThrow(() -> new ResourceNotFoundException(userInfo, "Email not found"));
		} else {
			userEntity = userRepo.findUserByUsername(userInfo)
					.orElseThrow(() -> new ResourceNotFoundException(userInfo, "Username not found"));
		}

		return userEntity;
	}

	@Override
	public UserEntity createPassengerUser(UserEntity userEntity) {
		if (userRepo.findUserByUsername(userEntity.getUsername()).isPresent()) {
			throw new DuplicateResourceException(userEntity.getUsername(), "User exist");
		} else if (userRepo.findUserByPhone(userEntity.getPhone()).isPresent()) {
			throw new DuplicateResourceException(userEntity.getPhone(), "Phone exist");
		} else if (userRepo.findUserByEmail(userEntity.getEmail()).isPresent()) {
			throw new DuplicateResourceException(userEntity.getEmail(), "Email exist");
		} else if (userRepo.findUserByCitizenIdentificationString(userEntity.getCitizenIdentificationString())
				.isPresent()) {
			throw new DuplicateResourceException(userEntity.getCitizenIdentificationString(),
					"Citizen identification exist");
		}
		// create avatar
		AvatarEntity avatar = userEntity.getAvatar();
		avatar.setPoster(userEntity);
		avatar.setCreatedDate(currentDate);
		avatar.setCreatedBy(userEntity.getUsername());
		PassengerEntity passengerAccount = new PassengerEntity();
		passengerAccount.setCreatedDate(currentDate);
		passengerAccount.setCreatedBy(userEntity.getUsername());
		passengerAccount.setPassengerAccount(userEntity);
		VoucherWalletEntity voucherWallet = new VoucherWalletEntity();
		voucherWallet.setVoucherWalletOwner(passengerAccount);
		voucherWallet.setCreatedDate(currentDate);
		voucherWallet.setCreatedBy(userEntity.getUsername());
		PassengerWalletEntity passengerWalletEntity = new PassengerWalletEntity();
		passengerWalletEntity.setOwner(passengerAccount);
		passengerWalletEntity.setCreatedDate(currentDate);
		passengerWalletEntity.setCreatedBy(userEntity.getUsername());
		passengerAccount.setCreatedBy(userEntity.getUsername());
		passengerAccount.setVoucherWallet(voucherWallet);
		passengerAccount.setWallet(passengerWalletEntity);
		userEntity.setPassenger(passengerAccount);
		userEntity.setStatus(UserStatus.ACTIVE.name());
		userEntity.setCreatedDate(currentDate);
		UserEntity userPersisted = userRepo.save(userEntity);

		return userPersisted;
	}

	@Override
	public UserEntity createLandlordUser(UserEntity userEntity, String citizenIdentificationUrlFront,
			String citizenIdentificationUrlBack) {
		if (userRepo.findUserByUsername(userEntity.getUsername()).isPresent()) {
			throw new DuplicateResourceException(userEntity.getUsername(), "User exist");
		} else if (userRepo.findUserByPhone(userEntity.getPhone()).isPresent()) {
			throw new DuplicateResourceException(userEntity.getPhone(), "Phone exist");
		} else if (userRepo.findUserByEmail(userEntity.getEmail()).isPresent()) {
			throw new DuplicateResourceException(userEntity.getEmail(), "Email exist");
		} else if (userRepo.findUserByCitizenIdentificationString(userEntity.getCitizenIdentificationString())
				.isPresent()) {
			throw new DuplicateResourceException(userEntity.getCitizenIdentificationString(),
					"Citizen identification exist");
		}
		// create avatar
		AvatarEntity avatarEntity = userEntity.getAvatar();
		avatarEntity.setPoster(userEntity);
		avatarEntity.setCreatedDate(currentDate);
		avatarEntity.setCreatedBy(userEntity.getUsername());
		// create landlord account
		LandlordEntity landlordAccount = new LandlordEntity();
		landlordAccount.setCreatedDate(currentDate);
		landlordAccount.setCreatedBy(userEntity.getUsername());
		// create landlord's citizen identification image url (cccd)
		CitizenIdentificationEntity citizenIdentificationFront = new CitizenIdentificationEntity();
		citizenIdentificationFront.setOwner(landlordAccount);
		citizenIdentificationFront.setCreatedDate(currentDate);
		citizenIdentificationFront.setCreatedBy(userEntity.getUsername());
		citizenIdentificationFront.setUrl(citizenIdentificationUrlFront);
		CitizenIdentificationEntity citizenIdentificationBack = new CitizenIdentificationEntity();
		citizenIdentificationBack.setOwner(landlordAccount);
		citizenIdentificationBack.setCreatedDate(currentDate);
		citizenIdentificationBack.setCreatedBy(userEntity.getUsername());
		citizenIdentificationBack.setUrl(citizenIdentificationUrlBack);
		landlordAccount.setCitizenIdentificationUrl(List.of(citizenIdentificationFront, citizenIdentificationBack));
		// create landlord's platform wallet
		LandlordWalletEntity wallet = new LandlordWalletEntity();
		wallet.setOwner(landlordAccount);
		wallet.setCreatedDate(currentDate);
		wallet.setCreatedBy(userEntity.getUsername());
		landlordAccount.setWallet(wallet);
		// create landlord account request
		LandlordAccountRequestEntity landlordAccountRequest = new LandlordAccountRequestEntity();
		landlordAccountRequest.setCreatedBy(userEntity.getUsername());
		landlordAccountRequest.setCreatedDate(currentDate);
		landlordAccountRequest.setAccountRequesting(landlordAccount);
		landlordAccountRequest.setStatus(RequestStatus.PENDING.name());
		landlordAccountRequest.setRequestType(RequestType.LANDLORD_CREATING_REQUEST.name());
		landlordAccount.setRequest(landlordAccountRequest);
		landlordAccount.setLandlordAccount(userEntity);
		userEntity.setLandlord(landlordAccount);
		userEntity.setCreatedDate(currentDate);
		userEntity.setStatus(UserStatus.PENDING.name());
		userEntity.setAvatar(avatarEntity);
		UserEntity userPersisted = userRepo.save(userEntity);

		return userPersisted;
	}

	@Override
	public UserEntity createAdminUser(UserEntity userEntity) {
		if (userRepo.findUserByUsername(userEntity.getUsername()).isPresent()) {
			throw new DuplicateResourceException(userEntity.getUsername(), "User exist");
		} else if (userRepo.findUserByPhone(userEntity.getPhone()).isPresent()) {
			throw new DuplicateResourceException(userEntity.getPhone(), "Phone exist");
		} else if (userRepo.findUserByEmail(userEntity.getEmail()).isPresent()) {
			throw new DuplicateResourceException(userEntity.getEmail(), "Email exist");
		} else if (userRepo.findUserByCitizenIdentificationString(userEntity.getCitizenIdentificationString())
				.isPresent()) {
			throw new DuplicateResourceException(userEntity.getCitizenIdentificationString(),
					"Citizen identification exist");
		}

		// create avatar
		AvatarEntity avatarEntity = userEntity.getAvatar();
		avatarEntity.setPoster(userEntity);
		avatarEntity.setCreatedBy(userEntity.getUsername());
		avatarEntity.setCreatedDate(currentDate);
		// create admin
		AdminEntity adminAccount = new AdminEntity();
		adminAccount.setCreatedBy(userEntity.getUsername());
		adminAccount.setCreatedDate(currentDate);
		adminAccount.setAdminAccount(userEntity);
		userEntity.setAdmin(adminAccount);
		userEntity.setStatus(UserStatus.ACTIVE.name());
		userEntity.setCreatedDate(currentDate);

		UserEntity userPersisted = userRepo.save(userEntity);

		return userPersisted;
	}

	@Override
	public UserEntity findUserById(Long Id) {
		UserEntity userEntity = userRepo.findById(Id)
				.orElseThrow(() -> new ResourceNotFoundException(Id.toString(), "User not found"));

		return userEntity;
	}

	@Override
	public UserOtpEntity createUserOtpByUserInfo(String userInfo) {
		String otpCode = this.generateUserOtp();
		UserEntity userEntity = this.findUserByUserInfo(userInfo);
		UserOtpEntity userOtpEntity = new UserOtpEntity();
		userOtpEntity.setCode(otpCode);
		userOtpEntity.setCreatedBy(userEntity.getUsername());
		userOtpEntity.setCreatedDate(currentDate);
		userOtpEntity.setOtpOwner(userEntity);
		userEntity.setUserOtp(userOtpEntity);
		String message = String.format("<p>We happy to send you your otp code: </p><br/>" + "<h1>%s</h1>", otpCode);
		sendMailService.sendMail(userEntity.getUsername(), message, this.sendOtpToUserSubject);
		UserOtpEntity userOtpPersisted = userOtpRepo.save(userOtpEntity);

		return userOtpPersisted;

	}

	@Transactional
	@Override
	public boolean checkUserOtp(String userInfo, String userOtp) {
		UserEntity userEntity = this.findUserByUserInfo(userInfo);
		String actualOtp = userEntity.getUserOtp().getCode();
		if (StringUtils.hasLength(actualOtp) && actualOtp.equals(userOtp)) {
			UserOtpEntity userOtpEntity = this.findUserOtpByCode(actualOtp);
			this.deleteUserOtp(userOtpEntity);
			userEntity.setPasswordChangable(true);
			return true;
		}

		return false;
	}

	@Override
	public UserOtpEntity findUserOtpByCode(String otp) {
		UserOtpEntity userOtpEntity = userOtpRepo.findUserOtpByUserCode(otp)
				.orElseThrow(() -> new ResourceNotFoundException(otp, "Otp not found"));

		return userOtpEntity;
	}

	@Override
	public void deleteUserOtp(UserOtpEntity userOtpEntity) {
		userOtpRepo.delete(userOtpEntity);
	}

	private String generateUserOtp() {
		RandomString randomOtp = new RandomString(4);
		String otp = randomOtp.nextString();
		while (userOtpRepo.findUserOtpByUserCode(otp).isPresent()) {
			otp = randomOtp.nextString();
		}

		return otp;
	}

	@Transactional
	@Override
	public UserEntity changePassword(String userInfo, String newPassword) {
		UserEntity userEntity = this.findUserByUserInfo(userInfo);
		if (!userEntity.getPasswordChangable().booleanValue()) {
			throw new ResourceNotAllowException(userInfo, "User did not enter change password otp.");
		}
		String encodeNewPassword = passwordEncoder.encode(newPassword);
		userEntity.setPassword(encodeNewPassword);
		userEntity.setPasswordChangable(false);

		return userEntity;
	}

	@Override
	public BaseWalletEntity findSystemWalletByUsername(String walletType) {
		String username = authenticationService.getAuthenticatedUser().getUsername();
		UserEntity userEntity = this.findUserByUserInfo(username);

		if (WalletType.valueOf(walletType.toUpperCase()).compareTo(WalletType.LANDLORD_WALLET) == 0) {
			if (userEntity.getLandlord() == null) {
				throw new ResourceNotAllowException("This account doesn't have lanflord wallet");
			}
			return userEntity.getLandlord().getWallet();
		} else if (WalletType.valueOf(walletType.toUpperCase()).compareTo(WalletType.PASSENGER_WALLET) == 0) {
			if (userEntity.getPassenger() == null) {
				throw new ResourceNotAllowException("This account doesn't have passenger wallet");
			}
			return userEntity.getPassenger().getWallet();
		}

		throw new ResourceNotFoundException("Wallet type not found.");

	}
}
