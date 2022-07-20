package com.swm.util;

import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Formatter;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import com.swm.exception.ResourceNotAllowException;

public class SignatureHashingUtil {
	private final static String HMAC_SHA_256_ALOGRITHM = "HmacSHA256";
	
	@SuppressWarnings("resource")
	private static String hexToString(byte[] charArr) {
		StringBuilder stringBuilder = new StringBuilder(charArr.length * 2);
		Formatter formatter = new Formatter(stringBuilder);
		for (byte b : charArr) {
			formatter.format("%02x", b);
		}
		return stringBuilder.toString();
	}
	
	public static String sha256HashSigningKey(String secretKey, String rawHash) {
		SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey.getBytes(StandardCharsets.UTF_8), HMAC_SHA_256_ALOGRITHM);
		try {
			Mac mac = Mac.getInstance(HMAC_SHA_256_ALOGRITHM);
			mac.init(secretKeySpec);
			byte[] charArr = mac.doFinal(rawHash.getBytes(StandardCharsets.UTF_8));
			return hexToString(charArr);
		} catch (NoSuchAlgorithmException | InvalidKeyException e) {
			throw new ResourceNotAllowException(e.getMessage());
		}
		
	}
	
}
