package com.swm.service;

import java.util.List;

import com.swm.dto.distance.matrix.response.DistanceMatrixResponseDto;
import com.swm.dto.homestay.HomestayFilterDto;
import com.swm.dto.homestay.HomestayPagesResponseDto;
import com.swm.entity.HomestayEntity;
import com.swm.entity.SpecialDayPriceListEntity;

public interface IHomestayService {

	HomestayEntity findHomestayByName(String name);
	
	HomestayEntity findHomestayById(Long Id);
	
	List<HomestayEntity> getHomestayBookingAvailableList();
	
	List<HomestayEntity> findHomestayBookingAvailableListByCity(String city);
	
	List<HomestayEntity> findHomestayListByOwnerName();
	
	HomestayPagesResponseDto getHomestayPage(HomestayFilterDto filter, int page, int size);

	HomestayEntity createHomestay(HomestayEntity homestayEntity);
	
	List<SpecialDayPriceListEntity> addSpecialDayPriceList(List<SpecialDayPriceListEntity> specialDayPriceList);
	
	List<SpecialDayPriceListEntity> getSpecialDayPriceList();

	SpecialDayPriceListEntity findSpecialDayByCode(String code);
	
	SpecialDayPriceListEntity deleteSpecialDayPriceList(String code);
	
	HomestayEntity setDeleteStatusForHomestayById(Long Id, boolean confirmCancelAndDelete);
	
	DistanceMatrixResponseDto getDistanceMatrixFromPlaces(String origin_address);

}
