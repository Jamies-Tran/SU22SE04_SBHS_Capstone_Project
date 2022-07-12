package com.swm.exception;

public class JwtTokenException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public JwtTokenException(String token, String msg) {
		super(String.format("[%s] : %s", token, msg));
		
	}

	public JwtTokenException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}
	
	

}
