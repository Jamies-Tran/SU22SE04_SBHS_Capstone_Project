package com.swm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.swm.converter.MomoOrderProcessConverter;
import com.swm.dto.MomoOrderProcessDto;
import com.swm.entity.MomoOrderProcessEntity;
import com.swm.service.IMoneyService;

@Controller
public class MomoController {
	@Autowired
	private IMoneyService walletService;
	
	@Autowired
	private MomoOrderProcessConverter momoOrderProcessConvert;
	
	@GetMapping("/momo/redirect")
	public String captureRedirectUrl(@RequestParam String partnerCode, @RequestParam String orderId,
			@RequestParam String requestId, @RequestParam Long amount, @RequestParam String orderInfo,
			@RequestParam String orderType, @RequestParam String transId, @RequestParam String resultCode,
			@RequestParam String message, @RequestParam String payType, @RequestParam String extraData,
			@RequestParam String signature, Model model) {
		
		MomoOrderProcessDto momoOrderProcessDto = new MomoOrderProcessDto(
				partnerCode, orderId, requestId, amount, orderInfo, orderType, transId, resultCode, message, payType, extraData, signature);
		MomoOrderProcessEntity  momoOrderProcessEntity = momoOrderProcessConvert.momoOrderProcessToEntity(momoOrderProcessDto);
		walletService.addWalletBalance(momoOrderProcessEntity);

		return "payment_success";
	}
}
