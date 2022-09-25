package com.swm.entity;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "momo_transaction")
@NoArgsConstructor
@Getter
public class MomoPaymentEntity {
	
	@Id
	@SequenceGenerator(name = "momo_order", sequenceName = "momo_order", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "momo_order")
	private Long Id;
	
	@Setter
	private String partnerCode;

	@Setter
	private String orderId;

	@Setter
	private String requestId;

	@Setter
	private Long amount;

	@Setter
	private String orderInfo;

	@Setter
	private String orderType;

	@Setter
	private Long transId;

	@Setter
	private String resultCode;

	@Setter
	private String message;

	@Setter
	private String payType;

	@Setter
	private String extraData;

	@Setter
	private String signature;
	
	@ManyToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH}, fetch = FetchType.LAZY)
	@JoinColumn(name = "landlord_wallet", referencedColumnName = "Id")
	@Setter
	private LandlordWalletEntity landlordWallet;
	
	@ManyToOne(cascade =  {CascadeType.MERGE, CascadeType.REFRESH})
	@JoinColumn(name = "passenger_wallet", referencedColumnName = "Id")
	@Setter
	private PassengerWalletEntity passengerWallet;
}
