package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.HomestayUpdateRequestEntity;

public interface IHomestayUpdateRequestRepository extends JpaRepository<HomestayUpdateRequestEntity, Long> {

}
