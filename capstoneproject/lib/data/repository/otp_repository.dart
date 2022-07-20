import 'dart:async';

import 'package:capstoneproject/api/model/reponse_existed.dart';
import 'package:dio/dio.dart';

import '../service/otp_service.dart';

class OTPRepository {
  final OTPService otpService;

  OTPRepository({required this.otpService});

  Future<ApiResponse> checkPhone(String phone) async {
    var c = Completer<ApiResponse>();

    try {
      final response = await otpService.checkPhone(phone);
      c.complete(ApiResponse.fromJson(response.data));
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        c.completeError("Kết nối bị hết hạn");
      }
      c.completeError(ApiResponse.fromJson(e.response!.data));
    } catch (ex) {
      c.completeError(ex.toString());
    }

    return c.future;
  }

  Future<ApiResponse> checkEmail(String email) async {
    var c = Completer<ApiResponse>();

    try {
      final response = await otpService.checkEmail(email);
      c.complete(ApiResponse.fromJson(response.data));
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        c.completeError("Kết nối bị hết hạn");
      }
      c.completeError(ApiResponse.fromJson(e.response!.data));
    } catch (ex) {
      c.completeError(ex.toString());
    }
    return c.future;
  }

  Future<ApiResponse> sendOtp(String phone) async {
    var c = Completer<ApiResponse>();

    try {
      final response = await otpService.sendOtp(phone: phone);
      c.complete(ApiResponse.fromJson(response.data));
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        c.completeError("Kết nối bị hết hạn");
      }
      c.completeError(ApiResponse.fromJson(e.response!.data));
    } catch (ex) {
      c.completeError(ex.toString());
    }

    return c.future;
  }

  Future<ApiResponse> verifyOtp(String otp) async {
    var c = Completer<ApiResponse>();

    try {
      final response = await otpService.verifyOtp(otp);
      c.complete(ApiResponse.fromJson(response.data));
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        c.completeError("Kết nối bị hết hạn");
      }
      c.completeError(ApiResponse.fromJson(e.response!.data));
    } catch (ex) {
      c.completeError(ex.toString());
    }

    return c.future;
  }
}
