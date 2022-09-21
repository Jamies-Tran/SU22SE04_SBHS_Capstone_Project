package com.swm.service;

import com.swm.dto.wallet.MomoCaptureWalletRequestDto;
import com.swm.dto.wallet.MomoCaptureWalletResponseDto;
import com.swm.entity.MomoPaymentEntity;

public interface IPaymentService {
	MomoCaptureWalletResponseDto processPayment(MomoCaptureWalletRequestDto momoRequestPayment);
	
	MomoPaymentEntity findMomoPaymentById(Long Id);
	
	MomoPaymentEntity paymentResultHandling(MomoPaymentEntity momoPaymentEntity);
	
	//void requestRefund(MomoRefundRequestDto momoRefundRequest);
}
