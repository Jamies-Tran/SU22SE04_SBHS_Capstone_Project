package com.swm.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class MomoOrderProcessDto {
	private String partnerCode;
	private String orderId;
	private String requestId;
	private Long amount;
	private String orderInfo;
	private String orderType;
	private String transId;
	private String resultCode;
	private String message;
	private String payType;
	private String extraData;
	private String signature;

}
