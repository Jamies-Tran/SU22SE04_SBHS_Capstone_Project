package com.swm.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "passenger")
@NoArgsConstructor
@Getter
public class PassengerEntity extends BaseEntity {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "passenger_sequence", sequenceName = "passenger_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "passenger_sequence")
	private Long Id;

	@OneToMany(mappedBy = "bookingCreator", cascade = { CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE })
	@Setter
	private List<BookingEntity> booking;

	@OneToOne(mappedBy = "wishlistCreator", cascade = { CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE })
	@Setter
	private WishlistEntity wishlist;

	@OneToOne(mappedBy = "userRating", cascade = { CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE })
	@Setter
	private RatingEntity rating;

	@OneToMany(mappedBy = "creator", cascade = { CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE })
	@Setter
	private List<CommentEntity> comment = new ArrayList<CommentEntity>();

	@OneToOne(mappedBy = "voucherWalletOwner", cascade = { CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH,
			CascadeType.REMOVE })
	@Setter
	private VoucherWalletEntity voucherWallet;

	@ManyToMany(mappedBy = "regularHomestays", cascade = { CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE })
	@Setter
	private List<HomestayEntity> royalCustomer = new ArrayList<HomestayEntity>();

	@OneToOne(cascade = { CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH,
			CascadeType.REMOVE }, fetch = FetchType.EAGER)
	@JoinColumn(name = "Account_id", referencedColumnName = "Id")
	@Setter
	private UserEntity passengerAccount;
	
}
