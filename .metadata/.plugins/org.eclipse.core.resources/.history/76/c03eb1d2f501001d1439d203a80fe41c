package com.swm.serviceImpl;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.swm.entity.UserEntity;
import com.swm.service.ISendMailService;
import com.swm.service.IUserService;

@Service
public class SendMailService implements ISendMailService {
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	@Lazy
	private IUserService userService;
	
	
	@Override
	public void confirmLandlordAccountRequest(String landlordName, String adminName, String message, String subject, boolean isHtml) throws MessagingException, UnsupportedEncodingException {
		UserEntity adminUser = userService.findUserByUsername(adminName);
		UserEntity landlordUser = userService.findUserByUsername(landlordName);
		String adminEmail = adminUser.getEmail();
		String landlordEmail = landlordUser.getEmail();
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage);
		helper.setFrom(adminEmail, "Admin support");
		helper.setTo(landlordEmail);
		helper.setSubject(subject);
		helper.setText(message, isHtml);
		mailSender.send(mimeMessage);
		
	}


	@Override
	public void sendOtpToUserEmail(String username) throws MessagingException, UnsupportedEncodingException {
		UserEntity userEntity = userService.findUserByUsername(username);
		String otp = userEntity.getUserOtp().getCode();
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage);
		helper.setFrom("no-reply@swm.com", "Stay with me system");
		helper.setTo(userEntity.getEmail());
		helper.setSubject("Change password OTP");
		helper.setText("<p>Here is your otp key: </p><br/>"
					 + "<h1>" + otp + "</h1>", true);
		mailSender.send(mimeMessage);
	}

}
