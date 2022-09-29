package com.swm.serviceImpl;

import java.util.ArrayList;
import java.util.Calendar;
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
	
	private Calendar currentDate = Calendar.getInstance();
	
	//private Calendar currentDate1 = Calendar.getInstance();

	private List<String> monthList = new ArrayList<String>(List.of("01","02","03","04","05","06","07","08","09","10","11","12"));
	
	
	@Transactional
	@Override
	public void createSystemStatistic() {
		String yearMonthBuilder = "";
		List<SystemStatisticEntity> systemStatisticList = this.systemStatisticRepo.findAll();
		
		
		if(systemStatisticList == null || systemStatisticList.isEmpty()) {
			List<String> statisTimeList = new ArrayList<String>();
			for(int i = 0; i < 12; i++) {
//				yearMonthBuilder.append(currentDate.get(Calendar.YEAR)).append("-").append(monthList.get(i)).append("-").append("01");
				yearMonthBuilder = String.format("%s-%s-%s", String.valueOf(currentDate.get(Calendar.YEAR)), monthList.get(i), "01");
				System.out.println(yearMonthBuilder.toString());
				statisTimeList.add(yearMonthBuilder.toString());
			}
			statisTimeList.forEach(s -> {
				SystemStatisticEntity systemStatisticEntity = new SystemStatisticEntity();
				systemStatisticEntity.setStatisticTime(DateParsingUtil.parseDateTimeStr(s));
				this.systemStatisticRepo.save(systemStatisticEntity);
			});
			
		} else {
			currentDate.set(Calendar.DAY_OF_MONTH, 1);
			List<String> statisTimeList = new ArrayList<String>();
			if(!systemStatisticList.stream().anyMatch(s -> s.getStatisticTime().equals(DateParsingUtil.formatDateTime(currentDate.getTime())))) {
				currentDate.add(Calendar.YEAR, 1);
				for(int i = 0; i < 12; i++) {
					
//					yearMonthBuilder.append(currentDate.get(Calendar.YEAR)).append("-").append(monthList.get(i)).append("-").append("01");
					String yearMonth = String.format("%s-%s-%s", String.valueOf(currentDate.get(Calendar.YEAR)), monthList.get(i), "01");
					statisTimeList.add(yearMonth.toString());
				}
			}
			
			if(!statisTimeList.isEmpty()) {
				statisTimeList.forEach(a -> {
					System.out.println(a);
					SystemStatisticEntity systemStatisticEntity = new SystemStatisticEntity();
					systemStatisticEntity.setStatisticTime(DateParsingUtil.parseDateTimeStr(a));
					this.systemStatisticRepo.save(systemStatisticEntity);
					System.out.println("Saved");
				});
			}
			
		}
		
		
	}
	
//	@Transactional
//	@Override
//	public void createSystemStatistic() {
//		List<SystemStatisticEntity> systemStatisticList = this.systemStatisticRepo.findAll();
//		if(systemStatisticList == null || systemStatisticList.isEmpty()) {
//			SystemStatisticEntity systemStatisticEntity = new SystemStatisticEntity();
//			systemStatisticEntity.setStatisticTime(DateParsingUtil.statisticYearMonthTime(currentDate));
//			this.systemStatisticRepo.save(systemStatisticEntity);
//		} else {
//			systemStatisticList.forEach(s -> {
//				if(!s.getStatisticTime().equals(DateParsingUtil.statisticYearMonthTime(currentDate))) {
//					SystemStatisticEntity systemStatisticEntity = new SystemStatisticEntity();
//					systemStatisticEntity.setStatisticTime(DateParsingUtil.statisticYearMonthTime(currentDate));
//					this.systemStatisticRepo.save(systemStatisticEntity);
//				}
//			});
//		}
//		
//	}

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

	@Override
	public List<SystemStatisticEntity> getSystemstatisticList() {
		List<SystemStatisticEntity> systemstatisticList = this.systemStatisticRepo.findAll();
		
		return systemstatisticList;
	}

}
