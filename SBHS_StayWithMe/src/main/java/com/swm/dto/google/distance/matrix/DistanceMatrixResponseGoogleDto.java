package com.swm.dto.google.distance.matrix;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class DistanceMatrixResponseGoogleDto {
	private List<String> destination_addresses;
	private String error_message;
	private List<String> origin_addresses;
	private List<DistanceMatrixRowGoogleDto> rows;
	private DistanceMatrixElementStatusGoogleDto status;
}
