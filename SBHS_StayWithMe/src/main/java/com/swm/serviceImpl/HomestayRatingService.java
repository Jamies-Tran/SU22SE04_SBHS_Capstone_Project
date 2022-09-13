package com.swm.serviceImpl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.swm.entity.HomestayEntity;
import com.swm.entity.RatingEntity;
import com.swm.entity.UserEntity;
import com.swm.repository.IHomestayRatingRepository;
import com.swm.service.IAuthenticationService;
import com.swm.service.IHomestayRatingService;
import com.swm.service.IHomestayService;
import com.swm.service.IUserService;

@Service
public class HomestayRatingService implements IHomestayRatingService {

	@Autowired
	private IHomestayService homestayService;

	@Autowired
	private IAuthenticationService authenticationService;

	@Autowired
	private IUserService userService;

	@Autowired
	private IHomestayRatingRepository homestayRatingRepo;
	
	private Date currentDate = new Date();

	@Override
	@Transactional
	public RatingEntity rateHomestayAfterFinishBooking(String homestayName, double newConvenientPoint,
			double newSecurityPoint, double newPositionPoint) {
		
		UserEntity userRating = userService
				.findUserByUserInfo(authenticationService.getAuthenticatedUser().getUsername());
		HomestayEntity homestayEntity = homestayService.findHomestayByName(homestayName);
		// save rating
		RatingEntity ratingEntity = new RatingEntity();
		long increasedTotalRatingTime = homestayEntity.getTotalRatingTime() + 1;
		ratingEntity.setConvenientPoint(newConvenientPoint);
		ratingEntity.setSecurityPoint(newSecurityPoint);
		ratingEntity.setPositionPoint(newPositionPoint);
		ratingEntity.setCreatedBy(userRating.getUsername());
		ratingEntity.setCreatedDate(currentDate);
		ratingEntity.setUserRating(userRating.getPassenger());
		ratingEntity.setHomestayPoint(homestayEntity);
		userRating.getPassenger().setRating(ratingEntity);
		homestayEntity.setRating(ratingEntity);
		homestayEntity.setTotalRatingTime(increasedTotalRatingTime);
		homestayRatingRepo.save(ratingEntity);
		// first get current number of rating and the new one by increase the old by 1
		int currentNumberOfRating = homestayEntity.getNumberOfRating();
		int newNumberOfRating = currentNumberOfRating + 1;
		// second get all rating points
		double currentCovenientPoint = homestayEntity.getConvenientPoint();
		double currentSecurityPoint = homestayEntity.getSecurityPoint();
		double currentPositionPoint = homestayEntity.getPositionPoint();
		
		// third calculate average point for each rating
		double convenientPoint = calculateAverageRatingPoint(currentCovenientPoint, currentNumberOfRating,
				newConvenientPoint, newNumberOfRating);
		double securityPoint = calculateAverageRatingPoint(currentSecurityPoint, currentNumberOfRating,
				newSecurityPoint, newNumberOfRating);
		double positionPoint = calculateAverageRatingPoint(currentPositionPoint, currentNumberOfRating,
				newPositionPoint, newNumberOfRating);
		double average = (convenientPoint + securityPoint + positionPoint) / 3;
		// final update new point for homestay
		homestayEntity.setNumberOfRating(newNumberOfRating);
		homestayEntity.setConvenientPoint(convenientPoint);
		homestayEntity.setSecurityPoint(securityPoint);
		homestayEntity.setPositionPoint(positionPoint);
		homestayEntity.setAverage(average);
		homestayEntity.setModifiedBy(userRating.getUsername());
		homestayEntity.setModifiedDate(currentDate);
		

		return ratingEntity;
	}

	private double calculateAverageRatingPoint(double currentPoint, int currentNumberOfRating, double newPoint,
			int newNumberOfRating) {

		double averageRatingPoint = (currentPoint * currentNumberOfRating + newPoint) / newNumberOfRating;

		return averageRatingPoint;

	}

}
