package com.swm.exception;


public class ResourceNotAllowException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public ResourceNotAllowException(String resource, String message) {
		super(String.format("[%s] : %s", resource, message));

	}

	public ResourceNotAllowException(String message) {
		super(message);

	}
	
	

}
