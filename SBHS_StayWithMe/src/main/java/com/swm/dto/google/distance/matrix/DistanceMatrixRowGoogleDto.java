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
public class DistanceMatrixRowGoogleDto {
	List<DistanceMatrixElementGoogleDto> elements;
	
}
