package com.swm.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class RequestConfirmationDto {
	private Long Id;
	private Boolean isAccepted;
	private String rejectMessage;
}
