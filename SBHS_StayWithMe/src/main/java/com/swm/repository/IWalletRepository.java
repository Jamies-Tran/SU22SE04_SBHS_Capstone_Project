package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.LandlordWalletEntity;

public interface IWalletRepository extends JpaRepository<LandlordWalletEntity, Long> {

}
