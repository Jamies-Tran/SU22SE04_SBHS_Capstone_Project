package com.swm.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "homestay_facility")
@AllArgsConstructor
@NoArgsConstructor
@Getter
public class HomestayCommonFacilityEntity extends BaseEntity {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "common_facility_sequence", sequenceName = "facility_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "facility_sequence")
	private Long Id;
	
	@Column(nullable = false)
	@Setter
	private String name;
	
	@Setter
	private int amount = 0;
	
	// facility properties - end
	
	@ManyToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH})
	@JoinColumn(name = "homestay_id", referencedColumnName = "Id")
	@Setter
	private HomestayEntity homestayCommonFacility;
}
