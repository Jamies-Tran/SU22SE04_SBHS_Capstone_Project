package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.MomoPaymentEntity;

public interface IMomoProcessOrderRepository extends JpaRepository<MomoPaymentEntity, Long> {

}
