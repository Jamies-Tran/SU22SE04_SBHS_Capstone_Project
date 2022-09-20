package com.swm.exception;

public class ParseDateException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public ParseDateException(String date) {
		super(String.format("[%s] : not a valid date.", date));
	}
	

}
