package com.swm.service;

import com.swm.entity.RatingEntity;

public interface IHomestayRatingService {
	RatingEntity rateHomestayAfterFinishBooking(String homestayName, double newConvenientPoint, double newSecurityPoint,
			double newPositionPoint);
}
