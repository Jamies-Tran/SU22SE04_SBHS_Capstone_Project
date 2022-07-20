import 'dart:async';

import 'package:capstoneproject/api/model/reponse_existed.dart';
import 'package:capstoneproject/data/service/forgot_password_service.dart';
import 'package:dio/dio.dart';

class ForgotPasswordRepository{
  ForgotPasswordRepository({required this.forgotPasswordService});
  final ForgotPasswordService forgotPasswordService ;

  Future<ApiResponse> resetPassword(Map<String, dynamic> data) async {
    var c = Completer<ApiResponse>();

    try {
      final response = await forgotPasswordService.resetPassword(data);
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