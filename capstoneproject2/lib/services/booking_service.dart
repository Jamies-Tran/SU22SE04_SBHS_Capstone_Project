import 'package:capstoneproject2/services/model/booking_model.dart';

abstract class IBookingService {
  Future<dynamic> getHomestayBookingList(String homestayName, String status);

  Future<dynamic> bookingHomestay(BookingModel bookingModel, String username);

  Future<String> configureHomestayDetailBooking(String? username, String homestayName);

  Future<dynamic> getUserBookingList(String username, String status);

  Future<dynamic> findBookingById(int bookingId);

  Future<dynamic> payBookingDeposit(String username, int bookingId, int amount);

  Future<dynamic> findPassengerCancelBookingTicket(String? username, int bookingId);

  Future<dynamic> cancelBooking(String? username, int bookingId);

  Future<dynamic> checkIn(String checkInOtp, int bookingId, String username);

  Future<dynamic> checkInByRelative(String? username, String checkInOtp);

  Future<dynamic> checkOut(String? username, int bookingId);

  Future<dynamic> findBookingByOtp(String? username, String checkInOtp);

  Future<dynamic> getNearestBookingDate(String? username, String homestayName);
}