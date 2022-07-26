package com.swm.controller;

import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.swm.dto.MomoCaptureWalletRequestDto;
import com.swm.dto.MomoCaptureWalletResponseDto;
import com.swm.dto.MomoRefundRequestDto;
import com.swm.enums.MomoResponseLanguage;
import com.swm.service.IPaymentService;
import com.swm.util.MomoInfoUtil;



@RestController
@RequestMapping("/api/payment")
public class PaymentController {
	
	@Autowired
	private IPaymentService moneyService;
	
	private Logger log = LoggerFactory.getLogger(PaymentController.class);
	
	@PostMapping
	public ResponseEntity<?> paymentRequest(@RequestBody MomoCaptureWalletRequestDto momoCaptureRequestDto) {
		momoCaptureRequestDto.setPartnerCode(MomoInfoUtil.partnerCode);
		momoCaptureRequestDto.setRequestId(MomoInfoUtil.requestId);
		momoCaptureRequestDto.setOrderId(MomoInfoUtil.orderId);
		momoCaptureRequestDto.setRedirectUrl(MomoInfoUtil.MOMO_REDIRECT_URL);
		momoCaptureRequestDto.setIpnUrl(MomoInfoUtil.MOMO_IPN_URL);
		momoCaptureRequestDto.setRequestType(MomoInfoUtil.requestType);
		momoCaptureRequestDto.setLang(MomoResponseLanguage.VI.name().toLowerCase());
		MomoCaptureWalletResponseDto momoCaptureWalletResponseDto = moneyService.processPayment(momoCaptureRequestDto);
		
		return new ResponseEntity<>(momoCaptureWalletResponseDto, HttpStatus.OK);
	}
	
	@PostMapping("/refund")
	public ResponseEntity<?> refundRequest(@RequestBody MomoRefundRequestDto momoRefundRequestDto) {
		log.info("Momo transId: " + momoRefundRequestDto.getTransId());
		momoRefundRequestDto.setPartnerCode(MomoInfoUtil.partnerCode);
		momoRefundRequestDto.setRequestId(UUID.randomUUID().toString());
		momoRefundRequestDto.setOrderId(UUID.randomUUID().toString());
		momoRefundRequestDto.setLang(MomoResponseLanguage.VI.name().toLowerCase());
		moneyService.requestRefund(momoRefundRequestDto);
		
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	/*
	@AllArgsConstructor
	@NoArgsConstructor
	@Getter
	@Setter
	public static class MomoRequestRefund {
		private String partnerCode;
		private String orderId;
		private String requestId;
		private Long amount;
		private Long transId;
		private String lang;
		private String description;
		private String signature;
	}
	
	@AllArgsConstructor
	@NoArgsConstructor
	@Getter
	@Setter
	public static class MomoResponseRefund {
		private String partnerCode;
		private String orderId;
		private String requestId;
		private Long amount;
		private Long transId;
		private int resultCode;
		private String message;
		private Long responseTime;
	}
	
	@AllArgsConstructor
	@NoArgsConstructor
	@Getter
	@Setter
	public static class MomoRequestPayment {
		private String partnerCode;
		private String partnerName;
		private String storeId;
		private String requestId;
		private String amount;
		private String orderId;
		private String orderInfo;
		private String redirectUrl;
		private String ipnUrl;
		private String lang;
		private String extraData;
		private String requestType;
		private String signature;
	}

	@Value("${momo.partner.code}")
	private String partnerCode;
	@Value("${momo.access.key}")
	private String accessKey;
	@Value("${momo.secret.key}")
	private String secretKey;
	private String amount = "1000";
	private String description = "";
	private String orderId = UUID.randomUUID().toString();
	private String requestId = UUID.randomUUID().toString();
	private Long transId = 2698858435L;
	private String lang = "vi";
	
	
	private String extraData = "cGFzc2VuZ2VyMDAx";
	private String orderInfo = "landlord_wallet";
	private String ipnUrl = "http://localhost:8080/api/wallet/payment";
	private String redirectUrl = "http://localhost:8080/momo/redirect";
	private String requestType = "captureWallet";
	

	@GetMapping
	public ResponseEntity<?> requestRefund() {
		String msg = "accessKey=" + accessKey + "&amount=" + amount + "&description=" + description + "&orderId="
				+ orderId + "&partnerCode=" + partnerCode + "&requestId=" + requestId + "&transId=" + transId;
		String signature = signatureHashing.sha256SigningKey(msg);
		MomoRequestRefund momoRefund = new MomoRequestRefund(partnerCode, orderId, requestId, amount, transId, lang, description, signature);
		try {
			RequestEntity<?> requestEntity = new RequestEntity<>(momoRefund, HttpMethod.POST, new URI(MOMO_API_REFUND));
			return restTemplate.exchange(requestEntity, MomoResponseRefund.class);
		} catch (URISyntaxException e) {
			return new ResponseEntity<>(HttpStatus.EXPECTATION_FAILED);
		}
	}
	
	@GetMapping
	public ResponseEntity<?> requestRefund() {
//		String rawHash = "accessKey=" + accessKey +
//                "&amount=" + amount +
//                "&extraData=" + extraData +
//                "&ipnUrl=" + ipnUrl +
//                "&orderId=" + orderId +
//                "&orderInfo=" + orderInfo +
//                "&partnerCode=" + partnerCode +
//                "&redirectUrl=" + redirectUrl +
//                "&requestId=" + requestId +
//                "&requestType=" + requestType;
		String rawHash = "accessKey=jaRcr7hDRUVLMTpB&amount=55000&extraData=cGFzc2VuZ2VyMDAx=&ipnUrl=https://webhook.site/b3088a6a-2d17-4f8d-a383-71389a6c600b&orderId=118a4595-87be-4241-9e7f-0a1da8a38d8d&orderInfo=test&partnerCode=MOMO3I0H20220705&redirectUrl=https://webhook.site/b3088a6a-2d17-4f8d-a383-71389a6c600b&requestId=d6d6affd-6ffa-4897-b8d7-c58364e30495&requestType=captureWallet";
		String signature = "6d337faba69b6ad102f9e7b1af199ea19610f32b542b51d8ded583dc95fa2bde";
		System.out.println(signature);
		MomoRequestPayment momoRequestPayment = new MomoRequestPayment(partnerCode, "Test", "MomoTestStore", "d6d6affd-6ffa-4897-b8d7-c58364e30495", "5500", "118a4595-87be-4241-9e7f-0a1da8a38d8d", "test", "https://webhook.site/b3088a6a-2d17-4f8d-a383-71389a6c600b", "https://webhook.site/b3088a6a-2d17-4f8d-a383-71389a6c600b", "en", "cGFzc2VuZ2VyMDAx", "captureWallet", signature);
		try {
			System.out.println(MediaType.APPLICATION_JSON.toString());
			RequestEntity<?> requestEntity = new RequestEntity<>(momoRequestPayment, HttpMethod.POST, new URI(MOMO_API_REFUND));
			return restTemplate.exchange(requestEntity, MomoRequestPayment.class);
		} catch (URISyntaxException e) {
			return new ResponseEntity<>(HttpStatus.EXPECTATION_FAILED);
		}
	}
	*/
}
