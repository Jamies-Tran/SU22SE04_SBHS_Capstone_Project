package com.swm.dto.distance.matrix.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class DistanceMatrixElementDto {
	private DistanceMatrixElementStatusDto status;
	private TextValueObjectDto distance;
	private TextValueObjectDto duration;
}
