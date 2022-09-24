package com.swm.dto.goong.distance.matrix;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class DistanceMatrixElementGoongDto {
	private String status;
	private DistanceMatrixDurationGoongDto duration;
	private DistanceMatrixDistanceGoongDto distance;
}
