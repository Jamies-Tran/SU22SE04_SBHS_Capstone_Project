import 'dart:io';

import 'package:capstoneproject/data/shared_preferences/shared_preferences.dart';
import 'package:capstoneproject/module/splash_screen/splash_screen.dart';
import 'package:capstoneproject/utils/materials/constant.dart';
import 'package:dio/dio.dart';
import '../hive/hive_service.dart';
import '../injection/injection.dart';

class AppClient {

  static final BaseOptions _options = BaseOptions(
    baseUrl: "https://airj18.skqist225.xyz/api",
    // connectTimeout: 10000,
    // receiveTimeout: 3000,
    responseType: ResponseType.json,
    // // contentType: 'application/xml',
    // headers: {'content-Type': 'application/json'},
  );
  static final Dio _dio = Dio(_options);
  AppClient._internal() {
    _dio.interceptors.add(LogInterceptor(requestBody: true));
  }
  static final AppClient instance = AppClient._internal();
  Dio get dio => _dio;
}

class AppClientCookie {

  static BaseOptions _options = BaseOptions(
    baseUrl: "https://airj18.skqist225.xyz/api",
    // connectTimeout: 10000,
    // receiveTimeout: 3000,
    responseType: ResponseType.json,
    // // contentType: 'application/xml',
    // headers: {'content-Type': 'application/json'},
    headers: {
      'Cookie': getIt<HiveService>().token,
    },
  );
  static Dio _dio = Dio(_options);
  AppClientCookie._internal() {
    _dio.interceptors.add(LogInterceptor(requestBody: true));
  }
  static AppClient instance = AppClient._internal();
  Dio get dio => _dio;
}
