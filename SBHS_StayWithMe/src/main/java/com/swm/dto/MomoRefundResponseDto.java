package com.swm.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class MomoRefundResponseDto {
	private String partnerCode;
	private String orderId;
	private Long amount;
	private Long transId;
	private int resultCode;
	private String message;
	private Long responseTime;
}
