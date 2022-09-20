package com.swm.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "system_statistic")
@AllArgsConstructor
@NoArgsConstructor
@Getter
public class SystemStatisticEntity {
	
	@Id
	@SequenceGenerator(name = "system_statistic_sequence", sequenceName = "system_statistic_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "system_statistic_sequence")
	private Long Id;
	
	@Setter
	private Long totalHomestayRequest = 0L;
	
	@Setter
	private Long totalActiveHomestay = 0L;
	
	@Setter
	private Long totalRejectedHomestay = 0L;
	
	@Setter
	private Long totalProfit = 0L;
	
	@Setter
	private Long totalLandlordRequest = 0L;
	
	@Setter
	private Long totalActiveLandlord = 0L;
	
	@Setter
	private Long totalRejectedLandlordRequest = 0L;	
	
	@Temporal(TemporalType.DATE)
	@Column(unique = true, nullable = false)
	@Setter
	private Date statisticTime;
}
