package com.swm.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class MomoPaymentDto {
	private String partnerCode;
	private String orderId;
	private String requestId;
	private Long amount;
	private String orderInfo;
	private String orderType;
	private Long transId;
	private String resultCode;
	private String message;
	private String payType;
	private String extraData;
	private String signature;
}
