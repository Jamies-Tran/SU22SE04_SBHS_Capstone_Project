package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.WalletEntity;

public interface IWalletRepository extends JpaRepository<WalletEntity, Long> {

}
