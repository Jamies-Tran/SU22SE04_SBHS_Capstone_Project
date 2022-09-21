package com.swm.converter;

import org.springframework.stereotype.Component;

import com.swm.dto.wallet.WalletDto;
import com.swm.entity.LandlordWalletEntity;

@Component
public class WalletConverter {
	public WalletDto walletToDto(LandlordWalletEntity walletEntity) {
		WalletDto walletDto = new WalletDto();
		walletDto.setAmount(walletEntity.getBalance());
		walletDto.setOrderInfo(walletEntity.getOwner().getLandlordAccount().getUsername());
		
		return walletDto;
	}
}
