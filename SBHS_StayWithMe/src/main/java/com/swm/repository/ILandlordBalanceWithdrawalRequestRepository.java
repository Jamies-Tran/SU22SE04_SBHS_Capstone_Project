package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.LandlordBalanceWithdrawalRequestEntity;

public interface ILandlordBalanceWithdrawalRequestRepository extends JpaRepository<LandlordBalanceWithdrawalRequestEntity, Long> {

}
