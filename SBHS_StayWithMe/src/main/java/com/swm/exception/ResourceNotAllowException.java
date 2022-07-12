package com.swm.exception;


public class ResourceNotAllowException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public ResourceNotAllowException(String resource, String message) {
		super(String.format("[%s] : %s", resource, message));
		// TODO Auto-generated constructor stub
	}
	
	

}
