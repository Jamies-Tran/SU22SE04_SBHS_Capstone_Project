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
public class HomestayUpdateRequestDto extends RequestDto {
	private Long Id;
	private Long homestayUpdateRequestId;
	private String newName;
	private String newDescription;
	private String newAddress;
	private String newCity;
	private List<HomestayAdditionalFacilityDto> newHomestayAdditionalFacility;
	private List<HomestayCommonFacilityDto> newHomestayCommonFacility;
	private List<HomestayImageDto> newHomestayImages;
	private List<HomestayAftercareDto> newHomestayService;
	private String newHomestayLicenseImageUrl;
	private List<HomestayPriceListRequestDto> newHomestayRequestPriceList;
	private List<HomestayPriceListResponseDto> newHomestayResponsePriceList;
}
