package com.swm.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class HomestayRequestDto extends RequestDto {
	private String homestayName;
	private int numberOfRoom;
	private Long price;
	private String city;
	private String checkInTime;
	private String checkOutTime;
	private String address;
	private String description;
	private String imageLicenseUrl;
	private List<HomestayImageDto> homestayImagesList;
	private List<HomestayFacilityDto> homestayFacilityList;
	private List<HomestayAftercareDto> homestayAftercareList;
}
