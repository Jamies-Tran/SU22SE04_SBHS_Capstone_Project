package com.swm.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
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
@Table(name = "booking_otp")
@NoArgsConstructor
@Getter
public class BookingOtpEntity extends BaseEntity {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "bookingotp_sequence", sequenceName = "bookingotp_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "bookingotp_sequence")
	private Long Id;
	
	@Column(unique = true, nullable = false)
	@Setter
	private String code;
	
	@Setter
	private String passengerName;
	
	// booking_otp properties - end
	
	@OneToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH}, fetch = FetchType.EAGER)
	@JoinColumn(name = "booking_id", referencedColumnName = "Id")
	@Setter
	private BookingEntity bookingContainer;
}
