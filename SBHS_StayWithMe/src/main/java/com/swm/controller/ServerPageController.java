package com.swm.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Base64;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.swm.converter.MomoOrderProcessConverter;
import com.swm.dto.wallet.MomoPaymentDto;
import com.swm.entity.BookingEntity;
import com.swm.entity.MomoPaymentEntity;
import com.swm.entity.UserEntity;
import com.swm.enums.WalletType;
import com.swm.exception.ParseJsonException;
import com.swm.service.IBookingService;
import com.swm.service.IPaymentService;
import com.swm.service.IUserService;
import com.swm.serviceImpl.PaymentService.UsernameMapper;

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
	private IUserService userService;
	
	@Autowired
	private MomoOrderProcessConverter momoOrderProcessConvert;
	
	@GetMapping("/momo/redirect")
	public void redirectConfirmPaymentPage(@RequestParam String partnerCode, @RequestParam String orderId,
			@RequestParam String requestId, @RequestParam Long amount, @RequestParam String orderInfo,
			@RequestParam String orderType, @RequestParam Long transId, @RequestParam String resultCode,
			@RequestParam String message, @RequestParam String payType, @RequestParam String extraData,
			@RequestParam String signature, HttpServletResponse response) {
		
		
		MomoPaymentDto momoPaymentDto = new MomoPaymentDto(
				partnerCode, orderId, requestId, amount, orderInfo.toUpperCase(), orderType, transId, resultCode, message, payType, extraData, signature);
		MomoPaymentEntity momoOrderProcessEntity = momoOrderProcessConvert.momoPaymentToEntity(momoPaymentDto);
		
		MomoPaymentEntity momoPaymentEntity = walletService.paymentResultHandling(momoOrderProcessEntity);

		if(momoPaymentEntity.getOrderInfo().equalsIgnoreCase(WalletType.LANDLORD_WALLET.name())) {
			try {
				response.sendRedirect("/momo/landlord/payment-success");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			try {
				response.sendRedirect("/momo/passenger/payment-success?id=" + momoPaymentEntity.getId());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
	
		}
		
	}
	
	@GetMapping("/momo/landlord/payment-success")
	public String navigateToLandlordSuccessPayment() {
		return "landlord_payment_success";
	}
	
	@GetMapping("/momo/passenger/payment-success")
	public String navigateToPassengerSuccessPayment(Model model,@RequestParam("id") long id) {
		String usernameJson;
		try {
			MomoPaymentEntity momoPaymentEntity = walletService.findMomoPaymentById(id);
			usernameJson = new String(Base64.getDecoder().decode(momoPaymentEntity.getExtraData()), "utf-8");
			UsernameMapper usernameMapper = this.usenameMapperFromJson(usernameJson);
			UserEntity user = userService.findUserByUserInfo(usernameMapper.getUsername());
			long actualBalance = user.getPassenger().getWallet().getBalance() - user.getPassenger().getWallet().getFuturePay();
			model.addAttribute("passengerWalletBalance", user.getPassenger().getWallet().getBalance());
			model.addAttribute("passengerWalletFuturePay", user.getPassenger().getWallet().getFuturePay());
			model.addAttribute("passengerWalletActualBalance", actualBalance);
			model.addAttribute("totalTransaction", momoPaymentEntity.getAmount());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "passenger_payment_success";
	}
	
	
	private UsernameMapper usenameMapperFromJson(String json) {
		ObjectMapper objecMapper = new ObjectMapper();
		try {
			UsernameMapper usernameMapper = objecMapper.readValue(json, UsernameMapper.class);
			return usernameMapper;
		} catch (JsonProcessingException e) {
			throw new ParseJsonException("Invalid orderInfo");
		}
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
