package com.swm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.swm.converter.RatingConverter;
import com.swm.dto.user.UserRatingDto;
import com.swm.entity.RatingEntity;
import com.swm.service.IHomestayRatingService;

@RestController
@RequestMapping("/api/rating")
public class HomestayRatingController {

	@Autowired
	private IHomestayRatingService homestayRatingService;

	@Autowired
	private RatingConverter ratingConvert;

	@PatchMapping
	@PreAuthorize("hasRole('ROLE_PASSENGER')")
	public ResponseEntity<?> ratingHomestay(@RequestBody UserRatingDto ratingDto) {
		RatingEntity ratingEntity = homestayRatingService.rateHomestayAfterFinishBooking(ratingDto.getHomestayName(),
				ratingDto.getConvenientPoint(), ratingDto.getSecurityPoint(), ratingDto.getPositionPoint());
		UserRatingDto ratingResponseDto = ratingConvert.ratingToDto(ratingEntity);
		return new ResponseEntity<>(ratingResponseDto, HttpStatus.OK);
	}
}
