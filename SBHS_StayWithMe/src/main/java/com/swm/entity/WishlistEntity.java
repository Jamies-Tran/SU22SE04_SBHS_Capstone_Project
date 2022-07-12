package com.swm.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "wishlist")
@NoArgsConstructor
@Getter
public class WishlistEntity extends BaseEntity {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "wishlist_sequence", sequenceName = "wishlist_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "wishlist_sequence")
	private Long Id;
	
	@ManyToMany(cascade = {CascadeType.MERGE, CascadeType.REFRESH})
	@JoinTable(name = "wishlist_homestay", joinColumns = @JoinColumn(name = "wishlist_id", referencedColumnName = "Id"),
		inverseJoinColumns = @JoinColumn(name = "homestay_id", referencedColumnName = "Id"))
	@Setter
	private List<HomestayEntity> wishlistHomestays = new ArrayList<HomestayEntity>();
	
	@OneToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH})
	@JoinColumn(name = "user_id", referencedColumnName = "Id")
	@Setter
	private PassengerEntity wishlistCreator;
}
