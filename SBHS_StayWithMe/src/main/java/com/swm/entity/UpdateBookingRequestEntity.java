package com.swm.entity;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "update_booking_request")
@NoArgsConstructor
@Getter
public class UpdateBookingRequestEntity extends BaseRequestEntity {
	@Id
	@SequenceGenerator(name = "update_booking_sequence", sequenceName = "update_booking_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "update_booking_sequence")
	private Long Id;
	
	
	@OneToOne(mappedBy = "requestUpdateBooking" ,cascade = {CascadeType.MERGE, CascadeType.REFRESH, CascadeType.PERSIST})
	@Setter
	private BookingEntity bookingChangeRequest;
	
}
