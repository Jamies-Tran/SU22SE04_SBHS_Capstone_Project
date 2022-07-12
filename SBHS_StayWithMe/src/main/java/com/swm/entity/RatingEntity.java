package com.swm.entity;

import javax.persistence.Table;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;

@Entity
@Table(name = "rating_point")
@NoArgsConstructor
@Getter
public class RatingEntity extends BaseEntity {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "rating_sequence", sequenceName = "rating_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "rating_sequence")
	private Long Id;
	
	@Column(name = "convenient_point")
	@Setter
	private double convenient = 0.0;
	
	@Column(name = "position_point")
	@Setter
	private double position = 0.0;
	
	@Column(name = "security_point")
	@Setter
	private double security = 0.0;
	
	// rating properties - end
	
	@OneToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH})
	@JoinColumn(name = "homestay", referencedColumnName = "Id")
	@Setter
	private HomestayEntity homestayPoint;
	
	@OneToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH})
	@JoinColumn(name = "user_id", referencedColumnName = "Id")
	@Setter
	private PassengerEntity userRating;
}
