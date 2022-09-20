package com.swm.serviceImpl;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import com.swm.entity.HomestayAftercareEntity;
import com.swm.entity.HomestayEntity;
import com.swm.exception.ResourceNotFoundException;
import com.swm.repository.IHomestayAftercarerRepository;
import com.swm.service.IAuthenticationService;
import com.swm.service.IHomestayAftercareService;
import com.swm.service.IHomestayService;

@Service
public class HomestayAftercareService implements IHomestayAftercareService {

	@Autowired
	private IHomestayAftercarerRepository homestayServiceRepo;

	@Autowired
	@Lazy
	private IHomestayService homestayService;

	@Autowired
	private IAuthenticationService authenticationService;

	private Date currentDate = new Date();

	@Override
	public HomestayAftercareEntity findHomestayServiceByName(String name, String homestayName) {
		HomestayAftercareEntity homestayServiceEntity = homestayServiceRepo.findHomestayServiceByName(name, homestayName)
				.orElseThrow(() -> new ResourceNotFoundException(name, "Homestay not found"));

		return homestayServiceEntity;
	}

	@Transactional
	@Override
	public HomestayEntity updateHomestayServiceById(String homestayName, Long serviceId,
			HomestayAftercareEntity newHomestayService) {
		HomestayEntity homestayEntity = homestayService.findHomestayByName(homestayName);
		List<HomestayAftercareEntity> homestayServiceList = homestayEntity.getHomestayService();
		homestayServiceList.forEach(s -> {
			if (s.getId().equals(serviceId)) {
				s.setModifiedBy(authenticationService.getAuthenticatedUser().getUsername());
				s.setModifiedDate(currentDate);
				s.setServiceName(newHomestayService.getServiceName());
				s.setPrice(newHomestayService.getPrice());
			}
		});
		return homestayEntity;
	}

	@Override
	public HomestayEntity deleteAllHomestayServiceById(Long homestayId, List<Long> currentHomestayServiceIdList) {
		List<HomestayAftercareEntity> homestayServiceList = currentHomestayServiceIdList.stream()
				.map(id -> this.findHomestayServiceById(id)).collect(Collectors.toList());
		HomestayEntity homestayEntity = homestayService.findHomestayById(homestayId);
		homestayServiceRepo.deleteAll(homestayServiceList);
		
		return homestayEntity;
	}

	@Override
	public HomestayAftercareEntity deleteHomestayServiceById(Long Id) {
		
		return null;
	}

	@Transactional
	@Override
	public HomestayEntity addNewHomestayService(String homestayName, String serviceName, long price) {
		HomestayEntity homestayEntity = homestayService.findHomestayByName(homestayName);
		HomestayAftercareEntity homestayServiceEntity = new HomestayAftercareEntity(serviceName, price, homestayEntity);
		homestayServiceEntity.setCreatedBy(authenticationService.getAuthenticatedUser().getUsername());
		homestayServiceEntity.setCreatedDate(currentDate);
		homestayEntity.getHomestayService().add(homestayServiceEntity);

		return homestayEntity;
	}

	@Transactional
	@Override
	public HomestayEntity addNewHomestayServiceList(String homestayName,
			List<HomestayAftercareEntity> newHomestayServiceList) {
		HomestayEntity homestayEntity = homestayService.findHomestayByName(homestayName);
		newHomestayServiceList.forEach(s -> {
			s.setCreatedBy(authenticationService.getAuthenticatedUser().getUsername());
			s.setCreatedDate(currentDate);
			s.setHomestayServiceContainer(homestayEntity);
		});
		homestayEntity.getHomestayService().addAll(newHomestayServiceList);

		return homestayEntity;
	}

	@Override
	public HomestayAftercareEntity findHomestayServiceById(Long Id) {
		HomestayAftercareEntity homestayServiceEntity = homestayServiceRepo.findById(Id)
				.orElseThrow(() -> new ResourceNotFoundException(Id.toString(), "Homestay service not found"));

		return homestayServiceEntity;
	}

}
