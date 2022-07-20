import 'dart:async';

import 'package:capstoneproject/data/service/sign_up_service.dart';
import 'package:capstoneproject/shared_code/model/user_register.dart';
import 'package:capstoneproject/shared_code/model/user_send.dart';
import 'package:dio/dio.dart';

class SignUpRepository {
  SignUpRepository({required SignUpService signUpService})
      : _signUpService = signUpService;

  final SignUpService _signUpService;

  Future<UserRegister> signUp({required UserSend userSend}) async {
    final c = Completer<UserRegister>();
    try {
      final response = await _signUpService.signUpService(userSend: userSend);
      final result = UserRegister.fromJson(response.data);
      c.complete(result);
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
