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
import com.swm.exception.JavaMailException;
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
	public void sendMail(String username, String message, String subject)  {
		UserEntity userEntity = userService.findUserByUserInfo(username);
		String userEmail = userEntity.getEmail();
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage);
		try {
			helper.setFrom("no-reply@swm.com", "Admin support");
			helper.setTo(userEmail);
			helper.setSubject(subject);
			helper.setText(message, true);
			mailSender.send(mimeMessage);
		} catch (UnsupportedEncodingException | MessagingException e) {
			throw new JavaMailException("Invalid email");
		}
		
		
	}

}
