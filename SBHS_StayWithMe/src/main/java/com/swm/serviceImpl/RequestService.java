package com.swm.serviceImpl;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.swm.entity.HomestayEntity;
import com.swm.entity.HomestayPostingRequestEntity;
import com.swm.entity.LandlordAccountRequestEntity;
import com.swm.enums.HomestayStatus;
import com.swm.enums.RequestStatus;
import com.swm.enums.UserStatus;
import com.swm.exception.ResourceNotFoundException;
import com.swm.repository.IHomestayPostingRequestRepository;
import com.swm.repository.IHomestayRepository;
import com.swm.repository.ILandlordAccountRequestRepository;
import com.swm.service.IRequestService;
import com.swm.service.ISendMailService;
import com.swm.util.ApplicationSendMailUtil;

@Service
public class RequestService implements IRequestService {

	@Autowired
	private ILandlordAccountRequestRepository landlordAccountRequesRepo;

	@Autowired
	private IHomestayPostingRequestRepository homestayPostingRequestRepo;

	@Autowired
	private IHomestayRepository homestayRepo;

	@Autowired
	private ISendMailService sendMailService;

	private Date currentDate = new Date();

	private final String landlordAccountRequestMailSubject = "About your account request on Stay With Me";

	private final String homestayPostingRequestMailSubject = "About your homestay posting request on Stay With Me";

	@Override
	public LandlordAccountRequestEntity findLandlordAccountRequestById(Long requestId) {
		LandlordAccountRequestEntity request = landlordAccountRequesRepo.findById(requestId)
				.orElseThrow(() -> new ResourceNotFoundException(requestId.toString(), "Request id not found"));

		return request;
	}

	@Transactional
	@Override
	public LandlordAccountRequestEntity verifyLandlordAccountRequestById(Long requestId, boolean isAccepted) {
		String message = "";
		LandlordAccountRequestEntity landlordAccountRequestEntity = this.findLandlordAccountRequestById(requestId);
		UserDetails approvedBy = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String landlordName = landlordAccountRequestEntity.getAccountRequesting().getLandlordAccount().getUsername();
		String adminName = approvedBy.getUsername();
		landlordAccountRequestEntity.setVerifiedBy(adminName);
		landlordAccountRequestEntity.setModifiedDate(currentDate);
		if (isAccepted) {
			landlordAccountRequestEntity.setStatus(RequestStatus.ACCEPT.name());
			landlordAccountRequestEntity.getAccountRequesting().getLandlordAccount()
					.setStatus(UserStatus.ACTIVE.name());
			message = ApplicationSendMailUtil.generateAcceptLandlordRequestMessage(landlordAccountRequestEntity);
		} else {
			landlordAccountRequestEntity.setStatus(RequestStatus.REJECT.name());
			message = ApplicationSendMailUtil.generateRejectLandlordRequestMessage(landlordAccountRequestEntity);
		}
		sendMailService.sendMail(landlordName, message, this.landlordAccountRequestMailSubject);

		return landlordAccountRequestEntity;
	}

	@Override
	public HomestayPostingRequestEntity findHomestayPostingRequest(Long requestId) {
		HomestayPostingRequestEntity homestayPostingRequest = homestayPostingRequestRepo.findById(requestId)
				.orElseThrow(() -> new ResourceNotFoundException(requestId.toString(), "Request not found"));

		return homestayPostingRequest;
	}

	@Transactional
	@Override
	public HomestayPostingRequestEntity verifyHomestayPostinRequest(Long requestId, boolean isAccepted,
			@Nullable String rejectMessage) {
		String message = "";
		HomestayPostingRequestEntity homestayPostingRequestEntity = homestayPostingRequestRepo.findById(requestId)
				.orElseThrow(() -> new ResourceNotFoundException(requestId.toString(), "request not found"));
		HomestayEntity homestayEntity = homestayRepo.findHomestayEntiyByRequestId(homestayPostingRequestEntity)
				.orElseThrow(() -> new ResourceNotFoundException(requestId.toString(), "Homestay request not found"));
		UserDetails approvedBy = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		String adminName = approvedBy.getUsername();
		String landlordName = homestayEntity.getLandlordOwner().getLandlordAccount().getUsername();
		Long landlordWalletBalance = homestayEntity.getLandlordOwner().getWallet().getBalance();
		homestayPostingRequestEntity.setVerifiedBy(adminName);
		homestayPostingRequestEntity.setModifiedDate(currentDate);
		if (isAccepted) {
			homestayPostingRequestEntity.setStatus(RequestStatus.ACCEPT.name());
			homestayPostingRequestEntity.getRequestHomestay()
					.setStatus(HomestayStatus.HOMESTAY_BOOKING_AVAILABLE.name());
			homestayEntity.getLandlordOwner().getWallet().setBalance(landlordWalletBalance - 500);
			message = ApplicationSendMailUtil.generateAcceptHomestayRequestMessage(homestayPostingRequestEntity);
		} else {
			if (!StringUtils.hasLength(rejectMessage)) {
				throw new ResourceNotFoundException("Reject message empty");
			}
			homestayPostingRequestEntity.setStatus(RequestStatus.REJECT.name());
			homestayPostingRequestEntity.getRequestHomestay().setStatus(HomestayStatus.HOMESTAY_REQUEST_DENIED.name());
			message = ApplicationSendMailUtil.generateRejectHomstayRequestMessage(homestayPostingRequestEntity,
					rejectMessage);
		}
		sendMailService.sendMail(landlordName, message, this.homestayPostingRequestMailSubject);

		return homestayPostingRequestEntity;
	}

	@Override
	public List<LandlordAccountRequestEntity> findAllLandlordAccountRequest() {
		List<LandlordAccountRequestEntity> requestList = landlordAccountRequesRepo.findAll();

		return requestList;
	}

	@Override
	public List<HomestayPostingRequestEntity> findAllHomestayPostingRequest() {
		List<HomestayPostingRequestEntity> requestList = homestayPostingRequestRepo.findAll();

		return requestList;
	}

	@Override
	public List<LandlordAccountRequestEntity> findAllLandlordAccountRequestByStatus(String status) {
		List<LandlordAccountRequestEntity> landlordPendingRequestList = status.equalsIgnoreCase("all")
				? this.findAllLandlordAccountRequest()
				: this.findAllLandlordAccountRequest().stream().filter(r -> r.getStatus().equalsIgnoreCase(status))
						.collect(Collectors.toList());

		return landlordPendingRequestList;
	}

}
