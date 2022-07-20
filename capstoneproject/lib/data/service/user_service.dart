import 'package:capstoneproject/api/app_client.dart';
import 'package:dio/dio.dart';

class UserService {
  final String tagGender = "/user/sex";
  final String tagUpdateAvatar = "/user/update-avatar";
  final String tagGetUser = "/user/info";
  final String tagUpdateUser = "/user/update";

  Future<Response> getGenders() async {
    return AppClient.instance.dio.get(tagGender);
  }

  Future<Response> updateAvatar(String path) async{
    var data = FormData.fromMap({
      'newAvatar': await MultipartFile.fromFile(path, filename: 'avatar.png'),
    });
    return AppClientCookie.instance.dio.put(tagUpdateAvatar, data: data );
  }
  
  Future<Response> getUserInfo() async {
    return AppClientCookie.instance.dio.get(tagGetUser);
  }

  Future<Response> updateUser(Map<String, dynamic> data) async {
    return AppClientCookie.instance.dio.put(tagUpdateUser, data: data);
  }
}