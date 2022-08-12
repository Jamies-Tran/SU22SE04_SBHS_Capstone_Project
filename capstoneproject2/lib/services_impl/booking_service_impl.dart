import 'dart:convert';

import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/services/api_url_provider/api_url_provider.dart';
import 'package:capstoneproject2/services/booking_service.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_clound_firestore_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/auth_model.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/model/homestay_model.dart';
import 'package:capstoneproject2/services/model/wallet_model.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../services/model/booking_model.dart';

class BookingServiceImpl extends IBookingService {

  final GET_BOOKING_HOMESTAY_LIST_URL = "$BOOKING_API_URL/permit-all/booking-list";

  final GET_USER_BOOKING_LIST_URL = "$BOOKING_API_URL/booking-list";

  final BOOKING_HOMESTAY_URL = BOOKING_API_URL;

  final PAY_BOOKING_DEPOSIT = "$BOOKING_API_URL/deposit/payment";

  final GET_BOOKING_BY_ID = "$BOOKING_API_URL/permit-all/get";

  final CHECK_IN = "$BOOKING_API_URL/checkin";

  final passengerService = locator.get<IPassengerService>();

  final firebaseFirestoreService = locator.get<ICloudFirestoreService>();

  final formatDate = DateFormat("yyyy-MM-dd");

  @override
  Future getHomestayBookingList(String homestayName, String status) async {
    var client = http.Client();
    var url = Uri.parse("$GET_BOOKING_HOMESTAY_LIST_URL/$homestayName?status=$status");
    var response = await client.get(url, headers: {"content-type" : "application/json"}).timeout(const Duration(seconds: 5));
    var responseData = json.decode(response.body);
    if(response.statusCode == 200) {
      var homestayBookingList = List<BookingModel>.from(responseData.map((element) => BookingModel.fromJson(element)));
      return homestayBookingList;
    } else {
      var errorHandlerModel = ErrorHandlerModel.fromJson(responseData);
      return errorHandlerModel;
    }

  }

  @override
  Future<String> configureHomestayDetailBooking(String? username, String homestayName) async {
    String configuration = "BOOKING_AVAILABLE";
    if(username != null) {
      WalletModel walletModel = await passengerService.getUserWallet(username);
      var userBookingList = await getUserBookingList(username, bookingStatus["all"]!);
      if(walletModel.balance == 0) {
        configuration = "INSUFFICIENT_BALANCE";
      } else {
        if(userBookingList is List<BookingModel>) {
          userBookingList.forEach((element) {
            if(element.homestayName.compareTo(homestayName) == 0 &&
                !(element.status.compareTo(bookingStatus["pending"]) == 0) &&
                !(element.status.compareTo(bookingStatus["rejected"]) == 0) &&
                !(element.status.compareTo(bookingStatus["canceled"]) == 0) &&
                !(element.status.compareTo(bookingStatus["check_out"]) == 0) &&
                !(element.status.compareTo(bookingStatus["finish"]) == 0)
            ) {
              configuration = "BOOKING_PROGRESS";
            }
          });
        }
      }

    }
    return configuration;
  }

  @override
  Future getUserBookingList(String username, String status) async {
    final user = await firebaseFirestoreService.findUserFireStore(username);
    if(user is AuthenticateModel) {
      final client = http.Client();
      final url = Uri.parse("$GET_USER_BOOKING_LIST_URL/$username?status=$status");
      final response = await client.get(
        url,
        headers: {"content-type":"application/json", "Authorization":"Bearer ${user.accessToken}"}
      );

      if(response.statusCode == 200) {
        final responseBody =json.decode(response.body);
        final bookingList = List<BookingModel>.from(responseBody.map((element) => BookingModel.fromJson(element)));
        return bookingList;
      } else {
        final responseBody =json.decode(response.body);
        final errorHandlerModel = ErrorHandlerModel.fromJson(responseBody);
        return errorHandlerModel;
      }
    }
  }

  @override
  Future bookingHomestay(BookingModel bookingModel, String username) async {
    final user = await firebaseFirestoreService.findUserFireStore(username);
    if(user is AuthenticateModel) {
      final client = http.Client();
      final url = Uri.parse(BOOKING_HOMESTAY_URL);
      final response = await client.post(
        url,
        headers: {"content-type":"application/json", "Authorization":"Bearer ${user.accessToken}"},
        body: json.encode(bookingModel.toJson())
      ).timeout(const Duration(seconds: 20));
      if(response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        final bookingModel = BookingModel.fromJson(responseBody);
        return bookingModel;
      } else {
        final responseBody = json.decode(response.body);
        final errorHandlerModel = ErrorHandlerModel.fromJson(responseBody);
        return errorHandlerModel;
      }
    }
  }

  @override
  Future payBookingDeposit(String username, int bookingId, int amount) async {
    final user = await firebaseFirestoreService.findUserFireStore(username);
    if(user is AuthenticateModel) {
      final client = http.Client();
      final url = Uri.parse("$PAY_BOOKING_DEPOSIT/$bookingId");
      Map<String, dynamic> requestBody = {"amount": "$amount"};
      final response = await client.post(
          url,
          headers: {"content-type":"application/json", "Authorization":"Bearer ${user.accessToken}"},
          body: json.encode(requestBody)
      );
      if(response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final depositAmount = DepositAmount.fromJson(responseBody);
        return depositAmount;
      } else {
        final responseBody = json.decode(response.body);
        final errorHandler = ErrorHandlerModel.fromJson(responseBody);
        return errorHandler;
      }
    }
  }

  @override
  Future findBookingById(int bookingId) async {
    final client = http.Client();
    final url = Uri.parse("$GET_BOOKING_BY_ID/$bookingId");
    final response = await client.get(
        url,
        headers: {"content-type":"application/json"}
    ).timeout(const Duration(seconds: 20));
    if(response.statusCode == 200) {
      final bookingModel = BookingModel.fromJson(json.decode(response.body));
      return bookingModel;
    } else {
      final errorHandlerModel = ErrorHandlerModel.fromJson(json.decode(response.body));
      return errorHandlerModel;
    }
  }

  @override
  Future checkIn(String checkInOtp, int bookingId, String username) async {
    final user = await firebaseFirestoreService.findUserFireStore(username);
    if(user is AuthenticateModel) {
      final client = http.Client();
      final url = Uri.parse(CHECK_IN);
      Map<String,dynamic> requestBody = {"bookingOtp":checkInOtp, "bookingId":bookingId};
      final response = await client.post(
          url,
          headers: {"content-type":"application/json", "Authorization":"Bearer ${user.accessToken}"},
          body: json.encode(requestBody)
      );
      if(response.statusCode == 200) {
        final bookingModel = BookingModel.fromJson(json.decode(response.body));
        return bookingModel;
      } else {
        final errorHandlerModel = ErrorHandlerModel.fromJson(json.decode(response.body));
        return errorHandlerModel;
      }
    }
  }

  @override
  Future getNearestBookingDate(String username, String homestayName) async {
    var userBookingList = await getUserBookingList(username, bookingStatus["check_in"]!);
    if(userBookingList is List<BookingModel>) {
      final bookingModel = userBookingList
          .where((element) => element.homestayName.compareTo(homestayName) == 0)
          .where((element) => formatDate.parse(element.checkIn).difference(DateTime.now()).inDays < 7)
          .first;
      return bookingModel;
    }
  }
}

class DepositAmount {
  final int? amount;

  DepositAmount({this.amount});

  factory DepositAmount.fromJson(Map<String, dynamic> json) => DepositAmount(
    amount: json["amount"]
  );
}