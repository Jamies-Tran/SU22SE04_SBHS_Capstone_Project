package com.swm.converter;

import org.springframework.stereotype.Component;

import com.swm.dto.WalletDto;
import com.swm.entity.WalletEntity;

@Component
public class WalletConverter {
	public WalletDto walletToDto(WalletEntity walletEntity) {
		WalletDto walletDto = new WalletDto();
		walletDto.setAmount(walletEntity.getBalance());
		walletDto.setOrderInfo(walletEntity.getOwner().getLandlordAccount().getUsername());
		
		return walletDto;
	}
}
