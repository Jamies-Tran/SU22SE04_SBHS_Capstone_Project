package com.swm.converter;

import org.springframework.stereotype.Component;

import com.swm.dto.MomoOrderProcessDto;
import com.swm.entity.MomoOrderProcessEntity;

@Component
public class MomoOrderProcessConverter {
	public MomoOrderProcessEntity momoOrderProcessToEntity(MomoOrderProcessDto momoOrderProcessDto) {
		MomoOrderProcessEntity momoOrderProcessEntity = new MomoOrderProcessEntity();
		momoOrderProcessEntity.setPartnerCode(momoOrderProcessDto.getPartnerCode());
		momoOrderProcessEntity.setOrderId(momoOrderProcessDto.getOrderId());
		momoOrderProcessEntity.setRequestId(momoOrderProcessDto.getRequestId());
		momoOrderProcessEntity.setAmount(momoOrderProcessDto.getAmount());
		momoOrderProcessEntity.setOrderInfo(momoOrderProcessDto.getOrderInfo());
		momoOrderProcessEntity.setOrderType(momoOrderProcessDto.getOrderType());
		momoOrderProcessEntity.setTransId(momoOrderProcessDto.getTransId());
		momoOrderProcessEntity.setRequestId(momoOrderProcessDto.getResultCode());
		momoOrderProcessEntity.setMessage(momoOrderProcessDto.getPayType());
		momoOrderProcessEntity.setExtraData(momoOrderProcessDto.getExtraData());
		momoOrderProcessEntity.setSignature(momoOrderProcessDto.getSignature());
		momoOrderProcessDto.setResultCode(momoOrderProcessDto.getResultCode());
		
		return momoOrderProcessEntity;
	}
}
