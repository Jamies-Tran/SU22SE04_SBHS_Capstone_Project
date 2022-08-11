package com.swm.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "landlord")
@NoArgsConstructor
@Getter
public class LandlordEntity extends BaseEntity {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "Landlord_sequence", sequenceName = "Landlord_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "Landlord_sequence")
	private Long Id;

	@OneToOne(mappedBy = "owner", cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE })
	@Setter
	private LandlordWalletEntity wallet;

	@Column(nullable = true)
	@Setter
	private double totalProfit = 0.0;

	@OneToMany(mappedBy = "landlordOwner", cascade = { CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE })
	@Setter
	private List<HomestayEntity> homestayOwned = new ArrayList<HomestayEntity>();

	@OneToOne(cascade = { CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE })
	@JoinColumn(name = "account_id", referencedColumnName = "Id")
	@Setter
	private UserEntity landlordAccount;

	@OneToOne(mappedBy = "accountRequesting", cascade = { CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH,
			CascadeType.REMOVE })
	@Setter
	private LandlordAccountRequestEntity request;

	@OneToMany(mappedBy = "owner", cascade = { CascadeType.PERSIST, CascadeType.MERGE,CascadeType.REFRESH, CascadeType.REMOVE })
	@Setter
	private List<CitizenIdentificationEntity> citizenIdentificationUrl;
	
	
}
