import 'package:capstoneproject/api/app_client.dart';
import 'package:dio/dio.dart';

class BookingService {
  Future<Response> pushCreateBooking(
      String idRoom, String checkIn, String checkOut, int numberOfDays) {
    return AppClientCookie.instance.dio.get(
        "/booking/$idRoom/create?checkin=$checkIn&checkout=$checkOut&numberOfDays=$numberOfDays&clientMessage=any");
  }

  Future<Response> getAllBookingHistory() {
    return AppClientCookie.instance.dio.get("/user/booked-rooms?query=");
  }

  Future<Response> cancelBooking(String id) {
    return AppClientCookie.instance.dio
        .put("/booking/" + id + "/user/canceled");
  }

  Future<Response> pay(String idRoom, String checkIn, String checkOut,
      String clientMessage, String cardNumber, String cardExp, String cardCVV) {
    return AppClientCookie.instance.dio.get(
        "/booking/$idRoom/create-mobile?checkin=$checkIn&checkout=$checkOut"
            "&clientMessage=any&cardNumber=$cardNumber&"
            "cardExp=$cardExp&cardCVV=$cardCVV");
  }
}
