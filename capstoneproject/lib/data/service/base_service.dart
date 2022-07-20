import 'package:capstoneproject/api/app_client.dart';
import 'package:dio/dio.dart';

class BaseService {
  Future<Response> getCategory(String body) {
    return AppClient.instance.dio.post(
        '/ADInterface/services/rest/model_adservice/query_data',
        data: body);
  }
}
