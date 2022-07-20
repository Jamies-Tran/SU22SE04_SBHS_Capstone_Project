import 'package:capstoneproject/api/app_client.dart';
import 'package:dio/dio.dart';

class ForgotPasswordService {
  final String tagResetPassword = "/auth/reset-password-by-phonenumber";

  Future<Response> resetPassword(Map<String, dynamic> data) {
    return AppClient.instance.dio.put(tagResetPassword, data: data);
  }
}
