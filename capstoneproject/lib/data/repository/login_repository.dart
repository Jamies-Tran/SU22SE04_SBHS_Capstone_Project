import 'dart:async';

import 'package:capstoneproject/common/define_field.dart';
import 'package:capstoneproject/data/service/login_service.dart';
import 'package:capstoneproject/shared_code/model/user_response.dart';
import 'package:dio/dio.dart';

class LoginRepository {
  LoginRepository({required LoginService loginService})
      : _loginService = loginService;

  final LoginService _loginService;

  Future<UserResponse> login(
      {required String username, required String password}) async {
    final c = Completer<UserResponse>();
    try {
      final response = await _loginService.loginService(
          username: username, password: password);
      final data = UserResponse.fromJson(response.data);
      c.complete(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        c.completeError('Connect Timeout');
      }
      c.completeError(e.toString());
    } catch (ex) {
      c.completeError(ex.toString());
    }
    return c.future;
  }
}
