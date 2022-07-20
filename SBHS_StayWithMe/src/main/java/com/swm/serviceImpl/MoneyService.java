package com.swm.serviceImpl;

import java.net.URI;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.swm.dto.MomoCaptureWalletRequestDto;
import com.swm.dto.MomoCaptureWalletResponseDto;
import com.swm.repository.IMomoProcessOrderRepository;
import com.swm.service.IBookingService;
import com.swm.service.IMoneyService;
import com.swm.service.IUserService;
import com.swm.util.MomoInfoUtil;
import com.swm.util.SignatureHashingUtil;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Service
public class MoneyService implements IMoneyService {

//	@Autowired
//	private IWalletRepository walletRepo;

	@Autowired
	private IMomoProcessOrderRepository momoProcessRepo;

	@Autowired
	private IUserService userService;

	@Autowired
	private IBookingService bookingService;

	Logger log = LoggerFactory.getLogger(MoneyService.class);

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

	/*
	 * 
	 * @AllArgsConstructor
	 * 
	 * @NoArgsConstructor
	 * 
	 * @Getter
	 * 
	 * @Setter public static class MomoRequestRefund { private String partnerCode;
	 * private String orderId; private String requestId; private Long amount;
	 * private Long transId; private String lang; private String description;
	 * private String signature; }
	 * 
	 * @AllArgsConstructor
	 * 
	 * @NoArgsConstructor
	 * 
	 * @Getter
	 * 
	 * @Setter public static class MomoResponseRefund { private String partnerCode;
	 * private String orderId; private String requestId; private Long amount;
	 * private Long transId; private int resultCode; private String message; private
	 * Long responseTime; }
	 * 
	 * @Transactional
	 * 
	 * @Override public void processPayment(MomoPaymentEntity momoProcess) { String
	 * userName = new
	 * String(Base64.getDecoder().decode(momoProcess.getExtraData())); ObjectMapper
	 * objectMapper = new ObjectMapper(); try { if
	 * (momoProcess.getOrderInfo().equalsIgnoreCase("landlord_wallet")) {
	 * UsernameMapper usernameMapper = objectMapper.readValue(userName,
	 * UsernameMapper.class); UserEntity userEntity =
	 * userService.findUserByUserInfo(usernameMapper.getUsername()); if
	 * (!userEntity.getStatus().equalsIgnoreCase(UserStatus.ACTIVE.name())) { throw
	 * new ResourceNotAllowException(userName, "account not active"); }
	 * MomoPaymentEntity momoPersisted = momoProcessRepo.save(momoProcess);
	 * LandlordEntity landLordEntity = userEntity.getLandlord(); WalletEntity
	 * walletEntity = landLordEntity.getWallet(); Long currentBalance =
	 * walletEntity.getBalance(); currentBalance = currentBalance +
	 * momoPersisted.getAmount(); walletEntity.setBalance(currentBalance);
	 * walletEntity.setMomoOrderList(List.of(momoPersisted));
	 * momoPersisted.setWalletOrder(walletEntity); } else if
	 * (momoProcess.getOrderInfo().equalsIgnoreCase("passenger_deposit")) { String
	 * bookingIdJsonString = new
	 * String(Base64.getDecoder().decode(momoProcess.getExtraData())); BookingMapper
	 * homestayMapper = objectMapper.readValue(bookingIdJsonString,
	 * BookingMapper.class); BookingEntity bookingEntity =
	 * bookingService.findBookingById(homestayMapper.getBookingId()); if
	 * (!bookingEntity.getStatus().equalsIgnoreCase(BookingStatus.
	 * BOOKING_PENDING_DEPOSIT.name())) { throw new
	 * ResourceNotAllowException(bookingEntity.getId().toString(),
	 * "Homestay owner hasn't accepted booking yet"); } MomoPaymentEntity
	 * momoPersisted = momoProcessRepo.save(momoProcess); BookingDepositEntity
	 * bookingDepositEntity = bookingEntity.getBookingPaidDeposit(); Long
	 * depositAmount = momoPersisted.getAmount();
	 * bookingDepositEntity.setDepositPaidAmount(depositAmount);
	 * bookingEntity.setStatus(BookingStatus.BOOKING_PENDING_CHECKIN.name()); } else
	 * { throw new ResourceNotFoundException("order info not found"); } } catch
	 * (JsonProcessingException e) { throw new ParseJsonException(e.getMessage()); }
	 * 
	 * }
	 * 
	 * @Override public void requestRefund(long amount, String description, String
	 * orderId, String requestId, long transId) { String rawHash = "accessKey=" +
	 * accessKey + "&amount=" + amount + "&description=" + description + "&orderId="
	 * + orderId + "&partnerCode=" + partnerCode + "&requestId=" + requestId +
	 * "&transId=" + transId; String signature =
	 * signatureHashing.sha256SigningKey(rawHash, secretKey); MomoRequestRefund
	 * momoRequestRefund = new MomoRequestRefund(partnerCode, orderId, requestId,
	 * amount, transId, lang, description, signature); try { RequestEntity<?>
	 * requestEntity = new RequestEntity<>(momoRequestRefund, HttpMethod.POST, new
	 * URI(momoApiRefundUrl)); restTemplate.exchange(requestEntity,
	 * MomoResponseRefund.class); } catch (URISyntaxException e) { // TODO
	 * Auto-generated catch block e.printStackTrace(); }
	 * 
	 * }
	 */
	private RestTemplate restTemplate = new RestTemplate();

	@Override
	public void processPayment(MomoCaptureWalletRequestDto momoCaptureRequest) {
		StringBuilder rawHash = new StringBuilder();
		rawHash.append("accessKey").append("=").append(momoCaptureRequest.getAccessKey())
				.append("&").append("amount").append("=").append(momoCaptureRequest.getAmount().toString())
				.append("&").append("extraData").append("=").append(momoCaptureRequest.getExtraData())
				.append("&").append("ipnUrl").append("=").append(momoCaptureRequest.getIpnUrl())
				.append("&").append("orderId").append("=").append(momoCaptureRequest.getOrderId())
				.append("&").append("orderInfo").append("=").append(momoCaptureRequest.getOrderInfo())
				.append("&").append("partnerCode").append("=").append(momoCaptureRequest.getPartnerCode())
				.append("&").append("redirectUrl").append("=").append(momoCaptureRequest.getRedirectUrl())
				.append("&").append("requestId").append("=").append(momoCaptureRequest.getRequestId())
				.append("&").append("requestType").append("=").append(momoCaptureRequest.getRequestType());
		log.info("Raw hash: " + rawHash.toString());
		String signature = SignatureHashingUtil.sha256HashSigningKey(MomoInfoUtil.secretKey, rawHash.toString());
		log.info("Signature: " + signature);
		momoCaptureRequest.setSignature(signature);
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<MomoCaptureWalletRequestDto> httpEntity = new HttpEntity<MomoCaptureWalletRequestDto>(
				momoCaptureRequest, headers);
		MomoCaptureWalletResponseDto momoCaptureWalletResponse = restTemplate
				.postForObject(MomoInfoUtil.MOMO_CREATE_ORDER_URL, httpEntity, MomoCaptureWalletResponseDto.class);
		log.info("Pay url: " + momoCaptureWalletResponse.getPayUrl());
	}

	@Override
	public void requestRefund(long amount, String description, String orderId, String requestId, long transId) {
		// TODO Auto-generated method stub

	}

}
