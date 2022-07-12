package com.swm.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.swm.entity.HomestayLicenseImageEntity;

public interface IHomestayLicenseImageRepository extends JpaRepository<HomestayLicenseImageEntity, Long>{
	Optional<HomestayLicenseImageEntity> findLicenseImageByUrl(String url);
}
