package com.swm.service;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;

public interface ISendMailService {
	void confirmLandlordAccountRequest(String landlordName, String adminName, String message, String subject,
			boolean isHtml) throws MessagingException, UnsupportedEncodingException;
	
	void sendOtpToUserEmail(String username) throws MessagingException, UnsupportedEncodingException;
}
