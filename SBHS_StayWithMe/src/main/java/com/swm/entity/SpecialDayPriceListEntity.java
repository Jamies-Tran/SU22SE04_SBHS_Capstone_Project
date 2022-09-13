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

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "special_day")
@AllArgsConstructor
@NoArgsConstructor
@Getter
public class SpecialDayPriceListEntity {
	
	@Id
	@SequenceGenerator(name = "special_day_sequence", sequenceName = "special_day_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "special_day_sequence")
	private Long Id;
	
	@Column(unique = true, nullable = false)
	@Setter
	private String specialDayCode = "SD";

	@Setter
	private int startDay;
	
	@Setter
	private int endDay;
	
	@Setter
	private int startMonth;
	
	@Setter
	private int endMonth;
	
	@Setter
	private String description;
	
	@OneToMany(mappedBy = "specialDayPriceList" ,cascade = {CascadeType.MERGE, CascadeType.REFRESH})
	@Setter
	private List<HomestayPriceListEntity> homestayPriceLst;
}
