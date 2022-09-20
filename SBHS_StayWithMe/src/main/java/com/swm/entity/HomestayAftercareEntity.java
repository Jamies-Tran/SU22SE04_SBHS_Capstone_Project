package com.swm.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "homestay_service")
@NoArgsConstructor
@Getter
public class HomestayAftercareEntity extends BaseEntity {
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "service_sequence", sequenceName = "service_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "service_sequence")
	private Long Id;
	
	@Column(nullable = false)
	@Setter
	private String serviceName;
	
	@Setter
	private Long price;
	
	// homestay_service properties - end
	
	@ManyToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH})
	@JoinColumn(name = "homestay_id", referencedColumnName = "Id")
	@Setter
	private HomestayEntity homestayServiceContainer;
	
	@ManyToMany(mappedBy = "homestayServiceBooking", cascade = {CascadeType.MERGE, CascadeType.REFRESH})
	@Setter
	private List<BookingEntity> bookingService;
	
	@ManyToOne
	@Setter
	private HomestayUpdateRequestEntity homestayServiceUpdateRequest;

	public HomestayAftercareEntity(String serviceName, long price, HomestayEntity homestayServiceContainer) {
		super();
		this.serviceName = serviceName;
		this.price = price;
		this.homestayServiceContainer = homestayServiceContainer;
	}
	
	
}
