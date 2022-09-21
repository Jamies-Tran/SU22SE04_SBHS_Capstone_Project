package com.swm.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class RequestDto {
	private Long Id;
	private String createdBy;
	private String createdByEmail;
	private String createdDate;
	private String type;
	private String status;
	private String VerifyBy;
}
