package com.swm.exception;

public class DuplicateResourceException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public DuplicateResourceException(String resource, String msg) {
		super(String.format("[%s] : %s", resource, msg));
		
	}

	
	
}
