package com.swm.converter;

import org.springframework.stereotype.Component;

import com.swm.dto.wallet.MomoPaymentDto;
import com.swm.entity.MomoPaymentEntity;

@Component
public class MomoOrderProcessConverter {

	
	public MomoPaymentEntity momoPaymentToEntity(MomoPaymentDto momoPaymentDto) {
		MomoPaymentEntity momoOrderProcessEntity = new MomoPaymentEntity();
		momoOrderProcessEntity.setPartnerCode(momoPaymentDto.getPartnerCode());
		momoOrderProcessEntity.setOrderId(momoPaymentDto.getOrderId());
		momoOrderProcessEntity.setRequestId(momoPaymentDto.getRequestId());
		momoOrderProcessEntity.setAmount(momoPaymentDto.getAmount());
		momoOrderProcessEntity.setOrderInfo(momoPaymentDto.getOrderInfo());
		momoOrderProcessEntity.setOrderType(momoPaymentDto.getOrderType());
		momoOrderProcessEntity.setTransId(momoPaymentDto.getTransId());
		momoOrderProcessEntity.setRequestId(momoPaymentDto.getResultCode());
		momoOrderProcessEntity.setMessage(momoPaymentDto.getPayType());
		momoOrderProcessEntity.setExtraData(momoPaymentDto.getExtraData());
		momoOrderProcessEntity.setSignature(momoPaymentDto.getSignature());
		momoOrderProcessEntity.setResultCode(momoPaymentDto.getResultCode());
		
		return momoOrderProcessEntity;
	}
}
