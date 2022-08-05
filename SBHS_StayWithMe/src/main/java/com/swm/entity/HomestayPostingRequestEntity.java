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
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "homestay_request")
@NoArgsConstructor
@Getter
public class HomestayPostingRequestEntity extends BaseRequestEntity {
	@Id
	@SequenceGenerator(name = "homestay_request_sequence", sequenceName = "homestay_request_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "homestay_request_sequence")
	private Long Id;
	
	
	@OneToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH} , fetch = FetchType.LAZY)
	@JoinColumn(name = "homestay_id", referencedColumnName = "Id")
	@Setter
	private HomestayEntity requestHomestay;
}
