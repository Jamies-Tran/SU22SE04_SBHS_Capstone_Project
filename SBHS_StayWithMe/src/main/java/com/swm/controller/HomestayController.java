package com.swm.controller;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.swm.converter.HomestayConverter;
import com.swm.dto.HomestayAftercareDto;
import com.swm.dto.HomestayCompleteInfoDto;
import com.swm.dto.HomestayShortageInfoDto;
import com.swm.entity.HomestayAftercareEntity;
import com.swm.entity.HomestayEntity;
import com.swm.entity.HomestayFacilityEntity;
import com.swm.entity.HomestayImageEntity;
import com.swm.entity.HomestayLicenseImageEntity;
import com.swm.service.IHomestayAftercareService;
import com.swm.service.IHomestayService;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@RestController
@RequestMapping("/api/homestay")
public class HomestayController {
	
	@AllArgsConstructor
	@NoArgsConstructor
	@Getter
	@Setter
	public static class HomestayAftercareListDto {
		List<HomestayAftercareDto> homestayServiceList;
	}

	
	@Autowired
	private IHomestayService homestayService;

	@Autowired
	private IHomestayAftercareService homestayAftercareService;

	@Autowired
	private HomestayConverter homestayConvert;

	@PostMapping("/register")
	@PreAuthorize("hasRole('ROLE_LANDLORD')")
	public ResponseEntity<?> requestPostingHomestay(@RequestBody HomestayShortageInfoDto homestayDto) {
		HomestayEntity homestayEntity = homestayConvert.homestayEntityConvert(homestayDto);
		HomestayLicenseImageEntity homestayLicense = homestayConvert
				.homestayLicenseEntityConvert(homestayDto.getHomestayLicense());
		List<HomestayImageEntity> homestayImageList = homestayDto.getHomestayImages().stream()
				.map(img -> homestayConvert.homestayImageEntityConvert(img)).collect(Collectors.toList());
		List<HomestayAftercareEntity> homestayServiceList = homestayDto.getHomestayServices().stream()
				.map(srv -> homestayConvert.homestayAftercareEntityConvert(srv)).collect(Collectors.toList());
		List<HomestayFacilityEntity> homestayFacilityList = homestayDto.getHomestayFacilities().stream()
				.map(fct -> homestayConvert.homestayFacilityEntityConvert(fct)).collect(Collectors.toList());
		HomestayEntity homestayRequested = homestayService.createHomestay(homestayEntity, homestayLicense,
				homestayImageList, homestayServiceList, homestayFacilityList);
		HomestayShortageInfoDto homestayResponse = homestayConvert.homestayDtoConvert(homestayRequested);

		return new ResponseEntity<>(homestayResponse, HttpStatus.CREATED);
	}

	@PostMapping("/service/{homestayName}")
	@PreAuthorize("hasRole('ROLE_LANDLORD')")
	public ResponseEntity<?> addHomestayAftercare(@PathVariable("homestayName") String homestayName,
			@RequestBody HomestayAftercareDto homestayServiceDto) {
		HomestayEntity homestayEntity = homestayAftercareService.addNewHomestayService(homestayName,
				homestayServiceDto.getName(), homestayServiceDto.getPrice());
		HomestayShortageInfoDto homestayResponseDto = homestayConvert.homestayDtoConvert(homestayEntity);

		return new ResponseEntity<>(homestayResponseDto, HttpStatus.OK);
	}

	@PostMapping("/service/list/{homestayName}")
	@PreAuthorize("hasRole('ROLE_LANDLORD')")
	public ResponseEntity<?> addHomestayAftercareList(@PathVariable("homestayName") String homestayName,
			@RequestBody HomestayAftercareListDto homestaySeviceListDto) {
		List<HomestayAftercareEntity> homestayListEntity = homestaySeviceListDto.getHomestayServiceList().stream()
				.map(s -> homestayConvert.homestayAftercareEntityConvert(s)).collect(Collectors.toList());
		HomestayEntity homestayEntity = homestayAftercareService.addNewHomestayServiceList(homestayName,
				homestayListEntity);
		HomestayShortageInfoDto homestayResponseDto = homestayConvert.homestayDtoConvert(homestayEntity);

		return new ResponseEntity<>(homestayResponseDto, HttpStatus.OK);
	}

	@GetMapping("/permit-all/details/{name}")
	public ResponseEntity<?> findHomestayByName(@PathVariable("name") String name) {
		HomestayEntity homestay = homestayService.findHomestayByName(name);
		HomestayCompleteInfoDto homestayResponseDto = homestayConvert.homestayCompleteInfoDtoConvert(homestay);

		return new ResponseEntity<>(homestayResponseDto, HttpStatus.OK);
	}

	@GetMapping("/permit-all/list/{location}")
	public ResponseEntity<?> findHomestayListContainLocation(@PathVariable("location") String location) {
		List<HomestayEntity> homestayEntityList = homestayService.findHomestayBookingAvailableListByCity(location);
		List<HomestayCompleteInfoDto> homestayResponseListDto = homestayEntityList.stream()
				.map(h -> homestayConvert.homestayCompleteInfoDtoConvert(h)).sorted(Collections.reverseOrder()).collect(Collectors.toList());

		return new ResponseEntity<>(homestayResponseListDto, HttpStatus.OK);
	}
	
	@GetMapping("/permit-all/available-list")
	public ResponseEntity<?> getAvailableHomestayList() {
		List<HomestayEntity> homestayEntityList = homestayService.getHomestayBookingAvailableList();
		List<HomestayCompleteInfoDto> homestayResponseListDto = homestayEntityList.stream()
				.map(h -> homestayConvert.homestayCompleteInfoDtoConvert(h)).sorted(Collections.reverseOrder()).collect(Collectors.toList());

		return new ResponseEntity<>(homestayResponseListDto, HttpStatus.OK);
	}
	

	@PatchMapping("/service/{homestayName}/{serviceId}")
	@PreAuthorize("hasAuthority('homestay:update')")
	public ResponseEntity<?> updateHomestayAftercare(@PathVariable("homestayName") String homestayName,
			@PathVariable("serviceId") Long serviceId, @RequestBody HomestayAftercareDto newHomstayServiceDto) {
		HomestayAftercareEntity newHomestayServiceEntity = homestayConvert
				.homestayAftercareEntityConvert(newHomstayServiceDto);
		HomestayEntity homestayEntity = homestayAftercareService.updateHomestayServiceById(homestayName, serviceId,
				newHomestayServiceEntity);
		HomestayShortageInfoDto homestayResponseDto = homestayConvert.homestayDtoConvert(homestayEntity);

		return new ResponseEntity<>(homestayResponseDto, HttpStatus.OK);

	}

	@DeleteMapping("/removal/{Id}")
	@PreAuthorize("hasAuthority('homestay:delete')")
	public ResponseEntity<?> deleteHomestayById(@PathVariable("Id") Long Id) {
		HomestayEntity homestayEntity = homestayService.deleteHomestayById(Id);
		HomestayShortageInfoDto homestayResponseDto = homestayConvert.homestayDtoConvert(homestayEntity);

		return new ResponseEntity<>(homestayResponseDto, HttpStatus.GONE);
	}

	@DeleteMapping("/removal/list/{homestayId}")
	@PreAuthorize("hasAuthority('homestay:delete')")
	public ResponseEntity<?> deleteHomestayServiceByIdList(@PathVariable("homestayId") Long homestayId,
			@RequestBody HomestayAftercareListDto homestayServiceListDto) {
		List<Long> homestayServiceIdList = homestayServiceListDto.getHomestayServiceList().stream().map(s -> s.getId())
				.collect(Collectors.toList());
		HomestayEntity homestayEntity = homestayAftercareService.deleteAllHomestayServiceById(homestayId, homestayServiceIdList);
		HomestayShortageInfoDto homestayResponseDto = homestayConvert.homestayDtoConvert(homestayEntity);
		
		return new ResponseEntity<>(homestayResponseDto, HttpStatus.GONE);
		
	}
}
