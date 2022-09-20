package com.swm.entity;

import javax.persistence.CascadeType;
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
@Table(name = "homestay_additional_facility")
@AllArgsConstructor
@NoArgsConstructor
@Getter
public class HomestayAdditionalFacilityEntity extends BaseEntity {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "additional_facility_sequence", sequenceName = "additional_facility_sequence", initialValue = 1)
	@GeneratedValue(generator = "additional_facility_sequence", strategy = GenerationType.SEQUENCE)
	private Long Id;
	
	@Setter
	private String name;
	
	@Setter
	private int amount = 0;
	
	@ManyToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH})
	@JoinColumn(name = "homestay_id", referencedColumnName = "Id")
	@Setter
	private HomestayEntity homestayAdditionalFacility;
	
	@ManyToOne
	@Setter
	private HomestayUpdateRequestEntity homestayAdditionalFacilityUpdateRequest;
}
