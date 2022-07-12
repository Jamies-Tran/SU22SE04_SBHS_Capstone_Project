package com.swm.exception;

public class ResourceNotFoundException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public ResourceNotFoundException(String resource, String message) {
		super(String.format("[%s] : %s", resource, message));

	}

	public ResourceNotFoundException(String message) {
		super(message);
	}
	
	
	
	

}
