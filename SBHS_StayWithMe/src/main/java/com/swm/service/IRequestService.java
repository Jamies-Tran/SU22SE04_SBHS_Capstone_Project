package com.swm.service;

import java.util.List;

import org.springframework.lang.Nullable;

import com.swm.entity.HomestayPostingRequestEntity;
import com.swm.entity.HomestayUpdateRequestEntity;
import com.swm.entity.LandlordAccountRequestEntity;
import com.swm.entity.LandlordBalanceWithdrawalRequestEntity;

public interface IRequestService {

	HomestayUpdateRequestEntity createHomestayUpdateRequest(HomestayUpdateRequestEntity homestayUpdateRequestEntity);
	
	LandlordBalanceWithdrawalRequestEntity createBalanceWithdrawalRequest(LandlordBalanceWithdrawalRequestEntity withdrawalRequestEntity);

	LandlordBalanceWithdrawalRequestEntity findWithdrawalRequestById(Long requestId);
	
	LandlordAccountRequestEntity findLandlordAccountRequestById(Long requestId);

	HomestayPostingRequestEntity findHomestayPostingRequest(Long requestId);

	HomestayUpdateRequestEntity findHomestayUpdateRequest(Long requestId);

	LandlordAccountRequestEntity verifyLandlordAccountRequestById(Long requestId, boolean isAccepted);

	HomestayPostingRequestEntity verifyHomestayPostinRequest(Long requestId, boolean isAccepted,
			@Nullable String rejectMessage);

	List<LandlordAccountRequestEntity> findAllLandlordAccountRequestByStatus(String status);

	List<LandlordAccountRequestEntity> findAllLandlordAccountRequest();

	List<HomestayPostingRequestEntity> findAllHomestayPostingRequestByStatus(String status);

	void verifyHomestayUpdateRequest(Long requestId, boolean isVerifyByAdmin, boolean isAccepted,
			@Nullable String rejectMessage);
	
	void verifyWithdrawalRequest(Long requestId, boolean isAccepted, @Nullable String rejectMessage);

	void autoAcceptHomestayUpdateRequest();
	
	void deleteHomestayUpdateRequest(Long requestId);
	
	void autoDeleteHomestayUpdateRequest();

}
