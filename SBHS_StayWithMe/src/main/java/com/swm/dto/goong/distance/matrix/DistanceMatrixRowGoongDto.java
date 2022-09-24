package com.swm.dto.goong.distance.matrix;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class DistanceMatrixRowGoongDto {
	List<DistanceMatrixElementGoongDto> elements;
}
