package com.swm.service;

import java.util.List;

import org.springframework.lang.Nullable;

import com.swm.entity.HomestayPostingRequestEntity;
import com.swm.entity.LandlordAccountRequestEntity;

public interface IRequestService {
	
	LandlordAccountRequestEntity findLandlordAccountRequestById(Long requestId);
	
	HomestayPostingRequestEntity findHomestayPostingRequest(Long requestId);
	
	LandlordAccountRequestEntity verifyLandlordAccountRequestById(Long requestId, boolean isAccepted);
	
	HomestayPostingRequestEntity verifyHomestayPostinRequest(Long requestId, boolean isAccepted, @Nullable String rejectMessage);
	
	List<LandlordAccountRequestEntity> findAllLandlordAccountPendingRequest();
	
	List<LandlordAccountRequestEntity> findAllLandlordAccountRequest();
	
	List<HomestayPostingRequestEntity> findAllHomestayPostingRequest();
}
