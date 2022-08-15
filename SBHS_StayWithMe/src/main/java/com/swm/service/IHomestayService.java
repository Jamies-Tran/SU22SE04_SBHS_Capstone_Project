package com.swm.service;

import java.util.List;

import com.swm.entity.HomestayEntity;
import com.swm.entity.SpecialDayPriceListEntity;

public interface IHomestayService {

	HomestayEntity findHomestayByName(String name);
	
	HomestayEntity findHomestayById(Long Id);

	List<HomestayEntity> getHomestayBookingAvailableList();
	
	List<HomestayEntity> findHomestayBookingAvailableListByCity(String city);
	
	List<HomestayEntity> findHomestayListByOwnerName();

	HomestayEntity createHomestay(HomestayEntity homestayEntity);
	
	void addSpecialDayPriceList(List<SpecialDayPriceListEntity> specialDayPriceList);
	
	HomestayEntity deleteHomestayById(Long Id);
	
	Integer numberOfFinishedBookingHomestay(Long homestayId);

}
