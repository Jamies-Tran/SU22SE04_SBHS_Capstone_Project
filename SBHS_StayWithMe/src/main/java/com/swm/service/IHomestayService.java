package com.swm.service;

import java.util.List;

import com.swm.entity.HomestayAftercareEntity;
import com.swm.entity.HomestayEntity;
import com.swm.entity.HomestayFacilityEntity;
import com.swm.entity.HomestayImageEntity;
import com.swm.entity.HomestayLicenseImageEntity;

public interface IHomestayService {

	HomestayEntity findHomestayByName(String name);
	
	HomestayEntity findHomestayById(Long Id);

	List<HomestayEntity> getHomestayBookingAvailableList();
	
	List<HomestayEntity> findHomestayBookingAvailableListByCity(String city);
	
	List<HomestayEntity> findHomestayListByOwnerName(String landlordName);

	HomestayEntity createHomestay(HomestayEntity homestay, HomestayLicenseImageEntity homestayLicense,
											List<HomestayImageEntity> homestayImages, 
											List<HomestayAftercareEntity> homestayServices,
											List<HomestayFacilityEntity> homestayFacilities);

	HomestayEntity deleteHomestayById(Long Id);

}
