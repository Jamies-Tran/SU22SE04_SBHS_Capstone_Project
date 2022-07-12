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
@Table(name = "wallet")
@NoArgsConstructor
@Getter
public class WalletEntity extends BaseEntity {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "wallet_sequence", sequenceName = "wallet_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "wallet_sequence")
	private Long Id;

	@Setter
	private Long balance = 0L;

	@OneToOne
	@JoinColumn(name = "user_id", referencedColumnName = "Id")
	@Setter
	private LandlordEntity owner;

	@OneToMany(mappedBy = "walletOrder", cascade = { CascadeType.MERGE, CascadeType.REFRESH,
			CascadeType.REMOVE }, fetch = FetchType.LAZY)
	@Setter
	private List<MomoOrderProcessEntity> momoOrderList;

	public WalletEntity(LandlordEntity owner, Date createdDate) {
		super();
		this.owner = owner;
		this.createdDate = createdDate;
	}

}
