package com.swm.dto.google.distance.matrix;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class DistanceMatrixElementGoogleDto {
	private DistanceMatrixElementStatusGoogleDto status;
	private TextValueObjectGoogleDto distance;
	private TextValueObjectGoogleDto duration;
}
