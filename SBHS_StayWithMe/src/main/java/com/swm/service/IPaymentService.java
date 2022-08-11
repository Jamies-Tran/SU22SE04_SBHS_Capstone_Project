package com.swm.service;

import com.swm.dto.MomoCaptureWalletRequestDto;
import com.swm.dto.MomoCaptureWalletResponseDto;
import com.swm.entity.MomoPaymentEntity;

public interface IPaymentService {
	MomoCaptureWalletResponseDto processPayment(MomoCaptureWalletRequestDto momoRequestPayment);
	
	MomoPaymentEntity paymentResultHandling(MomoPaymentEntity momoPaymentEntity);
	
	//void requestRefund(MomoRefundRequestDto momoRefundRequest);
}
