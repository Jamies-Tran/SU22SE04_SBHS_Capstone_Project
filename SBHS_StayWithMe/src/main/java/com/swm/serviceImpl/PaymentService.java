package com.swm.serviceImpl;

import java.util.Base64;
import java.util.List;

import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.swm.dto.MomoCaptureWalletRequestDto;
import com.swm.dto.MomoCaptureWalletResponseDto;
import com.swm.dto.MomoRefundRequestDto;
import com.swm.dto.MomoRefundResponseDto;
import com.swm.entity.LandlordEntity;
import com.swm.entity.MomoPaymentEntity;
import com.swm.entity.PassengerEntity;
import com.swm.entity.PassengerWalletEntity;
import com.swm.entity.UserEntity;
import com.swm.entity.LandlordWalletEntity;
import com.swm.enums.UserStatus;
import com.swm.enums.WalletType;
import com.swm.exception.ParseJsonException;
import com.swm.exception.ResourceNotAllowException;
import com.swm.exception.ResourceNotFoundException;
import com.swm.repository.IMomoProcessOrderRepository;
import com.swm.service.IPaymentService;
import com.swm.service.IUserService;
import com.swm.util.MomoInfoUtil;
import com.swm.util.SignatureHashingUtil;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Service
public class PaymentService implements IPaymentService {

//	@Autowired
//	private IWalletRepository walletRepo;

	@Autowired
	private IMomoProcessOrderRepository momoProcessRepo;

	@Autowired
	private IUserService userService;

//	@Autowired
//	private IBookingService bookingService;

	Logger log = LoggerFactory.getLogger(PaymentService.class);

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

	private RestTemplate restTemplate = new RestTemplate();

	@Override
	public MomoCaptureWalletResponseDto processPayment(MomoCaptureWalletRequestDto momoCaptureRequest) {

		StringBuilder rawHash = new StringBuilder();
		rawHash.append("accessKey").append("=").append(MomoInfoUtil.accessKey).append("&").append("amount").append("=")
				.append(momoCaptureRequest.getAmount().toString()).append("&").append("extraData").append("=")
				.append(momoCaptureRequest.getExtraData()).append("&").append("ipnUrl").append("=")
				.append(momoCaptureRequest.getIpnUrl()).append("&").append("orderId").append("=")
				.append(momoCaptureRequest.getOrderId()).append("&").append("orderInfo").append("=")
				.append(momoCaptureRequest.getOrderInfo()).append("&").append("partnerCode").append("=")
				.append(momoCaptureRequest.getPartnerCode()).append("&").append("redirectUrl").append("=")
				.append(momoCaptureRequest.getRedirectUrl()).append("&").append("requestId").append("=")
				.append(momoCaptureRequest.getRequestId()).append("&").append("requestType").append("=")
				.append(momoCaptureRequest.getRequestType());
		log.info("Capture wallet raw hash: " + rawHash.toString());
		String signature = SignatureHashingUtil.sha256HashSigningKey(MomoInfoUtil.secretKey, rawHash.toString());
		log.info("Capture wallet signature: " + signature);
		momoCaptureRequest.setSignature(signature);
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<MomoCaptureWalletRequestDto> httpEntity = new HttpEntity<MomoCaptureWalletRequestDto>(
				momoCaptureRequest, headers);
		MomoCaptureWalletResponseDto momoCaptureWalletResponse = restTemplate
				.postForObject(MomoInfoUtil.MOMO_CREATE_ORDER_URL, httpEntity, MomoCaptureWalletResponseDto.class);
		log.info("Pay url: " + momoCaptureWalletResponse.getPayUrl());
		return momoCaptureWalletResponse;
	}

	@Override
	public void requestRefund(MomoRefundRequestDto momoRefundRequest) {

		StringBuilder rawHash = new StringBuilder();
		rawHash.append("accessKey").append("=").append(MomoInfoUtil.accessKey).append("&").append("amount").append("=")
				.append(momoRefundRequest.getAmount()).append("&").append("description").append("=")
				.append(momoRefundRequest.getDescription()).append("&").append("orderId").append("=")
				.append(momoRefundRequest.getOrderId()).append("&").append("partnerCode").append("=")
				.append(momoRefundRequest.getPartnerCode()).append("&").append("requestId").append("=")
				.append(momoRefundRequest.getRequestId()).append("&").append("transId").append("=")
				.append(momoRefundRequest.getTransId());
		log.info("Refund raw hash: " + rawHash.toString());
		String signature = SignatureHashingUtil.sha256HashSigningKey(MomoInfoUtil.secretKey, rawHash.toString());
		log.info("Refund signature: " + signature);
		momoRefundRequest.setSignature(signature);
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<MomoRefundRequestDto> httpEntity = new HttpEntity<MomoRefundRequestDto>(momoRefundRequest, headers);
		restTemplate.postForObject(MomoInfoUtil.MOMO_REFUND_URL, httpEntity, MomoRefundResponseDto.class);
		log.info("Response from momo: " + momoRefundRequest.toString());
	}

	@Transactional
	@Override
	public MomoPaymentEntity paymentResultHandling(MomoPaymentEntity momoPaymentEntity) {

		MomoPaymentEntity momoPersisted;
		Long currentBalance;
		String userName = new String(Base64.getDecoder().decode(momoPaymentEntity.getExtraData()));
		UsernameMapper usernameMapper = usenameMapperFromJson(userName);
		UserEntity userEntity = userService.findUserByUserInfo(usernameMapper.getUsername());
		if (!userEntity.getStatus().equalsIgnoreCase(UserStatus.ACTIVE.name())) {
			throw new ResourceNotAllowException(userName, "account not active");
		}
		momoPersisted = momoProcessRepo.save(momoPaymentEntity);
		WalletType walletType = WalletType.valueOf(momoPaymentEntity.getOrderInfo());
		switch (walletType) {
		case LANDLORD_WALLET:			
			LandlordEntity landLordEntity = userEntity.getLandlord();
			if(landLordEntity == null) {
				throw new ResourceNotFoundException("Invalid payment request");
			}
			LandlordWalletEntity landlordWalletEntity = landLordEntity.getWallet();
			currentBalance = landlordWalletEntity.getBalance();
			currentBalance = currentBalance + momoPersisted.getAmount();
			landlordWalletEntity.setBalance(currentBalance);
			landlordWalletEntity.setMomoPaymentList(List.of(momoPersisted));
			momoPersisted.setLandlordWallet(landlordWalletEntity);
			log.error("Payment process for landlord wallet");
			return momoPersisted;
		case PASSENGER_WALLET:
			PassengerEntity passengerEntity = userEntity.getPassenger();
			if(passengerEntity == null) {
				throw new ResourceNotFoundException("Invalid payment request");
			}
			PassengerWalletEntity passengerWalletEntity = passengerEntity.getWallet();
			currentBalance = passengerWalletEntity.getBalance();
			currentBalance = currentBalance + momoPersisted.getAmount();
			passengerWalletEntity.setBalance(currentBalance);
			passengerWalletEntity.setMomoPaymentList(List.of(momoPersisted));
			momoPersisted.setPassengerWallet(passengerWalletEntity);
			log.error("Payment procees for passenger wallet");
			return momoPersisted;
		default:
			throw new ResourceNotFoundException("order info not found");
		}

	}

	private UsernameMapper usenameMapperFromJson(String json) {
		ObjectMapper objecMapper = new ObjectMapper();
		try {
			UsernameMapper usernameMapper = objecMapper.readValue(json, UsernameMapper.class);
			return usernameMapper;
		} catch (JsonProcessingException e) {
			throw new ParseJsonException("Invalid orderInfo");
		}
	}

}
