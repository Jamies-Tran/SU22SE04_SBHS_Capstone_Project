package com.swm.serviceImpl;

import java.util.Date;
import java.util.List;

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
	public LandlordAccountRequestEntity verifyLandlordAccountRequestById(Long requestId, boolean isAccepted,
			@Nullable String rejectMessage) {
		String message = "";
		LandlordAccountRequestEntity request = this.findLandlordAccountRequestById(requestId);
		UserDetails approvedBy = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String landlordName = request.getAccountRequesting().getLandlordAccount().getUsername();
		String adminName = approvedBy.getUsername();
		request.setVerifiedBy(adminName);
		request.setModifiedDate(currentDate);
		if (isAccepted) {
			request.setStatus(RequestStatus.ACCEPT.name());
			request.getAccountRequesting().getLandlordAccount().setStatus(UserStatus.ACTIVE.name());
			message = "<h1>Welcome " + landlordName + " ^_^</h1>"
					+ "<p>Your landlord account request has been approved.</p>"
					+ "<p>From now on you can post your home stay on Stay With Me platform.</p>" + "<p>Good luck</p>";
		} else {
			if(!StringUtils.hasLength(rejectMessage)) {
				throw new ResourceNotFoundException("Reject message empty");
			}
			request.setStatus(RequestStatus.REJECT.name());
			message = String.format("<h1>Rejected :(</h1>"
					+ "<p>I'm sorry to inform you that your landlord account request has been denied for reason: </p><br/>"
					+ "<h2>%s</h2>", rejectMessage);
		}
		sendMailService.sendMail(landlordName, message, this.landlordAccountRequestMailSubject);

		return request;
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
		HomestayPostingRequestEntity request = homestayPostingRequestRepo.findById(requestId)
				.orElseThrow(() -> new ResourceNotFoundException(requestId.toString(), "request not found"));
		HomestayEntity homestayEntity = homestayRepo.findHomestayEntiyByRequestId(request)
				.orElseThrow(() -> new ResourceNotFoundException(requestId.toString(), "Homestay request not found"));
		UserDetails approvedBy = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		String adminName = approvedBy.getUsername();
		String landlordName = homestayEntity.getLandlordOwner().getLandlordAccount().getUsername();
		Long landlordWalletBalance = homestayEntity.getLandlordOwner().getWallet().getBalance();
		String homestayName = request.getRequestHomestay().getName();
		String homestayLocation = request.getRequestHomestay().getLocation();
		request.setVerifiedBy(adminName);
		request.setModifiedDate(currentDate);
		if (isAccepted) {
			request.setStatus(RequestStatus.ACCEPT.name());
			request.getRequestHomestay().setStatus(HomestayStatus.HOMESTAY_BOOKING_AVAILABLE.name());
			homestayEntity.getLandlordOwner().getWallet().setBalance(landlordWalletBalance - 500);
			message = "<h1>Your homestay posting request has been accepted ^^</h1>" + "<p>Your homestay " + homestayName
					+ " on location " + homestayLocation + "has been posted on our platform.</p>"
					+ "<p>Ready yourself cause passenger can rent your homestay at any time. Good luck!</p>";
		} else {
			if(!StringUtils.hasLength(rejectMessage)) {
				throw new ResourceNotFoundException("Reject message empty");
			}
			request.setStatus(RequestStatus.REJECT.name());
			request.getRequestHomestay().setStatus(HomestayStatus.HOMESTAY_REQUEST_DENIED.name());
			message = String.format("<h1>Your homestay posting request has been denied :(</h1>" 
					+ "<p>Your homestay %s on location %s has been denied for reason: </p><br/>"
					+ "<p>%s</p>", homestayName, homestayLocation, rejectMessage);
		}
		sendMailService.sendMail(landlordName, message, this.homestayPostingRequestMailSubject);

		return request;
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

}
