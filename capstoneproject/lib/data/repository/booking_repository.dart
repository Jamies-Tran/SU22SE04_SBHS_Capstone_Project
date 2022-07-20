import 'dart:async';

import 'package:capstoneproject/api/model/data_repsonse.dart';
import 'package:capstoneproject/api/model/reponse_existed.dart';
import 'package:capstoneproject/data/service/booking_service.dart';
import 'package:capstoneproject/shared_code/model/booked.dart';
import 'package:capstoneproject/shared_code/model/booked_data.dart';
import 'package:capstoneproject/shared_code/model/booked_response.dart';
import 'package:capstoneproject/shared_code/model/cancle_booking_response.dart';
import 'package:capstoneproject/shared_code/model/reservation.dart';
import 'package:dio/dio.dart';

class BookingRepository {
  final BookingService bookingService;

  BookingRepository({required this.bookingService});

  Future<Booked> pushBookingRoom(String idRoom, String checkIn, String checkOut,
      int numberOfDays) async {
    var c = Completer<Booked>();

    try {
      final response = await bookingService
          .pushCreateBooking(idRoom, checkIn, checkOut, numberOfDays)
          .then((value) {
        if (value.statusCode == 400) {
          c.completeError("Kết nối bị hết hạn 400");
        } else {
          Booked? data =
              BookedResponse
                  .fromJson(value.data)
                  .data; //response.data;
          c.complete(data);
        }
      }, onError: (e) {
        ApiResponse data = ApiResponse.fromJson(e.response?.data);
        c.completeError(data.error!);
      });
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        c.completeError("Kết nối bị hết hạn");
      }
      c.completeError(e.toString());
    } catch (ex) {
      c.completeError(ex.toString());
    }

    return c.future;
  }

  Future<BookedData> getAllBookingHistory() async {
    var c = Completer<BookedData>();

    try {
      final response =
      await bookingService.getAllBookingHistory().then((value) {
        if (value.statusCode == 400) {
          c.completeError("Kết nối bị hết hạn 400");
        } else {
          BookedData? data =
              Reservation
                  .fromJson(value.data)
                  .data; //response.data;
          print(value.data);
          c.complete(data);
        }
      }, onError: (e) {
        c.completeError("Kết nối bị hết hạn 400");
      });
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        c.completeError("Kết nối bị hết hạn");
      }
      c.completeError(e.toString());
    } catch (ex) {
      c.completeError(ex.toString());
    }

    return c.future;
  }

  Future<CancelBookingResponse> cancelBookingId(String id) async {
    var c = Completer<CancelBookingResponse>();

    try {
      final response = await bookingService.cancelBooking(id);

      CancelBookingResponse data =
      CancelBookingResponse.fromJson(response.data);

      c.complete(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        c.completeError("Kết nối bị hết hạn");
      }
      c.completeError(e.toString());
    } catch (ex) {
      c.completeError(ex.toString());
    }

    return c.future;
  }

  Future<DataResponse> pay({
    required String idRoom,
    required String checkIn,
    required String checkOut,
    required String clientMessage,
    required String cardNumber,
    required String cardExp,
    required String cardCVV,
  }) async {
    var c = Completer<DataResponse>();

    try {
      final response = await bookingService.pay(
        idRoom,
        checkIn,
        checkOut,
        clientMessage,
        cardNumber,
        "24$cardExp",
        cardCVV,
      );

      DataResponse data = DataResponse.fromJson(response.data);

      c.complete(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        if (e.type == DioErrorType.connectTimeout) {
          c.completeError('Connect Timeout');
        }
      }
      else if(e.response!.statusCode==400) {
        c.complete(DataResponse.fromJson(e.response!.data));
      }
      else{
        c.complete(DataResponse(
            success: false,
            data: "",
            error: e.toString()
        ));
      }
    }catch (ex) {
      c.completeError(
          DataResponse(
            success: false,
            data: "",
            error: ex.toString()
          ));
    }
    return c.future;
  }
}
