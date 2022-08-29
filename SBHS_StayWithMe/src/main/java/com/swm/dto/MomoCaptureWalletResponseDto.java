package com.swm.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class MomoCaptureWalletResponseDto {
	private String partnerCode;
	private String requestId;
	private String orderId;
	private Long amount;
	private Long responseTime;
	private String message;
	private Integer resultCode;
	private String deeplink;
	private String payUrl;
}
