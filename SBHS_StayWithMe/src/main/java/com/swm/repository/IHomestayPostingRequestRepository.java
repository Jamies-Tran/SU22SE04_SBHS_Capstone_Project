package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.HomestayPostingRequestEntity;

public interface IHomestayPostingRequestRepository extends JpaRepository<HomestayPostingRequestEntity, Long> {

}
