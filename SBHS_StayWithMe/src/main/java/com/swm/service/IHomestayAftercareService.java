package com.swm.service;

import java.util.List;

import com.swm.entity.HomestayAftercareEntity;
import com.swm.entity.HomestayEntity;

public interface IHomestayAftercareService {
	HomestayEntity addNewHomestayService(String homestayName, String serviceName, long price);
	
	HomestayEntity addNewHomestayServiceList(String homestayName, List<HomestayAftercareEntity> newHomestayServiceList);
	
	HomestayAftercareEntity findHomestayServiceByName(String name, String homestayName);
	
	HomestayAftercareEntity findHomestayServiceById(Long Id);
	
	HomestayEntity updateHomestayServiceById(String homestayName, Long serviceId, HomestayAftercareEntity newHomestayService);
	
	HomestayEntity deleteAllHomestayServiceById(Long homestayId, List<Long> currentHomestayServiceIdList);
	
	HomestayAftercareEntity deleteHomestayServiceById(Long Id);
}
