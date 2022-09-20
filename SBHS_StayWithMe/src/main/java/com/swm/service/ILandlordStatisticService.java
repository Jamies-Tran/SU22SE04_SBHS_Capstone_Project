package com.swm.service;

import java.util.Date;

import com.swm.entity.LandlordStatisticEntity;

public interface ILandlordStatisticService {
	public void createLandlordStatistic();
	
	public LandlordStatisticEntity findLandlordStatisticByTime(Date date);
	
	public LandlordStatisticEntity findLandlordStatisticById(Long Id);
} 
