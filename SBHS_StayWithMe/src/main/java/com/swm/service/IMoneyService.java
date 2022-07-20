package com.swm.service;

import com.swm.dto.MomoCaptureWalletRequestDto;

public interface IMoneyService {
	void processPayment(MomoCaptureWalletRequestDto momoRequestPayment);
	
	void requestRefund(long amount, String description, String orderId, String requestId, long transId);
}
