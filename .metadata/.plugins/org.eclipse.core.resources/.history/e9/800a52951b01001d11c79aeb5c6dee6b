package com.swm.security.token;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.swm.exception.JwtTokenException;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.security.SignatureException;

@Component
public class JwtTokenUtil {
	@Value("${jwt.config.secret-key}")
	private String secretKey;
	
	@Value("${jwt.config.expired-time}")
	private int expiredTime;
	
	public String generateJwtTokenString(String username) {
		return Jwts.builder().setIssuedAt(new Date()).setExpiration(this.generateExpiredTime()).setSubject(username)
					.signWith(Keys.hmacShaKeyFor(secretKey.getBytes())).compact();
	}
	
	private Claims getClaimsFromJwtToken(String token) {
		return (Claims)Jwts.parserBuilder().setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes())).build().parse(token).getBody();
	}
	
	public String getUsernameFromToken(String token) {
		if(!validateJwtTokenString(token)) {
			return null;
		}
		Claims claim = this.getClaimsFromJwtToken(token);
		
		return claim.getSubject();
	}
	
	private Date generateExpiredTime() {
		return new Date(System.currentTimeMillis() + expiredTime);
	}
	
	public String getJwtTokenStringFromRequestHeader(HttpServletRequest request) {
		String actualToken = request.getHeader("Authorization");
		if(StringUtils.hasLength(actualToken) && actualToken.startsWith("Bearer ")) {
			return actualToken.substring(7, actualToken.length());
		}
		
		return null;
	}
	
	public boolean validateJwtTokenString(String token) {
		try {
			Jwts.parserBuilder().setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes())).build().parse(token);
			return true;
		} catch(ExpiredJwtException exc) {
			throw new JwtTokenException(token, "Token has expired.");
		} catch(MalformedJwtException exc) {
			throw new JwtTokenException(token, "Token was incorrectly constructed (and therefore invalid).");
		} catch(SignatureException exc) {
			throw new JwtTokenException(token, "Token  signature was discovered, but could not be verified.");
		} catch(IllegalArgumentException exc) {
			throw new JwtTokenException(token, "Token  is empty.");
		}
	}
}
