package com.swm.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "comments")
@NoArgsConstructor
@Getter
public class CommentEntity extends BaseEntity {
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "comment_sequence", sequenceName = "comment_sequence", initialValue = 1)
	@GeneratedValue(
			strategy = GenerationType.SEQUENCE,
			generator = "comment_sequence"
	)
	private Long Id;

	@Column(nullable = false)
	@Setter
	private String content;
	
	// booking_otp properties - end
	
	@ManyToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH})
	@JoinColumn(name = "homestay_id", referencedColumnName = "Id")
	@Setter
	private HomestayEntity homestayComment;
	
	@ManyToOne(cascade = {CascadeType.MERGE, CascadeType.REFRESH})
	@JoinColumn(name = "user_id", referencedColumnName = "Id")
	@Setter
	private PassengerEntity creator;
}
