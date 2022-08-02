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
public class HomestayShortageInfoDto {
	private Long Id;
	private String name;
	private String description;
	private String address;
	private int numberOfRoom;
	private String city;
	private Long price;
	private String checkInTime;
	private String checkOutTime;
	private String payment;
	private String status;
	private HomestayLicenseDto homestayLicense;
	private List<HomestayImageDto> homestayImages;
	private List<HomestayAftercareDto> homestayServices;
	private List<HomestayFacilityDto> homestayFacilities;
}
