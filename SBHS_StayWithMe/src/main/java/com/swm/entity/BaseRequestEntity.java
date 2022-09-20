package com.swm.entity;

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
public class BaseRequestEntity {
	@Column(columnDefinition = "nvarchar(MAX)")
	protected String createdBy;
	
	protected String createdByEmail;
	
	@Column(columnDefinition = "nvarchar(MAX)")
	protected String verifiedBy;
	
	protected String requestType;
	
	protected String status;
	
	@Temporal(TemporalType.DATE)
	@Column(nullable = false)
	protected Date createdDate;
	
	@Temporal(TemporalType.DATE)
	protected Date ModifiedDate;
	
}
