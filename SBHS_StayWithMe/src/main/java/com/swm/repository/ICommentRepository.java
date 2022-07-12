package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.CommentEntity;

public interface ICommentRepository extends JpaRepository<CommentEntity, Long> {

}
