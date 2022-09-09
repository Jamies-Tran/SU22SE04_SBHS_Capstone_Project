package com.swm.entity;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "passenger_cancel_booking_ticket")
@AllArgsConstructor
@NoArgsConstructor
@Getter
public class PassengerCancelBookingTicketEntity {
	@Id
	@SequenceGenerator(name = "shield_sequence", sequenceName = "shield_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "shield_sequence")
	private Long Id;
	
	@Setter
	private Boolean firstTimeCancelActive = true;
	
	@Setter
	private Boolean secondTimeCancelActive = true;
	
	@Setter
	private Date activeDate;
	
	@ManyToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH})
	@JoinColumn(name = "passenger_id", referencedColumnName = "Id")
	@Setter
	private PassengerEntity passengerOwnerOfTicket;
	
	@OneToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH})
	@JoinColumn(name = "homestay_Id", referencedColumnName = "Id")
	@Setter
	private HomestayEntity homestayTicketForCancel;
}
