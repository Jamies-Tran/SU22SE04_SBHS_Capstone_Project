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
public class HomestayPostingRequestDto extends RequestDto {
	private String homestayName;
	private int numberOfRoom;
	private String city;
	private String checkInTime;
	private String checkOutTime;
	private String address;
	private String description;
	private String imageLicenseUrl;
	private List<HomestayImageDto> homestayImagesList;
	private List<HomestayCommonFacilityDto> homestayFacilityList;
	private List<HomestayAftercareDto> homestayAftercareList;
	private List<HomestayPriceListRequestDto> homestayPriceList;
}
