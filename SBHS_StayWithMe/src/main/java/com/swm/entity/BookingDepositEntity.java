package com.swm.entity;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
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
@Table(name = "booking_deposit")
@Getter
public class BookingDepositEntity {
	
	@Id
	@SequenceGenerator(name = "deposit_sequence", sequenceName = "deposit_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "deposit_sequence")
	@Setter
	private Long Id;
	
	@Setter
	private Long depositAmount;
	
	@OneToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH}, fetch = FetchType.LAZY)
	@JoinColumn(name = "booking_id", referencedColumnName = "Id")
	@Setter
	private BookingEntity bookingDeposit;
	
	@OneToOne(mappedBy = "bookingDeposit", cascade = {CascadeType.MERGE, CascadeType.REFRESH}, fetch = FetchType.LAZY)
	@Setter
	private MomoOrderProcessEntity momoOrderProcess;
	
}
