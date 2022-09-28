package com.swm.dto.homestay;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class HomestayResponseDto implements Comparable<HomestayResponseDto>{
	private Long Id;
	private String name;
	private String description;
	private String owner;
	private String address;
	private String city;
	private String userDistanceFromHomestay;
	private int numberOfRoom;
	private String checkInTime;
	private String checkOutTime;
	private String payment;
	private String status;
	private Double convenientPoint;
	private Double securityPoint;
	private Double positionPoint;
	private Double averageRatingPoint;
	private Long averagePrice;
	private Long totalBookingTime;
	private Long totalRatingTime;
	private HomestayLicenseDto homestayLicense;
	private List<HomestayImageDto> homestayImages;
	private List<HomestayAftercareDto> homestayServices;
	private List<HomestayCommonFacilityDto> homestayCommonFacilities;
	private List<HomestayPriceListResponseDto> homestayPriceList;
	private List<HomestayAdditionalFacilityDto> homestayAdditionalFacilities;


	@Override
	public int compareTo(HomestayResponseDto o) {
		if(this.averageRatingPoint == o.averageRatingPoint) {
			return 0;
		} else if(this.averageRatingPoint < o.averageRatingPoint) {
			return -1;
		} else {
			return 1;
		}
		
	}
}
