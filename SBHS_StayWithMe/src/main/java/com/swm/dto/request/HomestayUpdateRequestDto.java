package com.swm.dto.request;

import java.util.List;

import com.swm.dto.homestay.HomestayAdditionalFacilityDto;
import com.swm.dto.homestay.HomestayAftercareDto;
import com.swm.dto.homestay.HomestayCommonFacilityDto;
import com.swm.dto.homestay.HomestayImageDto;
import com.swm.dto.homestay.HomestayPriceListRequestDto;
import com.swm.dto.homestay.HomestayPriceListResponseDto;

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
