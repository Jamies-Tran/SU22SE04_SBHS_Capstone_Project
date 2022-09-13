package com.swm.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.Getter;
import lombok.Setter;

@MappedSuperclass
@Getter
@Setter
public class BaseEntity implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Column(columnDefinition = "nvarchar(MAX)")
	protected String createdBy;
	
	@Column(columnDefinition = "nvarchar(MAX)")
	protected String modifiedBy;
	
	@Temporal(TemporalType.DATE)
	@Column(nullable = false)
	protected Date createdDate;
	
	@Temporal(TemporalType.DATE)
	protected Date ModifiedDate;
}
