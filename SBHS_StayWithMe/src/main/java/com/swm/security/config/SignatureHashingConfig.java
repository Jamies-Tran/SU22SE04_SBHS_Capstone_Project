package com.swm.security.config;

import java.nio.charset.StandardCharsets;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.google.common.hash.Hashing;

@Configuration
public class SignatureHashingConfig {
	@Value("${momo.secret.key}")
	private String secretKey;
	
	@Bean
	public String sha256SigningKey(String msg) {
		String signature = Hashing.hmacSha256(secretKey.getBytes()).hashString(msg, StandardCharsets.UTF_8).toString();
		
		return signature;
	}
	
	@Bean
	public String generateRandomKey() {
		return UUID.randomUUID().toString();
	}
}
