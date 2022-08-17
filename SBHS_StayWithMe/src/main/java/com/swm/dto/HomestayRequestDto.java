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
public class HomestayRequestDto {
	private Long Id;
	private String name;
	private String description;
	private String owner;
	private String address;
	private String city;
	private int numberOfRoom;
	private String checkInTime;
	private String checkOutTime;
	private String payment;
	private String status;
	private Double convenientPoint;
	private Double securityPoint;
	private Double positionPoint;
	private Double average;
	private int numberOfFinishedBooking;
	private HomestayLicenseDto homestayLicense;
	private List<HomestayImageDto> homestayImages;
	private List<HomestayAftercareDto> homestayServices;
	private List<HomestayCommonFacilityDto> homestayCommonFacilities;
	private List<HomestayPriceListRequestDto> homestayPriceList;
	private List<HomestayAdditionalFacilityDto> homestayAdditionalFacilities;
}
