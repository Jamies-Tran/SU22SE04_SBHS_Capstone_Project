package com.swm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.WishlistEntity;

public interface IWishlistRepository extends JpaRepository<WishlistEntity, Long> {

}
