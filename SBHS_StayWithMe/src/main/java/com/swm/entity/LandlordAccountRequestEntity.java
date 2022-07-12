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
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "landlord_request")
@NoArgsConstructor
@Getter
public class LandlordAccountRequestEntity extends BaseRequestEntity {
	@Id
	@SequenceGenerator(name = "passenger_sequence", sequenceName = "passenger_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "passenger_sequence")
	private Long Id;
	
	@OneToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH})
	@JoinColumn(name = "landlord_id", referencedColumnName = "Id")
	@Setter
	private LandlordEntity accountRequesting;

}
