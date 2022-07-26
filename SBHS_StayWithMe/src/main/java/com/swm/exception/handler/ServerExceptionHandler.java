package com.swm.exception.handler;

import java.util.Date;

import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

import com.swm.exception.DuplicateResourceException;
import com.swm.exception.JavaMailException;
import com.swm.exception.JwtTokenException;
import com.swm.exception.InvalidBalanceException;
import com.swm.exception.ParseDateException;
import com.swm.exception.ParseJsonException;
import com.swm.exception.ResourceNotFoundException;
import com.swm.exception.UsernamePasswordNotCorrectException;
import com.swm.exception.ResourceNotAllowException;

@RestControllerAdvice
public class ServerExceptionHandler {

	@ExceptionHandler(JwtTokenException.class)
	@ResponseStatus(value = HttpStatus.LOCKED)
	public ErrorResponseMessage JwtTokenExceptionHandler(JwtTokenException exc, WebRequest request) {
		return new ErrorResponseMessage(HttpStatus.LOCKED.getReasonPhrase(), HttpStatus.LOCKED.value(), new Date(),
				exc.getMessage(), request.getDescription(false));

	}

	@ExceptionHandler(DuplicateResourceException.class)
	@ResponseStatus(value = HttpStatus.CONFLICT)
	public ErrorResponseMessage DuplicateResourceHandler(DuplicateResourceException exc, WebRequest request) {
		return new ErrorResponseMessage(HttpStatus.CONFLICT.getReasonPhrase(), HttpStatus.CONFLICT.value(), new Date(),
				exc.getMessage(), request.getDescription(false));

	}

	@ExceptionHandler(ParseDateException.class)
	@ResponseStatus(value = HttpStatus.BAD_REQUEST)
	public ErrorResponseMessage ParseDateExceptionHandler(ParseDateException exc, WebRequest request) {
		return new ErrorResponseMessage(HttpStatus.BAD_REQUEST.getReasonPhrase(), HttpStatus.BAD_REQUEST.value(),
				new Date(), exc.getMessage(), request.getDescription(false));
	}

	@ExceptionHandler(ResourceNotAllowException.class)
	@ResponseStatus(value = HttpStatus.NOT_ACCEPTABLE)
	public ErrorResponseMessage ResourceNotAllowExceptionHandler(ResourceNotAllowException exc, WebRequest request) {
		return new ErrorResponseMessage(HttpStatus.NOT_ACCEPTABLE.getReasonPhrase(), HttpStatus.NOT_ACCEPTABLE.value(),
				new Date(), exc.getMessage(), request.getDescription(false));
	}

	@ExceptionHandler(ResourceNotFoundException.class)
	@ResponseStatus(value = HttpStatus.NOT_FOUND)
	public ErrorResponseMessage ResourceNotFoundExceptionHandler(ResourceNotFoundException exc, WebRequest request) {
		return new ErrorResponseMessage(HttpStatus.NOT_FOUND.getReasonPhrase(), HttpStatus.NOT_FOUND.value(),
				new Date(), exc.getMessage(), request.getDescription(false));
	}

	@ExceptionHandler(UsernameNotFoundException.class)
	@ResponseStatus(value = HttpStatus.NOT_FOUND)
	public ErrorResponseMessage UsernameNotFoundExceptionHandler(UsernameNotFoundException exc, WebRequest request) {
		return new ErrorResponseMessage(HttpStatus.NOT_FOUND.getReasonPhrase(), HttpStatus.NOT_FOUND.value(),
				new Date(), exc.getMessage(), request.getDescription(false));
	}

	@ExceptionHandler(InvalidBalanceException.class)
	@ResponseStatus(value = HttpStatus.PRECONDITION_FAILED)
	public ErrorResponseMessage NotEnoughBalanceExceptionHandler(InvalidBalanceException exc, WebRequest request) {
		return new ErrorResponseMessage(HttpStatus.PRECONDITION_FAILED.getReasonPhrase(),
				HttpStatus.PRECONDITION_FAILED.value(), new Date(), exc.getMessage(), request.getDescription(false));
	}

	@ExceptionHandler(ParseJsonException.class)
	@ResponseStatus(value = HttpStatus.BAD_REQUEST)
	public ErrorResponseMessage ParseJsonExceptionHandler(ParseJsonException exc, WebRequest request) {
		return new ErrorResponseMessage(HttpStatus.BAD_REQUEST.getReasonPhrase(), HttpStatus.BAD_REQUEST.value(),
				new Date(), exc.getMessage(), request.getDescription(false));
	}

	@ExceptionHandler(UsernamePasswordNotCorrectException.class)
	@ResponseStatus(value = HttpStatus.FORBIDDEN)
	public ErrorResponseMessage UsernamePasswordNotCorrectExceptionHandler(UsernamePasswordNotCorrectException exc,
			WebRequest request) {
		return new ErrorResponseMessage(HttpStatus.FORBIDDEN.getReasonPhrase(), HttpStatus.FORBIDDEN.value(),
				new Date(), exc.getMessage(), request.getDescription(false));
	}
	
	@ExceptionHandler(JavaMailException.class)
	@ResponseStatus(value = HttpStatus.NOT_ACCEPTABLE)
	public ErrorResponseMessage JavaMailExceptionHandler(JavaMailException exc, WebRequest request) {
		return new ErrorResponseMessage(HttpStatus.NOT_ACCEPTABLE.getReasonPhrase(), HttpStatus.NOT_ACCEPTABLE.value(),
				new Date(), exc.getMessage(), request.getDescription(false));
	}

}
