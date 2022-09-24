package com.swm.dto.goong.geocoding;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class GeocodingGoongResponseDto {
	List<GeocodingGoongElementDto> results;
}
