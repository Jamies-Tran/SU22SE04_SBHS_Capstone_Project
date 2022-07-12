package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.MomoOrderProcessEntity;

public interface IMomoProcessOrderRepository extends JpaRepository<MomoOrderProcessEntity, Long> {

}
