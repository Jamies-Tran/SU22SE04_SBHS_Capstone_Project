package com.swm.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.swm.entity.BookingEntity;

public interface IBookingRepository extends JpaRepository<BookingEntity, Long> {
	
	@Query(value = "select be from BookingEntity be where be.bookingOtp.code = :bookingOtp")
	Optional<BookingEntity> findBookingByOtp(@Param("bookingOtp") String bookingOtp);
	
	@Query(value = "select b from BookingEntity b where b.bookingHomestay.name = :homestayName")
	Optional<List<BookingEntity>> getAllBookingListByHomestay(@Param("homestayName") String homestayName);
	
	@Query(value = "select b from BookingEntity b where b.bookingHomestay.name = :homestayName and b.status = :status")
	Optional<List<BookingEntity>> getAllBookingListByHomestayAndStatus(@Param("homestayName") String homestayName, @Param("status") String status);
	
	@Query(value = "select b from BookingEntity b where b.bookingHomestay.landlordOwner.landlordAccount.username = :landlordUsername and b.status = :status")
	Optional<List<BookingEntity>> getAllBookingListByLandlordAndStatus(@Param("landlordUsername") String landlordUsername, @Param("status") String status);
	
	@Query(value = "select b from BookingEntity b where b.bookingHomestay.landlordOwner.landlordAccount.username = :landlordUsername")
	Optional<List<BookingEntity>> getAllBookingListByLandlord(@Param("landlordUsername") String landlordUsername);
	
	@Query(value = "select b from BookingEntity b")
	Page<BookingEntity> bookingPaging(Pageable page);
}
