package com.swm.entity;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "promotion")
@NoArgsConstructor
@Getter
public class PromotionEntity extends BaseEntity {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(
			name = "promotion_sequence",
			sequenceName = "promotion_sequence",
			initialValue = 1
	)
	@GeneratedValue(
			strategy = GenerationType.SEQUENCE,
			generator = "promotion_sequence"
	)
	private Long Id;
	
	@Temporal(TemporalType.DATE)
	@Column(nullable = false)
	@Setter
	private Date expirationTime;
	
	@Column(unique = true, nullable = false)
	@Setter
	private String code;
	
	// promotion properties - end
	
	@ManyToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE}, fetch = FetchType.EAGER)
	@JoinColumn(name = "voucher_id",referencedColumnName = "Id")
	@Setter
	private VoucherWalletEntity voucherWalletContainer;
	
}
