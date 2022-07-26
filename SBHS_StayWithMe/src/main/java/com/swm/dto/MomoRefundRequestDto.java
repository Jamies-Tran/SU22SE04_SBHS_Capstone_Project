package com.swm.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class MomoRefundRequestDto {
	private String partnerCode;
	private String orderId;
	private String requestId;
	private Long amount;
	private Long transId;
	private String lang;
	private String description;
	private String signature;
}
