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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.swm.converter.HomestayConverter;
import com.swm.dto.goong.geocoding.GeocodingGoongResponseDto;
import com.swm.dto.homestay.HomestayAftercareDto;
import com.swm.dto.homestay.HomestayFilterDto;
import com.swm.dto.homestay.HomestayPagesResponseDto;
import com.swm.dto.homestay.HomestayRequestDto;
import com.swm.dto.homestay.HomestayResponseDto;
import com.swm.dto.homestay.SpecialDayPriceListDto;
import com.swm.entity.HomestayAftercareEntity;
import com.swm.entity.HomestayEntity;
import com.swm.entity.SpecialDayPriceListEntity;
import com.swm.enums.HomestayStatus;
import com.swm.exception.ResourceNotAllowException;
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

	@AllArgsConstructor
	@NoArgsConstructor
	@Getter
	@Setter
	public static class SpecialDayListDto {
		List<SpecialDayPriceListDto> specialDayList;
	}
	
	@AllArgsConstructor
	@NoArgsConstructor
	@Getter
	@Setter
	public static class HomestayListDto {
		List<HomestayRequestDto> homestayRequestList;
	}

	@Autowired
	private IHomestayService homestayService;

	@Autowired
	private IHomestayAftercareService homestayAftercareService;

	@Autowired
	private HomestayConverter homestayConvert;

	@PostMapping("/register")
	@PreAuthorize("hasRole('ROLE_LANDLORD')")
	public ResponseEntity<?> requestPostingHomestay(@RequestBody HomestayRequestDto homestayDto) {
		HomestayEntity homestayEntity = homestayConvert.homestayEntityConvert(homestayDto);
		HomestayEntity homestayRequested = homestayService.createHomestay(homestayEntity);
		HomestayResponseDto homestayResponse = homestayConvert.homestayResponseDtoConvert(homestayRequested);

		return new ResponseEntity<>(homestayResponse, HttpStatus.CREATED);
	}

	@PostMapping("/service/{homestayName}")
	@PreAuthorize("hasRole('ROLE_LANDLORD')")
	public ResponseEntity<?> addHomestayAftercare(@PathVariable("homestayName") String homestayName,
			@RequestBody HomestayAftercareDto homestayServiceDto) {
		HomestayEntity homestayEntity = homestayAftercareService.addNewHomestayService(homestayName,
				homestayServiceDto.getName(), homestayServiceDto.getPrice());
		HomestayResponseDto homestayResponseDto = homestayConvert.homestayResponseDtoConvert(homestayEntity);

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
		HomestayResponseDto homestayResponseDto = homestayConvert.homestayResponseDtoConvert(homestayEntity);

		return new ResponseEntity<>(homestayResponseDto, HttpStatus.OK);
	}
	

	@GetMapping("/permit-all/details/{name}")
	public ResponseEntity<?> findHomestayByName(@PathVariable("name") String name) {
		HomestayEntity homestay = homestayService.findHomestayByName(name);
		HomestayResponseDto homestayResponseDto = homestayConvert.homestayResponseDtoConvert(homestay);
		
		if(homestayResponseDto.getStatus().equalsIgnoreCase(HomestayStatus.HOMESTAY_BOOKING_AVAILABLE.name())) {
			return new ResponseEntity<>(homestayResponseDto, HttpStatus.OK);
		} else {
			throw new ResourceNotAllowException("Homestay not available right now");
		}
		
	}

	@GetMapping("/permit-all/list/{location}")
	public ResponseEntity<?> findHomestayListContainLocation(@PathVariable("location") String location) {
		List<HomestayEntity> homestayEntityList = homestayService.findHomestayBookingAvailableListByCity(location);
		List<HomestayResponseDto> homestayResponseListDto = homestayEntityList.stream()
				.map(h -> homestayConvert.homestayResponseDtoConvert(h)).sorted(Collections.reverseOrder())
				.collect(Collectors.toList());

		return new ResponseEntity<>(homestayResponseListDto, HttpStatus.OK);
	}

	@GetMapping("/owner-list")
	@PreAuthorize("hasRole('ROLE_LANDLORD')")
	public ResponseEntity<?> getOwnerHomestayList() {
		List<HomestayEntity> homestayEntityList = homestayService.findHomestayListByOwnerName();
		List<HomestayResponseDto> homestayResponseListDto = homestayEntityList.stream()
				.map(h -> homestayConvert.homestayResponseDtoConvert(h)).sorted(Collections.reverseOrder())
				.collect(Collectors.toList());

		return new ResponseEntity<>(homestayResponseListDto, HttpStatus.OK);
	}

	@GetMapping("/permit-all/available-list")
	public ResponseEntity<?> getAvailableHomestayList() {
		List<HomestayEntity> homestayEntityList = homestayService.getHomestayBookingAvailableList();
		List<HomestayResponseDto> homestayResponseListDto = homestayEntityList.stream()
				.map(h -> homestayConvert.homestayResponseDtoConvert(h)).sorted(Collections.reverseOrder())
				.collect(Collectors.toList());

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
		HomestayResponseDto homestayResponseDto = homestayConvert.homestayResponseDtoConvert(homestayEntity);

		return new ResponseEntity<>(homestayResponseDto, HttpStatus.OK);

	}

	@DeleteMapping("/removal/{Id}")
	@PreAuthorize("hasAuthority('homestay:delete')")
	public ResponseEntity<?> deleteHomestayById(@PathVariable("Id") Long Id, @RequestParam Boolean cancelConfirm) {
		HomestayEntity homestayEntity = homestayService.setDeleteStatusForHomestayById(Id, cancelConfirm);
		HomestayResponseDto homestayResponseDto = homestayConvert.homestayResponseDtoConvert(homestayEntity);

		return new ResponseEntity<>(homestayResponseDto, HttpStatus.GONE);
	}

	@DeleteMapping("/removal/list/{homestayId}")
	@PreAuthorize("hasAuthority('homestay:delete')")
	public ResponseEntity<?> deleteHomestayServiceByIdList(@PathVariable("homestayId") Long homestayId,
			@RequestBody HomestayAftercareListDto homestayServiceListDto) {
		List<Long> homestayServiceIdList = homestayServiceListDto.getHomestayServiceList().stream().map(s -> s.getId())
				.collect(Collectors.toList());
		HomestayEntity homestayEntity = homestayAftercareService.deleteAllHomestayServiceById(homestayId,
				homestayServiceIdList);
		HomestayResponseDto homestayResponseDto = homestayConvert.homestayResponseDtoConvert(homestayEntity);

		return new ResponseEntity<>(homestayResponseDto, HttpStatus.GONE);

	}

	@PostMapping("/add/list/special-day")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public ResponseEntity<?> addSpecialDayList(@RequestBody SpecialDayListDto specialDayListDtoList) {
		List<SpecialDayPriceListEntity> specialDayPriceListEntityList = specialDayListDtoList.getSpecialDayList()
				.stream().map(sd -> homestayConvert.specialDayPriceListEntityConverter(sd))
				.collect(Collectors.toList());
		List<SpecialDayPriceListEntity> specialDayPriceListEntityPersistence = homestayService
				.addSpecialDayPriceList(specialDayPriceListEntityList);
		List<SpecialDayPriceListDto> specialDayListDtoResponse = specialDayPriceListEntityPersistence.stream()
				.map(sd -> homestayConvert.specialDayPriceListDtoConvert(sd)).collect(Collectors.toList());

		return new ResponseEntity<>(specialDayListDtoResponse, HttpStatus.OK);
	}
	

	@GetMapping("/get/all/special-day")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_LANDLORD')")
	public ResponseEntity<?> getAllSpcialDay() {
		List<SpecialDayPriceListEntity> specailDayListEntity = homestayService.getSpecialDayPriceList();
		List<SpecialDayPriceListDto> specialDayListDto = specailDayListEntity.stream()
				.map(s -> homestayConvert.specialDayPriceListDtoConvert(s)).collect(Collectors.toList());
		
		return new ResponseEntity<>(specialDayListDto, HttpStatus.OK);
	}
	
	@GetMapping("/get/special-day/{specialDayCode}")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_LANDLORD')")
	public ResponseEntity<?> getSpcialDayByCode(@PathVariable("specialDayCode") String specialDayCode) {
		SpecialDayPriceListEntity specialDayPriceListEntity = homestayService.findSpecialDayByCode(specialDayCode);
		SpecialDayPriceListDto specialDayPriceListDto = homestayConvert.specialDayPriceListDtoConvert(specialDayPriceListEntity);
		
		return new ResponseEntity<>(specialDayPriceListDto, HttpStatus.OK);
	}
	
	@PostMapping("/permit-all/list")
	public ResponseEntity<?> getHomestayPagination(
				@RequestParam(name = "page") int page, 
				@RequestParam(name = "size") int size,
				@RequestBody HomestayFilterDto filter
			) {
		HomestayPagesResponseDto homestayList = homestayService.getHomestayPage(filter, page, size);
		
		return new ResponseEntity<>(homestayList, HttpStatus.OK);
	}
	
	@GetMapping("/permit-all/distance")
	public ResponseEntity<?> getDistanceMatrix(@RequestParam String origin_address) {
//		DistanceMatrixResponseGoogleDto distanceMatrixResponse = this.homestayService.getDistanceMatrixFromPlaces(origin_address);
		HomestayEntity distanceMatrixResponse = this.homestayService.findHomestayByAddress(origin_address);
		HomestayResponseDto homestayResponseDto = homestayConvert.homestayResponseDtoConvert(distanceMatrixResponse);
		
		return new ResponseEntity<>(homestayResponseDto, HttpStatus.OK);
	}
	
//	@GetMapping("/permit-all/google-distance")
//	public ResponseEntity<?> getDistanceMatrixGoogle(@RequestParam String origin_address) {
//		DistanceMatrixResponseGoogleDto distanceMatrixResponse = this.homestayService.getDistanceMatrixFromPlaces(origin_address);
//		
//		return new ResponseEntity<>(distanceMatrixResponse, HttpStatus.OK);
//	}
	
	@GetMapping("/permit-all/geometry")
	public ResponseEntity<?> getLocationGeoMetry(@RequestParam String address) {
//		DistanceMatrixResponseGoogleDto distanceMatrixResponse = this.homestayService.getDistanceMatrixFromPlaces(origin_address);
		GeocodingGoongResponseDto geoCodingResponse = this.homestayService.getLocationGeometry(address);
		
		return new ResponseEntity<>(geoCodingResponse, HttpStatus.OK);
	}
}
