package com.swm.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class MomoCaptureWalletRequestDto {
	private String accessKey;
	private String partnerCode;
	private String requestId;
	private Long amount;
	private String orderId;
	private String orderInfo;
	private String redirectUrl;
	private String ipnUrl;
	private String requestType;
	private String extraData;
	private String lang;
	private String signature;
}
