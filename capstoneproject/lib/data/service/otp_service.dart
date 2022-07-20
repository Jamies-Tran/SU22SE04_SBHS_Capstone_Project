import 'package:capstoneproject/api/app_client.dart';
import 'package:dio/dio.dart';

class OTPService {
  final String tagCheckEmail = "/auth/check-phonenumber/";
  final String tagCheckPhone = "/auth/check-email/";
  final String tagSendOtp = "/otp";
  final String tagVerifyOtp = "/verify-otp";

  Future<Response> checkPhone(String phone) {
    return AppClient.instance.dio.get("$tagCheckEmail$phone");
  }

  Future<Response> checkEmail(String email) {
    return AppClient.instance.dio.get("$tagCheckPhone$email");
  }

  Future<Response> sendOtp({required String phone}) {
    return AppClient.instance.dio
        .post(tagSendOtp, data: {'phoneNumber': phone});
  }

  Future<Response> verifyOtp(String otp) {
    return AppClient.instance.dio.post(tagVerifyOtp, data: {'otp': otp});
  }
}
