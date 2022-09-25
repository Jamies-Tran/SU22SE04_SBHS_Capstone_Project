import 'dart:convert';

import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/services/api_url_provider/api_url_provider.dart';
import 'package:capstoneproject2/services/booking_service.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_auth_service.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_clound_firestore_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/auth_model.dart';
import 'package:capstoneproject2/services/model/cancel_booking_ticket_model.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/model/homestay_model.dart';
import 'package:capstoneproject2/services/model/wallet_model.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../services/model/booking_model.dart';

class BookingServiceImpl extends IBookingService {

  final getBookingHomestayListUrl = "$bookingApiUrl/permit-all/booking-list";

  final getUserBookingListUrl = "$bookingApiUrl/booking-list";

  final bookingHomestayUrl = bookingApiUrl;

  final payBookingDepositUrl = "$bookingApiUrl/deposit/payment";

  final getBookingByIdUrl = "$bookingApiUrl/permit-all/get";

  final checkInUrl = "$bookingApiUrl/checkin";

  final checkOutUrl = "$bookingApiUrl/check-out";

  final checkInByRelativeUrl = "$bookingApiUrl/relative-checkin";

  final getBookingByOtpUrl = "$bookingApiUrl/booking-otp";

  final getCancelBookingTicketUrl = "$bookingApiUrl/cancel-ticket";

  final cancelBookingUrl = "$bookingApiUrl/passenger-cancel";

  final passengerService = locator.get<IPassengerService>();

  final firebaseFirestoreService = locator.get<ICloudFirestoreService>();

  final firebaseAuthService = locator.get<IFirebaseAuthenticateService>();

  final formatDate = DateFormat("yyyy-MM-dd");

  @override
  Future getHomestayBookingList(String homestayName, String status) async {
    var client = http.Client();
    var url = Uri.parse("$getBookingHomestayListUrl/$homestayName?status=$status");
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
  Future<String> configureHomestayDetailBooking(String? email, String homestayName) async {
    String configuration = "BOOKING_AVAILABLE";
    if(email != null) {
      var walletModel = await passengerService.getUserWallet(email);
      var userBookingList = await getUserBookingList(email, bookingStatus["all"]!);
      if(walletModel is WalletModel && walletModel.balance == 0 && (walletModel.balance! - walletModel.futurePay!) == 0) {
        configuration = "INSUFFICIENT_BALANCE";
      } else if(walletModel is ErrorHandlerModel && walletModel.statusCode == 403) {
        await firebaseAuthService.forgetGoogleSignIn(email);
        configuration = "ACCESS_DENIED";
      }else {
        if(userBookingList is List<BookingModel>) {
          for (var element in userBookingList) {
            if(element.homestayName.compareTo(homestayName) == 0 &&
                !(element.status.compareTo(bookingStatus["pending"]) == 0 || element.status.compareTo(bookingStatus["pending_alert_sent"]) == 0) &&
                !(element.status.compareTo(bookingStatus["rejected"]) == 0) &&
                !(element.status.compareTo(bookingStatus["canceled"]) == 0) &&
                !(element.status.compareTo(bookingStatus["check_out"]) == 0 || element.status.compareTo(bookingStatus["landlord_check_out"]) == 0 || element.status.compareTo(bookingStatus["relative_check_out"]) == 0) &&
                !(element.status.compareTo(bookingStatus["finish"]) == 0)
            ) {

              configuration = "BOOKING_PROGRESS";
            }
          }
        } else if(userBookingList is ErrorHandlerModel && userBookingList.statusCode == 403) {
          await firebaseAuthService.forgetGoogleSignIn(email);
          configuration = "ACCESS_DENIED";
        }
      }

    }
    return configuration;
  }

  @override
  Future getUserBookingList(String email, String status) async {
    final user = await firebaseFirestoreService.findUserFireStore(email);
    if(user is AuthenticateModel) {
      final client = http.Client();
      final url = Uri.parse("$getUserBookingListUrl?status=$status");
      final response = await client.get(
        url,
        headers: {"content-type":"application/json", "Authorization":"Bearer ${user.accessToken}"}
      );

      if(response.statusCode == 200) {
        final responseBody =json.decode(response.body);
        final bookingList = List<BookingModel>.from(responseBody.map((element) => BookingModel.fromJson(element)));
        return bookingList;
      } else {
        if(response.statusCode == 403) {
          await firebaseAuthService.forgetGoogleSignIn(email!);
        }
        final responseBody =json.decode(response.body);
        final errorHandlerModel = ErrorHandlerModel.fromJson(responseBody);
        return errorHandlerModel;
      }
    }
  }

  @override
  Future bookingHomestay(BookingModel bookingModel, String email) async {
    final user = await firebaseFirestoreService.findUserFireStore(email);
    if(user is AuthenticateModel) {
      final client = http.Client();
      final url = Uri.parse(bookingHomestayUrl);
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
  Future payBookingDeposit(String email, int bookingId, int amount) async {
    final user = await firebaseFirestoreService.findUserFireStore(email);
    if(user is AuthenticateModel) {
      final client = http.Client();
      final url = Uri.parse("$payBookingDepositUrl/$bookingId");
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
    final url = Uri.parse("$getBookingByIdUrl/$bookingId");
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
  Future checkIn(String checkInOtp, int bookingId, String email) async {
    final user = await firebaseFirestoreService.findUserFireStore(email);
    if(user is AuthenticateModel) {
      final client = http.Client();
      final url = Uri.parse(checkInUrl);
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
  Future getNearestBookingDate(String? email, String homestayName) async {
    if(email != null) {
      var userBookingList = await getUserBookingList(email, bookingStatus["check_in"]!);
      if(userBookingList is List<BookingModel>) {
        final bookingModel = userBookingList
            .where((element) => element.homestayName.compareTo(homestayName) == 0)
            .where((element) => formatDate.parse(element.checkIn).difference(DateTime.now()).inDays < 7)
            .first;
        return bookingModel;
      }
    }
  }

  @override
  Future checkInByRelative(String? email, String checkInOtp) async {
    if(email != null) {
      var user = await firebaseFirestoreService.findUserFireStore(email);
      if(user is AuthenticateModel) {
        final client = http.Client();
        final url = Uri.parse(checkInByRelativeUrl);
        final requestBody = {"bookingOtp" : checkInOtp};
        final response = await client.post(
            url,
            headers: {"content-type" : "application/json", "Authorization" : "Bearer ${user.accessToken}"},
            body: json.encode(requestBody)
        );
        if(response.statusCode == 200) {
          final bookingModelJson = json.decode(response.body);
          final bookingModel = BookingModel.fromJson(bookingModelJson);
          return bookingModel;
        } else {
          if(response.statusCode == 403) {
            await firebaseAuthService.forgetGoogleSignIn(email);
          }
          final errorHandlerModelJson = json.decode(response.body);
          final errorHandlerModel = ErrorHandlerModel.fromJson(errorHandlerModelJson);
          return errorHandlerModel;
        }
      }
    }
  }

  @override
  Future findBookingByOtp(String? email, String checkInOtp) async {
    if(email != null) {
      final user = await firebaseFirestoreService.findUserFireStore(email);
      if(user is AuthenticateModel) {
        final client = http.Client();
        final url = Uri.parse("$getBookingByOtpUrl/$checkInOtp");
        final response = await client.get(
            url,
            headers: {"content-type" : "application/json", "Authorization" : "Bearer ${user.accessToken}"}
        );
        if(response.statusCode == 200) {
          final bookingModelJson = json.decode(response.body);
          final bookingModel = BookingModel.fromJson(bookingModelJson);
          return bookingModel;
        } else {
          if(response.statusCode == 403) {
            await firebaseAuthService.forgetGoogleSignIn(email);
          }
          final errorHandlerModelJson = json.decode(response.body);
          final errorHandlerModel = ErrorHandlerModel.fromJson(errorHandlerModelJson);
          return errorHandlerModel;
        }
      }
    }
  }

  @override
  Future checkOut(String? email, int bookingId) async {
    final user = await firebaseFirestoreService.findUserFireStore(email!);
    if(user is AuthenticateModel) {
      final client = http.Client();
      final url = Uri.parse(checkOutUrl);
      final requestBody = {"bookingId" : bookingId};
      final response = await client.post(
          url,
          headers: {"content-type" : "application/json", "Authorization" : "Bearer ${user.accessToken}"},
          body: json.encode(requestBody)
      );
      if(response.statusCode == 200) {
        final bookingModelJson = json.decode(response.body);
        final bookingModel = BookingModel.fromJson(bookingModelJson);
        return bookingModel;
      } else {
        if(response.statusCode == 403) {
          await firebaseAuthService.forgetGoogleSignIn(email);
        }
        final errorHandlerModelJson = json.decode(response.body);
        final errorHandlerModel = ErrorHandlerModel.fromJson(errorHandlerModelJson);
        return errorHandlerModel;
      }
    }
  }

  @override
  Future cancelBooking(String? email, int bookingId) async {
    final user = await firebaseFirestoreService.findUserFireStore(email!);
    if(user is AuthenticateModel) {
      final client = http.Client();
      final url = Uri.parse("$cancelBookingUrl/$bookingId");
      final response = await client.patch(
        url,
        headers: {"content-type" : "application/json", "Authorization" : "Bearer ${user.accessToken}"},
      );
      if(response.statusCode == 200) {
        final bookingModelJson = json.decode(response.body);
        final bookingModel = BookingModel.fromJson(bookingModelJson);
        return bookingModel;
      } else {
        if(response.statusCode == 403) {
          await firebaseAuthService.forgetGoogleSignIn(email);
        }
        final errorHandlerModelJson = json.decode(response.body);
        final errorHandlerModel = ErrorHandlerModel.fromJson(errorHandlerModelJson);
        return errorHandlerModel;
      }
    }
  }

  @override
  Future findPassengerCancelBookingTicket(String? email, int bookingId) async {
    final user = await firebaseFirestoreService.findUserFireStore(email!);
    if(user is AuthenticateModel) {
      final client = http.Client();
      final url = Uri.parse("$getCancelBookingTicketUrl/$bookingId");
      final response = await client.get(
        url,
        headers: {"content-type" : "application/json", "Authorization" : "Bearer ${user.accessToken}"}
      );
      if(response.statusCode == 200) {
        final cancelBookingTicketModelJson = json.decode(response.body);
        final cancelBookingTicketModel = CancelBookingTicketModel.fromJson(cancelBookingTicketModelJson);
        return cancelBookingTicketModel;
      } else {
        if(response.statusCode == 403) {
          await firebaseAuthService.forgetGoogleSignIn(email);
        }
        final errorHandlerModelJson = json.decode(response.body);
        final errorHandlerModel = ErrorHandlerModel.fromJson(errorHandlerModelJson);
        return errorHandlerModel;
      }
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