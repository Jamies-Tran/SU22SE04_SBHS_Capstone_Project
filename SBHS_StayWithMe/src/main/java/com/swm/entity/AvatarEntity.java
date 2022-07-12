package com.swm.entity;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "avatar")
@NoArgsConstructor
@Getter
public class AvatarEntity extends BaseEntity {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "avatar_sequence", sequenceName = "avatar_sequence", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "avatar_sequence")
	private Long Id;
	
	@Setter
	private String url;
	
	@OneToOne(mappedBy = "avatar", cascade = {CascadeType.MERGE, CascadeType.REFRESH})
	@Setter
	private UserEntity poster;

	public AvatarEntity(String url) {
		super();
		this.url = url;
	}
	
}
