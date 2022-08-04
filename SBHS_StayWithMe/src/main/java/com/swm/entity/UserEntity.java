package com.swm.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "users")
@NoArgsConstructor
@Getter
public class UserEntity extends BaseEntity {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "user_sequence",sequenceName = "user_sequence",initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "user_sequence") 
	private Long Id;
	
	@Column(unique = true, nullable = false)
	@Setter
	private String username;
	
	@Setter
	private String password;
	
	@Setter
	private String address;
	
	@Setter
	private String gender;
	
	@Column(unique = true, nullable = false)
	@Setter
	private String email;
	
	@Column(unique = true, nullable = false)
	@Setter
	private String phone;
	
	@Column(unique = true, nullable = false)
	@Setter
	private String citizenIdentificationString;
	
	@Temporal(TemporalType.DATE)
	@Column(nullable = false)
	@Setter
	private Date dob;
	
	@Column(nullable = false)
	@Setter
	private String status;
	
	@Column
	@Setter
	private Boolean passwordChangable = false;
	
	@ManyToMany(cascade = {CascadeType.MERGE, CascadeType.REFRESH}, fetch = FetchType.EAGER)
	@JoinTable(name = "user_role",joinColumns = @JoinColumn(name = "user_id", referencedColumnName = "Id"),
		inverseJoinColumns = @JoinColumn(name = "role_id", referencedColumnName = "Id"))
	@Setter
	private List<RoleEntity> roles;
	
	
	@OneToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE})
	@JoinColumn(name = "avatar_id", referencedColumnName = "Id")
	@Setter
	private AvatarEntity avatar;
	
	@OneToOne(mappedBy = "otpOwner",cascade = {CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE})
	@Setter
	private UserOtpEntity userOtp;
	
	@OneToOne(mappedBy = "passengerAccount", cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE})
	@Setter
	private PassengerEntity passenger;
	
	@OneToOne(mappedBy = "landlordAccount", cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE})
	@Setter
	private LandlordEntity landlord;
	
	@OneToOne(mappedBy = "adminAccount", cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE})
	@Setter
	private AdminEntity admin;
	
	
	
}
