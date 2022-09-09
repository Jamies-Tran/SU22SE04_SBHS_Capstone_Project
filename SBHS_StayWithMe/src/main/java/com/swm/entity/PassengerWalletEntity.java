package com.swm.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "passenger_wallet")
@NoArgsConstructor
@Getter
public class PassengerWalletEntity extends BaseWalletEntity {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "passenger_wallet_sequence", sequenceName = "passenger_wallet_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "passenger_wallet_sequence")
	private Long Id;

	
	@OneToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH})
	@JoinColumn(name = "user_id", referencedColumnName = "Id")
	@Setter
	private PassengerEntity owner;
	
	@Setter
	private Long futurePay = 0L;
	
	@OneToMany(mappedBy = "passengerWallet", cascade = {CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE})
	@Setter
	private List<MomoPaymentEntity> momoPaymentList;
	
	
}
