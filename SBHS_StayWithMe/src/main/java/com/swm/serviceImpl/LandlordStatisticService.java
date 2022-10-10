package com.swm.serviceImpl;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.swm.entity.LandlordEntity;
import com.swm.entity.LandlordStatisticEntity;
import com.swm.exception.ResourceNotFoundException;
import com.swm.repository.ILandlordRepository;
import com.swm.repository.ILandlordStatisticRepository;
import com.swm.service.ILandlordStatisticService;
import com.swm.util.DateParsingUtil;

@Service
public class LandlordStatisticService implements ILandlordStatisticService {

	@Autowired
	private ILandlordStatisticRepository landlordStatisticRepo;
	
	@Autowired
	private ILandlordRepository landlordRepo;
	
	private Date currentTime = new Date();
	
	

	@Override
	public LandlordStatisticEntity findLandlordStatisticByTime(Date date) {
		LandlordStatisticEntity landlordStatistic = this.landlordStatisticRepo.findLandlordStatisticByTime(date)
				.orElseThrow(() -> new ResourceNotFoundException("Statistic not found"));
		
		return landlordStatistic;
	}

	@Override
	public LandlordStatisticEntity findLandlordStatisticById(Long Id) {
		LandlordStatisticEntity landlordStatistic = this.landlordStatisticRepo.findById(Id)
				.orElseThrow(() -> new ResourceNotFoundException("Statistic not found"));
		
		return landlordStatistic;
	}

	@Transactional
	@Override
	public void createLandlordStatistic() {
		List<LandlordEntity> landlordList = this.landlordRepo.findAll();
		if(landlordList != null) {
			landlordList.forEach(l -> {
				if(!l.getStatistic().stream().anyMatch(s -> s.getStatisticTime().equals(DateParsingUtil.statisticYearMonthTime(currentTime)))) {
					LandlordStatisticEntity landlordStatistic = new LandlordStatisticEntity();
					landlordStatistic.setLandlordStatistic(l);
					landlordStatistic.setStatisticTime(DateParsingUtil.statisticYearMonthTime(currentTime));
					l.setStatistic(List.of(landlordStatistic));
					this.landlordStatisticRepo.save(landlordStatistic);
				}
				
			});
		}
		
	}

	@Override
	public List<LandlordStatisticEntity> getLandlordStaitsticList() {
		List<LandlordStatisticEntity> landlordStatisticList = this.landlordStatisticRepo.findAll();
		
		return landlordStatisticList;
	}

}
