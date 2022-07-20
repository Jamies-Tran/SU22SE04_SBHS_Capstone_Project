import 'dart:async';

import 'package:capstoneproject/common/define_field.dart';
import 'package:capstoneproject/data/service/login_service.dart';
import 'package:capstoneproject/data/service/register_service.dart';
import 'package:capstoneproject/data/service/user_service.dart';
import 'package:capstoneproject/shared_code/model/user_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class UserRepository {
  UserRepository({required UserService userService})
      : _userService = userService;

  final UserService _userService;

  Future<UserResponse> getGenders() async {
    final c = Completer<UserResponse>();
    try {
      final response = await _userService.getGenders();
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

  Future<UserResponse> updateAvatar(String path) async {
    final c = Completer<UserResponse>();
    try{
      final response = await _userService.updateAvatar(path);
      final result = UserResponse.fromJson(response.data);
      c.complete(result);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        c.completeError('Connect Timeout');
      }
      c.complete(UserResponse.fromJson(e.response!.data));
    } catch (ex) {
      c.completeError(ex.toString());
    }
    return c.future;
  }

  Future<UserResponse> getUserInfo() async {
    final c = Completer<UserResponse>();

    try{
      final response = await _userService.getUserInfo();
      final result = UserResponse.fromJson(response.data);
      c.complete(result);
    }on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        c.completeError('Connect Timeout');
      }
      c.complete(UserResponse.fromJson(e.response!.data));
    } catch (ex) {
      c.completeError(ex.toString());
    }
    return c.future;
  }

  Future<UserResponse> updateUser(Map<String, dynamic> data) async {
    final c = Completer<UserResponse>();

    try{
      final response = await _userService.updateUser(data);
      final result = UserResponse.fromJson(response.data);
      c.complete(result);
    }on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        c.completeError('Connect Timeout');
      }
      c.complete(UserResponse.fromJson(e.response!.data));
    } catch (ex) {
      c.completeError(ex.toString());
    }
    return c.future;
  }
}
