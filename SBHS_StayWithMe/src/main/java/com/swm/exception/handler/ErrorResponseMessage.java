package com.swm.exception.handler;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Getter
@Setter
public class ErrorResponseMessage {
	private String status;
	private int statusCode;
	private Date issuedAt;
	private String message;
	private String description;
}
