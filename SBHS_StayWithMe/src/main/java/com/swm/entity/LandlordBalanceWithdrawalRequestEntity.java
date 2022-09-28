package com.swm.entity;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "landlord_withdrawal_request")
@Getter
public class LandlordBalanceWithdrawalRequestEntity extends BaseRequestEntity {
	@Id
	@SequenceGenerator(name = "withdrawal_request_sequence", sequenceName = "withdrawal_request_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "withdrawal_request_sequence")
	private Long Id;
	
	@Setter
	private Long amount;
	
	@Setter
	private String status;
	
	@Setter
	private String landlordPhone;
	
	
	@OneToOne(cascade = {CascadeType.REFRESH, CascadeType.MERGE})
	@JoinColumn(name = "landlord_id", referencedColumnName = "Id")
	@Setter
	private LandlordEntity landlordRequestWithdrawal;
}
