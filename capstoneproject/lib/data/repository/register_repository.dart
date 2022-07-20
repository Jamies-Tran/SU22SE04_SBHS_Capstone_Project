import 'dart:async';

import 'package:capstoneproject/api/model/data_repsonse.dart';
import 'package:capstoneproject/api/model/gender_response.dart';
import 'package:capstoneproject/api/model/reponse_existed.dart';
import 'package:capstoneproject/common/define_field.dart';
import 'package:capstoneproject/data/service/login_service.dart';
import 'package:capstoneproject/data/service/register_service.dart';
import 'package:capstoneproject/shared_code/model/user_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class RegisterRepository {
  RegisterRepository({required RegisterService registerService})
      : _registerService = registerService;

  final RegisterService _registerService;

  Future<DataResponse> register({
    required Map<String, dynamic> data
  }) async {
    final c = Completer<DataResponse>();
    try {
      final response = await _registerService.register(data: data);
      final result = DataResponse.fromJson(response.data);
      c.complete(result);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        c.completeError('Connect Timeout');
      }
      c.complete(DataResponse.fromJson(e.response!.data));
    } catch (ex) {
      c.completeError(ex.toString());
    }
    return c.future;
  }

  Future<GenderResponse> getGender() async{
    final c = Completer<GenderResponse>();
    try{
      final response = await _registerService.getGender();
      final result = GenderResponse.fromJson(response.data);
      c.complete(result);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        c.completeError('Connect Timeout');
      }
      c.complete(GenderResponse.fromJson(e.response!.data));
    } catch (ex) {
      c.completeError(ex.toString());
    }
    return c.future;
  }
}
