package com.swm.controller;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.swm.dto.wallet.MomoCaptureWalletRequestDto;
import com.swm.dto.wallet.MomoCaptureWalletResponseDto;
import com.swm.enums.MomoResponseLanguage;
import com.swm.service.IPaymentService;
import com.swm.util.MomoInfoUtil;



@RestController
@RequestMapping("/api/payment")
public class PaymentController {
	
	@Autowired
	private IPaymentService moneyService;
	
	
	@PostMapping
	public ResponseEntity<?> paymentRequest(@RequestBody MomoCaptureWalletRequestDto momoCaptureRequestDto) {
		momoCaptureRequestDto.setPartnerCode(MomoInfoUtil.partnerCode);
		momoCaptureRequestDto.setRequestId(UUID.randomUUID().toString());
		momoCaptureRequestDto.setOrderId(UUID.randomUUID().toString());
		momoCaptureRequestDto.setRedirectUrl(MomoInfoUtil.MOMO_REDIRECT_URL);
		momoCaptureRequestDto.setIpnUrl(MomoInfoUtil.MOMO_IPN_URL);
		momoCaptureRequestDto.setRequestType(MomoInfoUtil.requestType);
		momoCaptureRequestDto.setLang(MomoResponseLanguage.VI.name().toLowerCase());
		MomoCaptureWalletResponseDto momoCaptureWalletResponseDto = moneyService.processPayment(momoCaptureRequestDto);
		
		return new ResponseEntity<>(momoCaptureWalletResponseDto, HttpStatus.CREATED);
	}
	
}
