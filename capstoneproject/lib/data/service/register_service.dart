import 'package:capstoneproject/api/app_client.dart';
import 'package:dio/dio.dart';

class RegisterService {
  final String tagRegister = "user/register/passenger";
  // final String tagGender = "/user/sex";
  Future<Response> register({required Map<String, dynamic> data}) async {
    print('DX:$data');
    return AppClient.instance.dio.post(tagRegister, data: data);
  }

  // Future<Response> getGender() async {
  //   return AppClient.instance.dio.get(tagGender);
  // }
}
