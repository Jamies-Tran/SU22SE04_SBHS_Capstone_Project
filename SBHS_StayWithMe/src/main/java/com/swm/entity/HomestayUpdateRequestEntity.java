package com.swm.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "homestay_update_request")
@NoArgsConstructor
@Getter
public class HomestayUpdateRequestEntity extends BaseRequestEntity implements Comparable<HomestayUpdateRequestEntity> {
	
	@Id
	@SequenceGenerator(name = "homestay_update_request_sequence", sequenceName = "homestay_update_request_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "homestay_update_request_sequence")
	private Long Id;
	
	@Setter
	private Long homestayUpdateRequestId;
	
	
	@Column(nullable = true, columnDefinition = "nvarchar(MAX)")
	@Setter
	private String newName;
	
	@Column(nullable = true, columnDefinition = "nvarchar(MAX)")
	@Setter
	private String newDescription;
	
	@Column(nullable = true, columnDefinition = "nvarchar(MAX)")
	@Setter
	private String newAddress;
	
	@Column(nullable = true, columnDefinition = "nvarchar(MAX)")
	@Setter
	private String newCity;
	
	@Column(nullable = true)
	@OneToMany(mappedBy = "homestayAdditionalFacilityUpdateRequest", cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	@Setter
	private List<HomestayAdditionalFacilityEntity> newHomestayAdditionalFacility;
	
	@Column(nullable = true)
	@OneToMany(mappedBy = "homestayCommonFacilityUpdateRequest", cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	@Setter
	private List<HomestayCommonFacilityEntity> newHomestayCommonFacility;
	
	@Column(nullable = true)
	@OneToMany(mappedBy = "homestayImageUpdateRequest", cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	@Setter
	private List<HomestayImageEntity> newHomestayImages;
	
	@Column(nullable = true)
	@OneToMany(mappedBy = "homestayPriceListUpdateRequest", cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	@Setter
	private List<HomestayPriceListEntity> newHomestayPriceList;
	
	@Column(nullable = true)
	@OneToMany(mappedBy = "homestayServiceUpdateRequest", cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	@Setter
	private List<HomestayAftercareEntity> newHomestayService;
	
	@Column(nullable = true)
	@Setter
	private String newHomestayLicenseImagesUrl;

	@Override
	public int compareTo(HomestayUpdateRequestEntity o) {
		if(this.getCreatedDate().getTime() == o.getCreatedDate().getTime()) {
			return 0;
		} else if(this.getCreatedDate().getTime() > o.getCreatedDate().getTime()) {
			return 1;
		} else {
			return -1;
		}
	}
	
}
