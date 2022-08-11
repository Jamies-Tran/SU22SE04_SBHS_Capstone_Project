package com.swm.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "booking")
@NoArgsConstructor
@Getter
public class BookingEntity extends BaseEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "booking_sequence", sequenceName = "booking_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "booking_sequence")
	private Long Id;

	@Temporal(TemporalType.DATE)
	@Column(nullable = false)
	@Setter
	private Date checkIn;

	@Temporal(TemporalType.DATE)
	@Column(nullable = false)
	@Setter
	private Date checkOut;
	
	@Setter
	private String checkInBy;
	
	@Setter
	private String checkOutBy;

	@Column(nullable = false)
	@Setter
	private Long totalPrice;
	
	@Setter
	private Long deposit;

	@Column(nullable = false)
	@Setter
	private String status;

	// booking properties - end

	@ManyToOne(cascade = { CascadeType.MERGE, CascadeType.REFRESH })
	@JoinColumn(name = "homestay_Id", referencedColumnName = "Id")
	@Setter
	private HomestayEntity bookingHomestay;

	@ManyToOne(cascade = { CascadeType.MERGE, CascadeType.REFRESH })
	@JoinColumn(name = "passenger_id", referencedColumnName = "Id")
	@Setter
	private PassengerEntity bookingCreator;

	@OneToOne(mappedBy = "bookingContainer", cascade = { CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH,
			CascadeType.REMOVE })
	@Setter
	private BookingOtpEntity bookingOtp;

	@OneToOne(cascade = { CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE })
	@JoinColumn(name = "request_update", referencedColumnName = "Id")
	@Setter
	private UpdateBookingRequestEntity requestUpdateBooking;

	@ManyToMany(cascade = { CascadeType.MERGE, CascadeType.REFRESH })
	@JoinTable(name = "booking_service", joinColumns = @JoinColumn(name = "booking_id", referencedColumnName = "Id"), 
							inverseJoinColumns = @JoinColumn(name = "service_id", referencedColumnName = "Id"))
	@Setter
	private List<HomestayAftercareEntity> homestayServiceBooking;

	@OneToOne(mappedBy = "bookingDeposit", cascade = { CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH,
			CascadeType.REMOVE }, fetch = FetchType.LAZY)
	@Setter
	private BookingDepositEntity bookingPaidDeposit;

}
