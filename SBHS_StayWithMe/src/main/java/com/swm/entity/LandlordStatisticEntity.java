package com.swm.entity;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "landlord_statistic")
@AllArgsConstructor
@NoArgsConstructor
@Getter
public class LandlordStatisticEntity {
	
	@Id
	@SequenceGenerator(name = "landlord_statistic_sequence", sequenceName = "landlord_statistic_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "landlord_statistic_sequence")
	private Long Id;
	
	@Setter
	private Long totalPendingHomestay = 0L;
	
	@Setter
	private Long totalActiveHomestay = 0L;
	
	@Setter
	private Long totalSuccessBooking = 0L;
	
	@Setter
	private Long totalCancelBooking = 0L;
	
	@Setter
	private Long totalProfit = 0L;
	
	@Setter
	private Long totalCommissionProfit = 0L;
	
	@Temporal(TemporalType.DATE)
	@Column(unique = true, nullable = false)
	@Setter
	private Date statisticTime;
	
	
	@ManyToOne(cascade = {CascadeType.REFRESH, CascadeType.MERGE})
	@Setter
	private LandlordEntity landlordStatistic;
}
