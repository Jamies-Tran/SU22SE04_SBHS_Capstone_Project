package com.swm.serviceImpl;

import java.util.Base64;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.swm.entity.BookingDepositEntity;
import com.swm.entity.BookingEntity;
import com.swm.entity.LandlordEntity;
import com.swm.entity.MomoOrderProcessEntity;
import com.swm.entity.UserEntity;
import com.swm.entity.WalletEntity;
import com.swm.enums.UserStatus;
import com.swm.exception.ParseJsonException;
import com.swm.exception.ResourceNotAllowException;
import com.swm.exception.ResourceNotFoundException;
import com.swm.repository.IMomoProcessOrderRepository;
import com.swm.service.IBookingService;
import com.swm.service.IMoneyService;
import com.swm.service.IUserService;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Service
public class MoneyService implements IMoneyService {

	@AllArgsConstructor
	@NoArgsConstructor
	@Getter
	@Setter
	public static class UsernameMapper {
		private String username;
	}

	@AllArgsConstructor
	@NoArgsConstructor
	@Getter
	@Setter
	public static class BookingMapper {
		private Long bookingId;
	}

//	@Autowired
//	private IWalletRepository walletRepo;

	@Autowired
	private IMomoProcessOrderRepository momoProcessRepo;

	@Autowired
	private IUserService userService;

	@Autowired
	private IBookingService bookingService;

	@Transactional
	@Override
	public void addWalletBalance(MomoOrderProcessEntity momoProcess) {
		String userName = new String(Base64.getDecoder().decode(momoProcess.getExtraData()));
		ObjectMapper objectMapper = new ObjectMapper();
		try {
			if (momoProcess.getOrderInfo().equalsIgnoreCase("landlord_wallet")) {
				UsernameMapper usernameMapper = objectMapper.readValue(userName, UsernameMapper.class);
				UserEntity userEntity = userService.findUserByUsername(usernameMapper.getUsername());
				if (!userEntity.getStatus().equalsIgnoreCase(UserStatus.ACTIVE.name())) {
					throw new ResourceNotAllowException(userName, "account not active");
				}
				MomoOrderProcessEntity momoPersisted = momoProcessRepo.save(momoProcess);
				LandlordEntity landLordEntity = userEntity.getLandlord();
				WalletEntity walletEntity = landLordEntity.getWallet();
				Long currentBalance = walletEntity.getBalance();
				currentBalance = currentBalance + momoPersisted.getAmount();
				walletEntity.setBalance(currentBalance);
				walletEntity.setMomoOrderList(List.of(momoPersisted));
				momoPersisted.setWalletOrder(walletEntity);
			} else if (momoProcess.getOrderInfo().equalsIgnoreCase("passenger_deposit")) {
				String bookingIdJsonString = new String(Base64.getDecoder().decode(momoProcess.getExtraData()));
				BookingMapper homestayMapper = objectMapper.readValue(bookingIdJsonString, BookingMapper.class);
				BookingEntity bookingEntity = bookingService.findBookingById(homestayMapper.getBookingId());
				MomoOrderProcessEntity momoPersisted = momoProcessRepo.save(momoProcess);
				BookingDepositEntity bookingDepositEntity = bookingEntity.getBookingDeposit();
				Long depositAmount = momoPersisted.getAmount();
				bookingDepositEntity.setDepositAmount(depositAmount);
			} else {
				throw new ResourceNotFoundException("order info not found");
			}
		} catch (JsonProcessingException e) {
			throw new ParseJsonException(e.getMessage());
		}

	}
}
