package com.swm.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
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
@Table(name = "landlord_wallet")
@NoArgsConstructor
@Getter
public class LandlordWalletEntity extends BaseWalletEntity {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "landlord_wallet_sequence", sequenceName = "landlord_wallet_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "landlord_wallet_sequence")
	private Long Id;

	
	@OneToOne
	@JoinColumn(name = "user_id", referencedColumnName = "Id")
	@Setter
	private LandlordEntity owner;

	@OneToMany(mappedBy = "landlordWallet", cascade = { CascadeType.MERGE, CascadeType.REFRESH,
			CascadeType.REMOVE }, fetch = FetchType.LAZY)
	@Setter
	private List<MomoPaymentEntity> momoPaymentList;

	public LandlordWalletEntity(LandlordEntity owner, Date createdDate) {
		super();
		this.owner = owner;
		this.createdDate = createdDate;
	}

}
