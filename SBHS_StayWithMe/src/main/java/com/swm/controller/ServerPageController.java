package com.swm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.swm.converter.MomoOrderProcessConverter;
import com.swm.dto.MomoPaymentDto;
import com.swm.entity.BookingEntity;
import com.swm.entity.MomoPaymentEntity;
import com.swm.service.IBookingService;
import com.swm.service.IPaymentService;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Controller
public class ServerPageController {
	@AllArgsConstructor
	@NoArgsConstructor
	@Getter
	@Setter
	public static class CheckInConfirm {
		private Long bookingId;
		private String confirmCheckIn;
	}
	
	
	@Autowired
	private IPaymentService walletService;
	
	@Autowired
	private IBookingService bookingService;
	
	@Autowired
	private MomoOrderProcessConverter momoOrderProcessConvert;
	
	@GetMapping("/momo/redirect")
	public String redirectConfirmPaymentPage(@RequestParam String partnerCode, @RequestParam String orderId,
			@RequestParam String requestId, @RequestParam Long amount, @RequestParam String orderInfo,
			@RequestParam String orderType, @RequestParam Long transId, @RequestParam String resultCode,
			@RequestParam String message, @RequestParam String payType, @RequestParam String extraData,
			@RequestParam String signature, Model model) {
		
		
		MomoPaymentDto momoPaymentDto = new MomoPaymentDto(
				partnerCode, orderId, requestId, amount, orderInfo.toUpperCase(), orderType, transId, resultCode, message, payType, extraData, signature);
		MomoPaymentEntity momoOrderProcessEntity = momoOrderProcessConvert.momoPaymentToEntity(momoPaymentDto);
		
		walletService.paymentResultHandling(momoOrderProcessEntity);

		return "payment_success";
	}
	
	@GetMapping("/checkin/redirect/{bookingId}")	
	public String redirectCheckInPage(Model model, @PathVariable("bookingId") Long bookingId) {
		CheckInConfirm checkInConfirm = new CheckInConfirm();
		checkInConfirm.setBookingId(bookingId);
		model.addAttribute("checkInConfirm", checkInConfirm);
		
		return "confirm_checkin";
	}
	
	@PostMapping("/checkin/confirm")	
	public String redirectConfirmCheckInPage(Model model, @ModelAttribute CheckInConfirm checkInConfirm) {
		boolean isAccepted = checkInConfirm.getConfirmCheckIn().equalsIgnoreCase("Accept");
		String message = "";
		BookingEntity bookingEntity = bookingService.findBookingById(checkInConfirm.getBookingId());
		
		if(isAccepted) {
			message = "Thanks for your confirmation";
		} else {
			message = "You have denied request check-in of "+bookingEntity.getCheckInBy()+" from your booking at homestay "+bookingEntity.getBookingHomestay().getName()+".";
		}
		bookingService.confirmCheckIn(checkInConfirm.getBookingId(), isAccepted);
		model.addAttribute("message", message);
		return "confirm_checkin_success";
	}
}
