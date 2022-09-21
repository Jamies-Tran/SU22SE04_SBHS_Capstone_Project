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
public class DistanceMatrixRowDto {
	List<DistanceMatrixElementDto> elements;
	
}
