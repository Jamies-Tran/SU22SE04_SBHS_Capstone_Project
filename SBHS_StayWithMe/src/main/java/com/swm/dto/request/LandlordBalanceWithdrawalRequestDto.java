package com.swm.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class LandlordBalanceWithdrawalRequestDto extends RequestDto{
	private Long Id;
	private Long amount;
	private String landlordPhone;
}
