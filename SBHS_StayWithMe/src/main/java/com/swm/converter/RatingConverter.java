package com.swm.converter;

import org.springframework.stereotype.Component;

import com.swm.dto.user.UserRatingDto;
import com.swm.entity.RatingEntity;

@Component
public class RatingConverter {
	public UserRatingDto ratingToDto(RatingEntity ratingEntity) {
		UserRatingDto ratingDto = new UserRatingDto();
		ratingDto.setId(ratingEntity.getId());
		ratingDto.setConvenientPoint(ratingEntity.getConvenientPoint());
		ratingDto.setSecurityPoint(ratingEntity.getSecurityPoint());
		ratingDto.setPositionPoint(ratingEntity.getPositionPoint());
		ratingDto.setHomestayName(ratingEntity.getHomestayPoint().getName());
		
		return ratingDto;
	}
	
	public RatingEntity ratingToEntity(UserRatingDto ratingDto) {
		RatingEntity ratingEntity = new RatingEntity();
		ratingEntity.setConvenientPoint(ratingDto.getConvenientPoint());
		ratingEntity.setSecurityPoint(ratingDto.getSecurityPoint());
		ratingEntity.setPositionPoint(ratingDto.getPositionPoint());
		
		return ratingEntity;
	}
}
