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
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "voucher_wallet")
@NoArgsConstructor
@Getter
public class VoucherWalletEntity extends BaseEntity {
	
	// voucher_wallet properties - start
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "voucher_wallet_sequence", sequenceName = "voucher_wallet_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "voucher_wallet_sequence")
	private Long Id;
	
	// voucher_wallet properties - end
	
	@OneToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH}, fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id", referencedColumnName = "Id")
	@Setter
	private PassengerEntity voucherWalletOwner;
	
	@OneToMany(mappedBy = "voucherWalletContainer", cascade = {CascadeType.MERGE, CascadeType.REFRESH})
	@Setter
	private List<PromotionEntity> promotionList = new ArrayList<PromotionEntity>();
	
}
