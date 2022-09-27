package com.swm.serviceImpl;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.swm.entity.HomestayEntity;
import com.swm.entity.HomestayPostingRequestEntity;
import com.swm.entity.HomestayUpdateRequestEntity;
import com.swm.entity.LandlordAccountRequestEntity;
import com.swm.entity.LandlordBalanceWithdrawalRequestEntity;
import com.swm.entity.LandlordWalletEntity;
import com.swm.entity.SystemStatisticEntity;
import com.swm.entity.UserEntity;
import com.swm.enums.HomestayStatus;
import com.swm.enums.RequestStatus;
import com.swm.enums.RequestType;
import com.swm.enums.UserStatus;
import com.swm.exception.ResourceNotAllowException;
import com.swm.exception.ResourceNotFoundException;
import com.swm.repository.IHomestayAdditionFacilityRepository;
import com.swm.repository.IHomestayAftercarerRepository;
import com.swm.repository.IHomestayCommonFacilityRepository;
import com.swm.repository.IHomestayImageRepository;
import com.swm.repository.IHomestayPostingRequestRepository;
import com.swm.repository.IHomestayPricListRepository;
import com.swm.repository.IHomestayUpdateRequestRepository;
import com.swm.repository.ILandlordAccountRequestRepository;
import com.swm.repository.ILandlordBalanceWithdrawalRequestRepository;
import com.swm.service.IAuthenticationService;
import com.swm.service.IHomestayService;
import com.swm.service.IRequestService;
import com.swm.service.ISendMailService;
import com.swm.service.ISystemStatisticService;
import com.swm.service.IUserService;
import com.swm.util.ApplicationSendMailUtil;
import com.swm.util.DateParsingUtil;

@Service
public class RequestService implements IRequestService {
	
	@Autowired
	private ISystemStatisticService systemStatisticService;

	@Autowired
	private ILandlordAccountRequestRepository landlordAccountRequesRepo;

	@Autowired
	private IHomestayPostingRequestRepository homestayPostingRequestRepo;

	@Autowired
	private IHomestayUpdateRequestRepository homestayUpdateRequestRepo;

	@Autowired
	private IHomestayAdditionFacilityRepository homestayAdditionalFacilityRepo;

	@Autowired
	private IHomestayCommonFacilityRepository homestayCommonFacilityRepo;

	@Autowired
	private IHomestayImageRepository homestayImageRepo;

	@Autowired
	private IHomestayAftercarerRepository homestayServiceRepo;

	@Autowired
	private IHomestayPricListRepository homestayPriceListRepo;

	@Autowired
	private ILandlordBalanceWithdrawalRequestRepository withdrawalRequestRepo;

	@Autowired
	private IAuthenticationService authenticationService;

	@Autowired
	private PasswordEncoder passwordEncoder;
//	@Autowired
//	private IHomestayRepository homestayRepo;

	@Autowired
	private IUserService userService;

	@Autowired
	private ISendMailService sendMailService;

	@Autowired
	private IHomestayService homestayService;

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
		SystemStatisticEntity systemStatistic = this.systemStatisticService.findSystemStatisticByTime(DateParsingUtil.statisticYearMonthTime(landlordAccountRequestEntity.getCreatedDate())); 
		UserDetails approvedBy = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String landlordName = landlordAccountRequestEntity.getAccountRequesting().getLandlordAccount().getUsername();
		String adminName = approvedBy.getUsername();
		landlordAccountRequestEntity.setVerifiedBy(adminName);
		landlordAccountRequestEntity.setModifiedDate(currentDate);
		if (isAccepted) {
			landlordAccountRequestEntity.setStatus(RequestStatus.ACCEPT.name());
			landlordAccountRequestEntity.getAccountRequesting().getLandlordAccount()
					.setStatus(UserStatus.ACTIVE.name());
			Long totalActiveLandlord = systemStatistic.getTotalActiveLandlord() + 1;
			systemStatistic.setTotalActiveLandlord(totalActiveLandlord);
			message = ApplicationSendMailUtil.generateAcceptLandlordRequestMessage(landlordAccountRequestEntity);
		} else {
			landlordAccountRequestEntity.setStatus(RequestStatus.REJECT.name());
			Long totalRejectedLandlord = systemStatistic.getTotalRejectedLandlordRequest() + 1;
			systemStatistic.setTotalRejectedLandlordRequest(totalRejectedLandlord);
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
		SystemStatisticEntity systemStatistic = this.systemStatisticService.findSystemStatisticByTime(DateParsingUtil.statisticYearMonthTime(homestayPostingRequestEntity.getCreatedDate()));
		HomestayEntity homestayEntity = homestayPostingRequestEntity.getRequestHomestay();
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
			Long totalHomestayActive = systemStatistic.getTotalActiveHomestay() + 1;
			systemStatistic.setTotalActiveHomestay(totalHomestayActive);
			message = ApplicationSendMailUtil.generateAcceptHomestayRequestMessage(homestayPostingRequestEntity);
		} else {
			homestayPostingRequestEntity.setStatus(RequestStatus.REJECT.name());
			homestayPostingRequestEntity.getRequestHomestay().setStatus(HomestayStatus.HOMESTAY_REQUEST_DENIED.name());
			Long totalRejectedHomestay = systemStatistic.getTotalRejectedHomestay() + 1;
			systemStatistic.setTotalRejectedHomestay(totalRejectedHomestay);
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
	public List<HomestayPostingRequestEntity> findAllHomestayPostingRequestByStatus(String status) {
		List<HomestayPostingRequestEntity> requestList = status.equalsIgnoreCase("all")
				? homestayPostingRequestRepo.findAll()
				: homestayPostingRequestRepo.findAll().stream().filter(r -> r.getStatus().equalsIgnoreCase(status))
						.collect(Collectors.toList());

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

	@Override
	public HomestayUpdateRequestEntity createHomestayUpdateRequest(
			HomestayUpdateRequestEntity homestayUpdateRequestEntity) {
		if (homestayUpdateRequestEntity.getHomestayUpdateRequestId() != null) {
			UserEntity userEntity = userService
					.findUserByUserInfo(authenticationService.getAuthenticatedUser().getUsername());
			homestayUpdateRequestEntity.getNewHomestayAdditionalFacility().forEach(a -> {
				a.setCreatedBy(userEntity.getUsername());
				a.setCreatedDate(DateParsingUtil.formatDateTime(currentDate));
				a.setHomestayAdditionalFacilityUpdateRequest(homestayUpdateRequestEntity);
			});
			homestayUpdateRequestEntity.getNewHomestayCommonFacility().forEach(a -> {
				a.setCreatedBy(userEntity.getUsername());
				a.setCreatedDate(DateParsingUtil.formatDateTime(currentDate));
				a.setHomestayCommonFacilityUpdateRequest(homestayUpdateRequestEntity);
			});
			homestayUpdateRequestEntity.getNewHomestayImages().forEach(i -> {
				i.setCreatedBy(userEntity.getUsername());
				i.setCreatedDate(DateParsingUtil.formatDateTime(currentDate));
				i.setHomestayImageUpdateRequest(homestayUpdateRequestEntity);
			});
			homestayUpdateRequestEntity.getNewHomestayPriceList().forEach(p -> {
				p.setCreatedBy(userEntity.getUsername());
				p.setCreatedDate(DateParsingUtil.formatDateTime(currentDate));
				p.setHomestayPriceListUpdateRequest(homestayUpdateRequestEntity);
			});
			homestayUpdateRequestEntity.setRequestType(RequestType.HOMESTAY_UPDATE_REQUEST.name());
			homestayUpdateRequestEntity.setStatus(RequestStatus.PENDING.name());
			homestayUpdateRequestEntity.setCreatedBy(userEntity.getUsername());
			homestayUpdateRequestEntity.setCreatedDate(DateParsingUtil.formatDateTime(currentDate));
			HomestayUpdateRequestEntity homestayUpdateRequestPersistence = homestayUpdateRequestRepo
					.save(homestayUpdateRequestEntity);
			return homestayUpdateRequestPersistence;
		} else {
			throw new ResourceNotFoundException("Id of homestay is empty");
		}

	}

	@Override
	public HomestayUpdateRequestEntity findHomestayUpdateRequest(Long requestId) {
		HomestayUpdateRequestEntity homestayUpdateRequestEntity = homestayUpdateRequestRepo.findById(requestId)
				.orElseThrow(() -> new ResourceNotFoundException("Request not found"));

		return homestayUpdateRequestEntity;
	}

	@Transactional
	@Override
	public void verifyHomestayUpdateRequest(Long requestId, boolean isVerifyByAdmin, boolean isAccepted,
			String rejectMessage) {
		HomestayUpdateRequestEntity homestayUpdateRequest = this.findHomestayUpdateRequest(requestId);
		if (isAccepted) {
			// HomestayEntity homestayEntity =
			// homestayService.findHomestayById(homestayUpdateRequest.getHomestayUpdateRequestId());
			HomestayEntity homestayOriginEntity = homestayService
					.findHomestayById(homestayUpdateRequest.getHomestayUpdateRequestId());
			if (StringUtils.hasLength(homestayUpdateRequest.getNewName())) {
				if (StringUtils.hasLength(homestayUpdateRequest.getNewHomestayLicenseImagesUrl())) {
					homestayOriginEntity.setName(homestayUpdateRequest.getNewName());
				} else {
					throw new ResourceNotAllowException("Update homestay name need add new license");
				}

			}

			if (StringUtils.hasLength(homestayUpdateRequest.getNewDescription())) {
				homestayOriginEntity.setDescription(homestayUpdateRequest.getNewDescription());
			}

			if (StringUtils.hasLength(homestayUpdateRequest.getNewAddress())) {
				if (StringUtils.hasLength(homestayUpdateRequest.getNewHomestayLicenseImagesUrl())) {
					homestayOriginEntity.setAddress(homestayUpdateRequest.getNewAddress());
				} else {
					throw new ResourceNotAllowException("Update homestay address need add new license");
				}

			}

			if (StringUtils.hasLength(homestayUpdateRequest.getNewCity())) {
				if (StringUtils.hasLength(homestayUpdateRequest.getNewHomestayLicenseImagesUrl())) {
					homestayOriginEntity.setCity(homestayUpdateRequest.getNewCity());
				} else {
					throw new ResourceNotAllowException("Update homestay city need add new license");
				}

			}

			if (homestayUpdateRequest.getNewHomestayAdditionalFacility() != null
					|| !homestayUpdateRequest.getNewHomestayAdditionalFacility().isEmpty()) {
				homestayUpdateRequest.getNewHomestayAdditionalFacility().forEach(f -> {
					f.setHomestayAdditionalFacility(homestayOriginEntity);
					homestayOriginEntity.setAdditionalFacilities(List.of(f));
				});
				homestayAdditionalFacilityRepo.clearOldHomestayAdditionalFacility(homestayOriginEntity.getId());
				homestayUpdateRequest.getNewHomestayAdditionalFacility().forEach(f -> {
					f.setHomestayAdditionalFacilityUpdateRequest(null);
				});
			}

			if (homestayUpdateRequest.getNewHomestayCommonFacility() != null
					|| !homestayUpdateRequest.getNewHomestayCommonFacility().isEmpty()) {
				homestayUpdateRequest.getNewHomestayCommonFacility().forEach(f -> {
					f.setHomestayCommonFacility(homestayOriginEntity);
					homestayOriginEntity.setCommonFacilities(List.of(f));
				});
				homestayCommonFacilityRepo.clearOldHomestayCommonFacility(homestayOriginEntity.getId());
				homestayUpdateRequest.getNewHomestayCommonFacility().forEach(c -> {
					c.setHomestayCommonFacilityUpdateRequest(null);
				});
			}

			if (homestayUpdateRequest.getNewHomestayImages() != null
					|| !homestayUpdateRequest.getNewHomestayImages().isEmpty()) {
				homestayUpdateRequest.getNewHomestayImages().forEach(i -> {
					i.setHomestayImage(homestayOriginEntity);
					homestayOriginEntity.setImageList(List.of(i));
				});
				homestayImageRepo.clearOldHomestayImage(homestayOriginEntity.getId());
				homestayUpdateRequest.getNewHomestayImages().forEach(i -> {
					i.setHomestayImageUpdateRequest(null);
				});
			}

			if (homestayUpdateRequest.getNewHomestayService() != null
					|| !homestayUpdateRequest.getNewHomestayService().isEmpty()) {
				homestayUpdateRequest.getNewHomestayService().forEach(s -> {
					s.setHomestayServiceContainer(homestayOriginEntity);
					homestayOriginEntity.setHomestayService(List.of(s));
				});
				homestayServiceRepo.clearOldHomestayService(homestayOriginEntity.getId());
				homestayUpdateRequest.getNewHomestayService().forEach(s -> {
					s.setHomestayServiceUpdateRequest(null);
				});
			}

			if (StringUtils.hasLength(homestayUpdateRequest.getNewHomestayLicenseImagesUrl())) {
				homestayOriginEntity.getLicenseImage().setUrl(homestayUpdateRequest.getNewHomestayLicenseImagesUrl());
			}

			if (homestayUpdateRequest.getNewHomestayPriceList() != null
					|| !homestayUpdateRequest.getNewHomestayPriceList().isEmpty()) {
				homestayUpdateRequest.getNewHomestayPriceList().forEach(p -> {
					p.setHomestayPriceList(homestayOriginEntity);
					homestayOriginEntity.setPriceList(List.of(p));
				});
				homestayPriceListRepo.clearOldPriceList(homestayOriginEntity.getId());
				homestayUpdateRequest.getNewHomestayPriceList().forEach(s -> {
					s.setHomestayPriceListUpdateRequest(null);
				});
			}

			if (isVerifyByAdmin) {
				UserEntity userEntity = userService
						.findUserByUserInfo(authenticationService.getAuthenticatedUser().getUsername());
				homestayUpdateRequest.setVerifiedBy(userEntity.getUsername());
			} else {
				homestayUpdateRequest.setVerifiedBy("system_handler".toUpperCase());
			}

			homestayUpdateRequest.setModifiedDate(DateParsingUtil.formatDateTime(currentDate));
			homestayUpdateRequest.setStatus(RequestStatus.ACCEPT.name());
			homestayOriginEntity.setModifiedBy(homestayUpdateRequest.getCreatedBy());

		} else {

			UserEntity userEntity = userService
					.findUserByUserInfo(authenticationService.getAuthenticatedUser().getUsername());
			homestayUpdateRequest.setVerifiedBy(userEntity.getUsername());
			homestayUpdateRequest.setModifiedDate(DateParsingUtil.formatDateTime(currentDate));
			homestayUpdateRequest.setStatus(RequestStatus.REJECT.name());
		}
	}

	@Transactional
	@Override
	public void autoAcceptHomestayUpdateRequest() {
		List<HomestayUpdateRequestEntity> homestayUpdateRequestList = homestayUpdateRequestRepo.findAll();
		homestayUpdateRequestList.forEach(r -> {
			if (!StringUtils.hasLength(r.getNewName()) && !StringUtils.hasLength(r.getNewAddress())
					&& !StringUtils.hasLength(r.getNewCity())
					&& r.getStatus().equalsIgnoreCase(RequestStatus.PENDING.name())) {
				System.out.println(r.getNewName());
				verifyHomestayUpdateRequest(r.getId(), false, true, null);
			}
		});
	}

	@Transactional
	@Override
	public void deleteHomestayUpdateRequest(Long requestId) {
		HomestayUpdateRequestEntity homestayUpdateRequest = this.findHomestayUpdateRequest(requestId);
		homestayUpdateRequestRepo.delete(homestayUpdateRequest);
	}

//	@Transactional
//	@Override
//	public void autoUpdateHomestayDeleteRequest() {
//		List<HomestayUpdateRequestEntity> homestayUpdateRequestList = homestayUpdateRequestRepo.findAll().stream()
//				.filter(r -> r.getStatus().equalsIgnoreCase(RequestStatus.ACCEPT.name())
//						|| r.getStatus().equalsIgnoreCase(RequestStatus.REJECT.name()))
//				.sorted().collect(Collectors.toList());
//		if (homestayUpdateRequestList.size() >= 10) {
//			homestayUpdateRequestRepo.delete(homestayUpdateRequestList.get(homestayUpdateRequestList.size() - 1));
//		}
//	}

	@Override
	public LandlordBalanceWithdrawalRequestEntity createBalanceWithdrawalRequest(
			LandlordBalanceWithdrawalRequestEntity withdrawalRequestEntity, String password) {
		UserEntity user = userService.findUserByUserInfo(authenticationService.getAuthenticatedUser().getUsername());
		if(passwordEncoder.matches(password, user.getPassword())) {
			withdrawalRequestEntity.setCreatedBy(user.getUsername());
			withdrawalRequestEntity.setCreatedDate(DateParsingUtil.formatDateTime(currentDate));
			withdrawalRequestEntity.setStatus(RequestStatus.PENDING.name());
			withdrawalRequestEntity.setLandlordRequestWithdrawal(user.getLandlord());
			withdrawalRequestEntity.setCreatedByEmail(user.getEmail());
			withdrawalRequestEntity.setRequestType(RequestType.WITHDRAWAL_REQUEST.name());
			user.getLandlord().setWithdrawalRequest(withdrawalRequestEntity);
			LandlordBalanceWithdrawalRequestEntity withdrawalRequestPersistence = withdrawalRequestRepo
					.save(withdrawalRequestEntity);
			return withdrawalRequestPersistence;
		} else {
			throw new ResourceNotAllowException("Wrong password");
		}

		
	}

	@Transactional
	@Override
	public void verifyWithdrawalRequest(Long requestId, boolean isAccepted, String rejectMessage) {
		UserEntity user = userService.findUserByUserInfo(authenticationService.getAuthenticatedUser().getUsername());
		LandlordBalanceWithdrawalRequestEntity withdrawalRequestEntity = this.findWithdrawalRequestById(requestId);
		if(isAccepted) {
			LandlordWalletEntity landlordWallet = withdrawalRequestEntity.getLandlordRequestWithdrawal().getWallet();
			Long landlordCurrentBalance = landlordWallet.getBalance();
			Long landlordBalanceAfterWithdrawal = landlordCurrentBalance - withdrawalRequestEntity.getAmount();
			landlordWallet.setBalance(landlordBalanceAfterWithdrawal);
			landlordWallet.setModifiedBy(withdrawalRequestEntity.getLandlordRequestWithdrawal().getLandlordAccount().getUsername());
			landlordWallet.setModifiedDate(DateParsingUtil.formatDateTime(currentDate));
			
			withdrawalRequestEntity.setVerifiedBy(user.getUsername());
			withdrawalRequestEntity.setModifiedDate(DateParsingUtil.formatDateTime(currentDate));
			withdrawalRequestEntity.setStatus(RequestStatus.ACCEPT.name());
		} else {
			withdrawalRequestEntity.setVerifiedBy(user.getUsername());
			withdrawalRequestEntity.setModifiedDate(DateParsingUtil.formatDateTime(currentDate));
			withdrawalRequestEntity.setStatus(RequestStatus.REJECT.name());
		}
	}

	@Override
	public LandlordBalanceWithdrawalRequestEntity findWithdrawalRequestById(Long requestId) {
		LandlordBalanceWithdrawalRequestEntity withdrawalRequestEntity = withdrawalRequestRepo.findById(requestId)
				.orElseThrow(() -> new ResourceNotFoundException("Request not found."));

		return withdrawalRequestEntity;
	}

	@Override
	public List<HomestayUpdateRequestEntity> findAllHomestayUpdateRequestByStatus(String status) {
		List<HomestayUpdateRequestEntity> homestayEntityListhomestayEntityList = status.equalsIgnoreCase("all") 
				? homestayUpdateRequestRepo.findAll() : homestayUpdateRequestRepo.findAll().stream().filter(h -> h.getStatus().equalsIgnoreCase(status)).collect(Collectors.toList());;
	
		return homestayEntityListhomestayEntityList;
	}

	@Override
	public List<LandlordBalanceWithdrawalRequestEntity> findAllWithdrawalRequestByStatus(String status) {
		List<LandlordBalanceWithdrawalRequestEntity> withdrawalRequestList = status.equalsIgnoreCase("all") 
				? this.withdrawalRequestRepo.findAll() : this.withdrawalRequestRepo.findAll().stream().filter(h -> h.getStatus().equalsIgnoreCase(status)).collect(Collectors.toList());
		
		return withdrawalRequestList;
	}

}
