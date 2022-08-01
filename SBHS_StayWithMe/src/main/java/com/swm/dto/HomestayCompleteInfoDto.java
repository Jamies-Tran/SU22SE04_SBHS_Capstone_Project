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
public class HomestayCompleteInfoDto implements Comparable<HomestayCompleteInfoDto>{
	private Long Id;
	private String name;
	private String address;
	private String city;
	private Long price;
	private String payment;
	private String status;
	private Double convenientPoint;
	private Double securityPoint;
	private Double positionPoint;
	private Double average;
	private int numberOfFinishedBooking;
	private List<HomestayImageDto> homestayImages;
	private List<HomestayAftercareDto> homestayServices;
	private List<HomestayFacilityDto> homestayFacilities;


	@Override
	public int compareTo(HomestayCompleteInfoDto o) {
		if(this.average == o.average) {
			return 0;
		} else if(this.average < o.average) {
			return -1;
		} else {
			return 1;
		}
		
	}
}
