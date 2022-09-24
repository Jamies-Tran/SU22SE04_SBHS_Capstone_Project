package com.swm.dto.distance;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class LocationDistanceDto implements Comparable<LocationDistanceDto>{
	private String address;
	private int distanceValue;
	
	@Override
	public int compareTo(LocationDistanceDto o) {
		if(this.getDistanceValue() == o.getDistanceValue()) {
			return 0;
		} else if(this.getDistanceValue() > o.getDistanceValue()) {
			return 1;
		} else {
			return -1;
		}
		
	}
}
