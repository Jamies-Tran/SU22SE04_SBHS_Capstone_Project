package com.swm.serviceImpl;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.swm.entity.SystemStatisticEntity;
import com.swm.exception.ResourceNotFoundException;
import com.swm.repository.ISystemStatisticRepository;
import com.swm.service.ISystemStatisticService;
import com.swm.util.DateParsingUtil;

@Service
public class SystemStatisticService implements ISystemStatisticService {

	@Autowired
	ISystemStatisticRepository systemStatisticRepo;
	
	private Date currentDate = new Date();
	
	@Transactional
	@Override
	public void createSystemStatistic() {
		List<SystemStatisticEntity> systemStatisticList = this.systemStatisticRepo.findAll();
		if(systemStatisticList == null || systemStatisticList.isEmpty()) {
			SystemStatisticEntity systemStatisticEntity = new SystemStatisticEntity();
			systemStatisticEntity.setStatisticTime(DateParsingUtil.statisticYearMonthTime(currentDate));
			this.systemStatisticRepo.save(systemStatisticEntity);
		} else {
			systemStatisticList.forEach(s -> {
				if(!s.getStatisticTime().equals(DateParsingUtil.statisticYearMonthTime(currentDate))) {
					SystemStatisticEntity systemStatisticEntity = new SystemStatisticEntity();
					systemStatisticEntity.setStatisticTime(DateParsingUtil.statisticYearMonthTime(currentDate));
					this.systemStatisticRepo.save(systemStatisticEntity);
				}
			});
		}
		
	}

	@Override
	public SystemStatisticEntity findSystemStatisticByTime(Date date) {
		SystemStatisticEntity systemStatistic = this.systemStatisticRepo.findSystemstatisticByDate(date)
				.orElseThrow(() -> new ResourceNotFoundException("Statistic not found"));
		
		return systemStatistic;
	}

	@Override
	public SystemStatisticEntity findSystemStatisticById(Long Id) {
		SystemStatisticEntity systemStatistic = this.systemStatisticRepo.findById(Id)
				.orElseThrow(() -> new ResourceNotFoundException("Statistic not found"));
		
		return systemStatistic;
	}

}
