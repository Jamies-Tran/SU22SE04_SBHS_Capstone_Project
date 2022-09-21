package com.swm.dto.distance.matrix.response;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class DistanceMatrixResponseDto {
	private List<String> destination_addresses;
	private String error_message;
	private List<String> origin_addresses;
	private List<DistanceMatrixRowDto> rows;
	private DistanceMatrixElementStatusDto status;
}
