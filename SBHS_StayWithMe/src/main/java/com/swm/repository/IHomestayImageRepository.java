package com.swm.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.HomestayImageEntity;

public interface IHomestayImageRepository extends JpaRepository<HomestayImageEntity, Long> {
	Optional<HomestayImageEntity> findHomestayImageByUrl(String url);
}
