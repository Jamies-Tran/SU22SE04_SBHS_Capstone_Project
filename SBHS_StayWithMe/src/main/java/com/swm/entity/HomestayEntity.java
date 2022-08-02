package com.swm.entity;

import java.util.ArrayList;
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
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "homestay")
@NoArgsConstructor
@Getter
public class HomestayEntity extends BaseEntity {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "homestay_sequence", sequenceName = "homestay_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "homestay_sequence")
	private Long Id;

	@Column(unique = true, nullable = false)
	@Setter
	private String name;
	
	@Setter
	private String description;
	
	
	@Column(nullable = false)
	@Setter
	private String address;
	
	@Column(nullable = false)
	@Setter
	private String city;

	@Column(nullable = false)
	@Setter
	private double profit = 0.0;

	@Column(nullable = false)
	@Setter
	private long price;
	
	@Setter
	private int numberOfRoom;
	
	@Setter
	private String checkInTime;

	@Setter
	private String checkOutTime;

	@Column(nullable = false)
	@Setter
	private String payment;

	@Column(nullable = false)
	@Setter
	private String status;
	
	@OneToOne(mappedBy = "homestayShieldForCancel", cascade = {CascadeType.MERGE, CascadeType.REFRESH}, orphanRemoval = true)
	@Setter
	private PassengerShieldCancelBookingEntity shieldForCancelBooking;

	@ManyToOne(cascade = { CascadeType.MERGE, CascadeType.REFRESH }, fetch = FetchType.LAZY)
	@JoinColumn(name = "owner_id", referencedColumnName = "Id")
	@Setter
	private LandlordEntity landlordOwner;

	@OneToMany(mappedBy = "bookingHomestay", cascade = { CascadeType.MERGE, CascadeType.REFRESH,
			CascadeType.REMOVE }, fetch = FetchType.LAZY)
	@Setter
	private List<BookingEntity> booking = new ArrayList<BookingEntity>();

	@ManyToMany(mappedBy = "wishlistHomestays", cascade = { CascadeType.MERGE, CascadeType.REFRESH,
			CascadeType.REMOVE }, fetch = FetchType.LAZY)
	@Setter
	private List<WishlistEntity> wishlists = new ArrayList<WishlistEntity>();

	@OneToOne(mappedBy = "homestayPoint", cascade = { CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH,
			CascadeType.REMOVE }, fetch = FetchType.LAZY)
	@Setter
	private RatingEntity rating;

	@OneToMany(mappedBy = "homestayComment", cascade = { CascadeType.MERGE, CascadeType.REFRESH,
			CascadeType.REMOVE }, fetch = FetchType.LAZY)
	@Setter
	private List<CommentEntity> comment;

	@OneToMany(mappedBy = "homestayFacilityContainer", cascade = { CascadeType.PERSIST, CascadeType.MERGE,
			CascadeType.REFRESH, CascadeType.REMOVE }, fetch = FetchType.LAZY)
	@Setter
	private List<HomestayFacilityEntity> facilities = new ArrayList<HomestayFacilityEntity>();

	@OneToMany(mappedBy = "homestayServiceContainer", cascade = { CascadeType.PERSIST, CascadeType.MERGE,
			CascadeType.REFRESH, CascadeType.REMOVE }, fetch = FetchType.LAZY)
	@Setter
	private List<HomestayAftercareEntity> homestayService = new ArrayList<HomestayAftercareEntity>();

	@ManyToMany(cascade = { CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE }, fetch = FetchType.LAZY)
	@JoinTable(name = "homestay_user", joinColumns = @JoinColumn(name = "homestay_id", referencedColumnName = "Id"), inverseJoinColumns = @JoinColumn(name = "user_id", referencedColumnName = "Id"))
	@Setter
	private List<PassengerEntity> regularHomestays = new ArrayList<PassengerEntity>();

	@OneToOne(mappedBy = "requestHomestay", cascade = { CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH,
			CascadeType.REMOVE }, fetch = FetchType.LAZY)
	@Setter
	private HomestayPostingRequestEntity homestayPostingRequest;

	@OneToMany(mappedBy = "homestayImage", cascade = { CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH,
			CascadeType.REMOVE }, fetch = FetchType.LAZY)
	@Setter
	private List<HomestayImageEntity> imageList = new ArrayList<HomestayImageEntity>();

	@OneToOne(mappedBy = "homestayLicense", cascade = { CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH,
			CascadeType.REMOVE }, fetch = FetchType.LAZY)
	@JoinColumn(name = "license_id", referencedColumnName = "Id")
	@Setter
	private HomestayLicenseImageEntity licenseImage;

}
