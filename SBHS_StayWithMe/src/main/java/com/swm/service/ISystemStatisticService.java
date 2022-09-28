package com.swm.service;

import java.util.Date;
import java.util.List;

import com.swm.entity.SystemStatisticEntity;

public interface ISystemStatisticService {
	
	public void createSystemStatistic();
	
	public SystemStatisticEntity findSystemStatisticByTime(Date date);
	
	public SystemStatisticEntity findSystemStatisticById(Long Id);
	
	public List<SystemStatisticEntity> getSystemstatisticList();
}
