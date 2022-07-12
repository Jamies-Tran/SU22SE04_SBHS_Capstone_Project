package com.swm.serviceImpl;

import java.io.UnsupportedEncodingException;
import java.util.Date;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.swm.entity.AdminEntity;
import com.swm.entity.AvatarEntity;
import com.swm.entity.CitizenIdentificationEntity;
import com.swm.entity.LandlordAccountRequestEntity;
import com.swm.entity.LandlordEntity;
import com.swm.entity.PassengerEntity;
import com.swm.entity.UserEntity;
import com.swm.entity.UserOtpEntity;
import com.swm.entity.VoucherWalletEntity;
import com.swm.entity.WalletEntity;
import com.swm.enums.RequestStatus;
import com.swm.enums.RequestType;
import com.swm.enums.UserStatus;
import com.swm.exception.DuplicateResourceException;
import com.swm.exception.ResourceNotFoundException;
import com.swm.repository.IUserOtpRepository;
import com.swm.repository.IUserRepository;
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

	private Date currentDate = new Date();

	@Override
	public UserEntity findUserByUsername(String username) {
		UserEntity user = userRepo.findUserByUsername(username)
				.orElseThrow(() -> new UsernameNotFoundException("Username not found."));

		return user;
	}

	@Override
	public UserEntity createPassengerUser(UserEntity userEntity) {
		if (userRepo.findUserByUsername(userEntity.getUsername()).isPresent()) {
			throw new DuplicateResourceException(userEntity.getUsername(), "User exist");
		} else if (userRepo.findUserByPhone(userEntity.getPhone()).isPresent()) {
			throw new DuplicateResourceException(userEntity.getPhone(), "Phone exist");
		} else if (userRepo.findUserByEmail(userEntity.getEmail()).isPresent()) {
			throw new DuplicateResourceException(userEntity.getEmail(), "Email exist");
		}
		// create avatar
		AvatarEntity avatar = userEntity.getAvatar();
		avatar.setPoster(userEntity);
		avatar.setCreatedDate(currentDate);
		avatar.setCreatedBy(userEntity.getUsername());
		// create passenger account
		PassengerEntity passengerAccount = new PassengerEntity();
		passengerAccount.setCreatedDate(currentDate);
		passengerAccount.setCreatedBy(userEntity.getUsername());
		passengerAccount.setPassengerAccount(userEntity);
		VoucherWalletEntity voucherWallet = new VoucherWalletEntity();
		voucherWallet.setVoucherWalletOwner(passengerAccount);
		voucherWallet.setCreatedDate(currentDate);
		voucherWallet.setCreatedBy(userEntity.getUsername());
		passengerAccount.setVoucherWallet(voucherWallet);
		userEntity.setPassenger(passengerAccount);
		userEntity.setStatus(UserStatus.ACTIVE.name());
		userEntity.setCreatedDate(currentDate);
		UserEntity userPersisted = userRepo.save(userEntity);

		return userPersisted;
	}

	@Override
	public UserEntity createLandlordUser(UserEntity userEntity, String citizenIdentificationUrl) {
		if (userRepo.findUserByUsername(userEntity.getUsername()).isPresent()) {
			throw new DuplicateResourceException(userEntity.getUsername(), "User exist");
		} else if (userRepo.findUserByPhone(userEntity.getPhone()).isPresent()) {
			throw new DuplicateResourceException(userEntity.getPhone(), "Phone exist");
		} else if (userRepo.findUserByEmail(userEntity.getEmail()).isPresent()) {
			throw new DuplicateResourceException(userEntity.getEmail(), "Email exist");
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
		CitizenIdentificationEntity citizenIdentification = new CitizenIdentificationEntity();
		citizenIdentification.setOwner(landlordAccount);
		citizenIdentification.setCreatedDate(currentDate);
		citizenIdentification.setCreatedBy(userEntity.getUsername());
		citizenIdentification.setUrl(citizenIdentificationUrl);
		landlordAccount.setCitizenIdentificationUrl(citizenIdentification);
		// create landlord's platform wallet
		WalletEntity wallet = new WalletEntity();
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
	public UserEntity findUserByEmail(String email) {
		UserEntity userEntity = userRepo.findUserByEmail(email)
				.orElseThrow(() -> new ResourceNotFoundException(email, "user not found"));
		
		return userEntity;
	}


	@Override
	public void createUserOtpByUserInfo(String userInfo) {
		String otpCode = RandomString.make(4);
		UserOtpEntity userOtpEntity = new UserOtpEntity();
		if(userInfo.contains("@")) {
			UserEntity userEntity = this.findUserByEmail(userInfo);
			userOtpEntity.setCode(otpCode);
			userOtpEntity.setCreatedBy(userEntity.getUsername());
			userOtpEntity.setCreatedDate(currentDate);
			userOtpEntity.setOtpOwner(userEntity);
			userEntity.setUserOtp(userOtpEntity);
			try {
				sendMailService.sendOtpToUserEmail(userEntity.getUsername());
			} catch (UnsupportedEncodingException | MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			userOtpRepo.save(userOtpEntity);
		} else {
			UserEntity userEntity = this.findUserByUsername(userInfo);
			userOtpEntity.setCode(otpCode);
			userOtpEntity.setCreatedBy(userInfo);
			userOtpEntity.setCreatedDate(currentDate);
			userOtpEntity.setOtpOwner(userEntity);
			userEntity.setUserOtp(userOtpEntity);
			try {
				sendMailService.sendOtpToUserEmail(userInfo);
			} catch (UnsupportedEncodingException | MessagingException e) {
				e.printStackTrace();
			}
		}
		
		userOtpRepo.save(userOtpEntity);
	}

	@Override
	public boolean checkUserOtp(String userInfo, String userOtp) {
		UserEntity userEntity;
		if (userInfo.contains("@")) {
			userEntity = this.findUserByEmail(userInfo);
		} else {
			userEntity = this.findUserByUsername(userInfo);
		}
		String actualOtp = userEntity.getUserOtp().getCode();
		if(StringUtils.hasLength(actualOtp) && actualOtp.equals(userOtp)) {
			return true;
		}
		
		return false;
	}

}
