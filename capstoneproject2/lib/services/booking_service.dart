import 'package:capstoneproject2/services/model/booking_model.dart';

abstract class IBookingService {
  Future<dynamic> getHomestayBookingList(String homestayName, String status);

  Future<dynamic> bookingHomestay(BookingModel bookingModel, String email);

  Future<String> configureHomestayDetailBooking(String? email, String homestayName);

  Future<dynamic> getUserBookingList(String email, String status);

  Future<dynamic> findBookingById(int bookingId);

  Future<dynamic> payBookingDeposit(String email, int bookingId, int amount);

  Future<dynamic> findPassengerCancelBookingTicket(String? email, int bookingId);

  Future<dynamic> cancelBooking(String? email, int bookingId);

  Future<dynamic> checkIn(String checkInOtp, int bookingId, String email);

  Future<dynamic> checkInByRelative(String? email, String checkInOtp);

  Future<dynamic> checkOut(String? email, int bookingId);

  Future<dynamic> findBookingByOtp(String? email, String checkInOtp);

  Future<dynamic> getNearestBookingDate(String? email, String homestayName);
}