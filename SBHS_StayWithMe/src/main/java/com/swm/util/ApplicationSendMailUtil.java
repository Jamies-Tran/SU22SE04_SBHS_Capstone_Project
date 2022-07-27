package com.swm.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.swm.entity.BookingEntity;
import com.swm.entity.HomestayAftercareEntity;
import com.swm.entity.HomestayEntity;
import com.swm.entity.HomestayPostingRequestEntity;
import com.swm.entity.LandlordAccountRequestEntity;
import com.swm.entity.UserEntity;
import com.swm.exception.ResourceNotFoundException;

public class ApplicationSendMailUtil {
	private static String message;
	
	private static SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	private static Date currentDate = new Date();
	
	public static String generateConfirmCheckInMessage(UserEntity userCheckIn, HomestayEntity homestayEntity, BookingEntity bookingEntity, String authorityCheckIn) {
		
		switch(authorityCheckIn.toLowerCase()) {
		case "landlord":
			message = "<p>Homestay owner has checked-in for your booking at homestay <span style='font-weight:bold'>"+homestayEntity.getName()+"</span> at "+simpleDateFormat.format(currentDate)+"</p>\r\n"
					+ "<p>Your booking information:</p>\r\n"
					+ "	<p><span style='font-weight:bold;margin:10px'>Homestay: </span>"+homestayEntity.getName()+"</p>\r\n"
					+ "	<p><span style='font-weight:bold;margin:10px'>Check-in: </span>"+simpleDateFormat.format(bookingEntity.getCheckIn())+"</p>\r\n"
					+ "	<p><span style='font-weight:bold;margin:10px'>Check-out: </span>"+simpleDateFormat.format(bookingEntity.getCheckOut())+"</p>\r\n"
					+ "	<p><span style='font-weight:bold;margin:10px'>Total price: </span>"+bookingEntity.getTotalPrice()+" VND</p>\r\n"
					+ "	<p><span style='font-weight:bold;margin:10px'>You have paid booking deposit for: </span>"+bookingEntity.getBookingPaidDeposit().getDepositPaidAmount()+" VND</p>\r\n"
					+ "<p>Click on button below to confirm.</p>\r\n"
					+ "<form action=\"http://localhost:8080/checkin/redirect/"+bookingEntity.getId()+"\", method=\"get\">\r\n"
					+ "	<input type=\"submit\" value=\"Confirm\" 		style=\"background-color:#04AA6D;border:none;color:white;padding:16px 32px;text-decoration: none;margin: 4px 2px;cursor: pointer;\"/>\r\n"
					+ "</form>";
			return message;
		case "passenger":
			message = "<p>An passenger <span style='font-weight:bold'>"+userCheckIn.getUsername()+"</span> has checked-in for your booking at homestay <span style='font-weight:bold'>"+homestayEntity.getName()+"</span> at "+simpleDateFormat.format(currentDate)+"</p>\r\n"
					+ "<p>Your booking information:</p>\r\n"
					+ "	<p><span style='font-weight:bold;margin:10px'>Homestay: </span>"+homestayEntity.getName()+"</p>\r\n"
					+ "	<p><span style='font-weight:bold;margin:10px'>Check-in: </span>"+simpleDateFormat.format(bookingEntity.getCheckIn())+"</p>\r\n"
					+ "	<p><span style='font-weight:bold;margin:10px'>Check-out: </span>"+simpleDateFormat.format(bookingEntity.getCheckOut())+"</p>\r\n"
					+ "	<p><span style='font-weight:bold;margin:10px'>Total price: </span>"+bookingEntity.getTotalPrice()+" VND</p>\r\n"
					+ "	<p><span style='font-weight:bold;margin:10px'>You have paid booking deposit for: </span>"+bookingEntity.getBookingPaidDeposit().getDepositPaidAmount()+" VND</p>\r\n"
					+ "<p>Click on button below to confirm that person is your relative.</p>\r\n"
					+ "<form action=\"http://localhost:8080/checkin/redirect/"+bookingEntity.getId()+"\", method=\"get\">\r\n"
					+ "	<input type=\"hidden\" name=\"isConfirmed\" value=\"true\"/>\r\n"
					+ "	<input type=\"submit\" value=\"Confirm\" 		style=\"background-color:#04AA6D;border:none;color:white;padding:16px 32px;text-decoration: none;margin: 4px 2px;cursor: pointer;\"/>\r\n"
					+ "</form>";
			return message;
		default:
			throw new ResourceNotFoundException(authorityCheckIn);
		}
	}
	
	public static String generateAcceptBookingMessage(BookingEntity bookingEntity) {
		List<HomestayAftercareEntity> homestayServiceList = bookingEntity.getHomestayServiceBooking();
		String bookingOtp = bookingEntity.getBookingOtp().getCode();
		HomestayEntity homestayEntity = bookingEntity.getBookingHomestay();
		String message;
		if (homestayServiceList.isEmpty()) {
			message = "<p>We please to send you your booking information:<p>\r\n"
					+ "<p><span style='font-weight:bold'>Homestay:</span>" + homestayEntity.getName() + "</p>\r\n"
					+ "<p><span style='font-weight:bold'>Booking otp:</span>" +bookingOtp + "</p>\r\n"
					+ "<p><span style='font-weight:bold'>Check-in:</span>"
					+ simpleDateFormat.format(bookingEntity.getCheckIn()) + "</p>\r\n"
					+ "<p><span style='font-weight:bold'>Check-out:</span>"
					+ simpleDateFormat.format(bookingEntity.getCheckOut()) + "</p>\r\n"
					+ "<p><span style='font-weight:bold'>Total: </span>" + bookingEntity.getTotalPrice() + " VND</p>\r\n"
					+ "<p><span style='font-weight:bold'>Deposit: </span>"
					+ bookingEntity.getDeposit() + " VND</p>\r\n"
					+ "<p>P.S: You must pay deposit to complete the booking.</p>\r\n"
					+ "<p>We wish your journey safe and sound. Enjoy your time.</p>";
		} else {
			String serviceListString = "";
			for (int i = 0; i < homestayServiceList.size(); i++) {
				serviceListString += String.format("<li>%s : %s</li>\r\n", homestayServiceList.get(i).getServiceName(),
						homestayServiceList.get(i).getPrice().toString());
			}
			message = "<p>We please to send you your booking information:<p>\r\n"
					+ "<p><span style='font-weight:bold'>Homestay:</span>" + homestayEntity.getName() + "</p>\r\n"
					+ "<p><span style='font-weight:bold'>Your chosen services:</span></p>\r\n" + "<ol>\r\n"
					+ serviceListString + "</ol>" + "<p><span style='font-weight:bold'>Check-in:</span>"
					+ bookingEntity.getCheckIn() + "</p>\r\n"
					+ "<p><span style='font-weight:bold'>Check-out:</span>"
					+ bookingEntity.getCheckOut() + "</p>\r\n"
					+ "<p><span style='font-weight:bold'>Total: </span>" + bookingEntity.getTotalPrice() + "VND</p>\r\n"
					+ "<p><span style='font-weight:bold'>Deposit: </span>"
					+ bookingEntity.getDeposit() + "</p>\r\n"
					+ "<p>P.S: You must pay deposit to complete the booking.</p>\r\n"
					+ "<p>We wish your journey safe and sound. Enjoy your time.</p>";
		}

		return message;
	}
	
	public static String generateRejectBookingMessage(BookingEntity bookingEntity, String rejectMessage) {
		HomestayEntity homestayEntity = bookingEntity.getBookingHomestay();
		message = "<p>Your booking at homestay "+homestayEntity.getName()+" has been denied by homestay owner with reason:<p/>\r\n" + "<p>"
				+ rejectMessage + "</p>";
		return message;
	}

	public static String generateAcceptHomestayRequestMessage(HomestayPostingRequestEntity homestayPostingRequestEntity) {
		String homestayName = homestayPostingRequestEntity.getRequestHomestay().getName();
		String homestayLocation = homestayPostingRequestEntity.getRequestHomestay().getLocation();
		message = "<h1>Your homestay posting request has been accepted ^^</h1>" + "<p>Your homestay " + homestayName
				+ " on location " + homestayLocation + "has been posted on our platform.</p>"
				+ "<p>Ready yourself cause passenger can rent your homestay at any time. Good luck!</p>";
		return message;
	}
	
	public static String generateRejectHomstayRequestMessage(HomestayPostingRequestEntity homestayPostingRequestEntity, String rejectMessage) {
		String homestayName = homestayPostingRequestEntity.getRequestHomestay().getName();
		String homestayLocation = homestayPostingRequestEntity.getRequestHomestay().getLocation();
		message = "<h1>Your homestay posting request has been denied :(</h1>" 
				+ "<p>Your homestay "+homestayName+" on location "+homestayLocation+" has been denied for reason: </p><br/>"
				+ "<p>"+rejectMessage+"</p>";
		
		return message;
	}
	
	public static String generateAcceptLandlordRequestMessage(LandlordAccountRequestEntity landlordAccountRequestEntity) {
		String landlordName = landlordAccountRequestEntity.getAccountRequesting().getLandlordAccount().getUsername();
		message = "<h1>Welcome " + landlordName + " ^_^</h1>"
				+ "<p>Your landlord account request has been approved.</p>"
				+ "<p>From now on you can post your home stay on Stay With Me platform.</p>" + "<p>Good luck</p>";
		return message;
	}
	
	public static String generateRejectLandlordRequestMessage(LandlordAccountRequestEntity landlordAccountRequestEntity) {
		String landlordName = landlordAccountRequestEntity.getAccountRequesting().getLandlordAccount().getUsername();
		message = "<h1>Rejected</h1>"
				+ "<p>I'm sorry to inform you that your landlord account "+landlordName+" has been denied. Please contact our admin for more support.</p><br/>";
		
		return message;
	}
	
	
	
	
}
