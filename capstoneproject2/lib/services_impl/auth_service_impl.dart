import 'dart:convert';

import 'package:capstoneproject2/model/auth_model.dart';
import 'package:capstoneproject2/model/error_handler_model.dart';
import 'package:capstoneproject2/services/auth_service.dart';
import 'package:http/http.dart' as http;

class AuthenticateServiceImpl extends IAuthenticateService {

  final loginUrl = "$baseUserUrl/login";

  @override
  Future<dynamic> login(AuthenticateModel authenticateModel) async {
    var client = http.Client();
    var uri = Uri.parse(loginUrl);
    var response = await client.post(
        uri,
        headers: {"content-type" : "application/json"},
        body: json.encode(authenticateModel.toJson())
    );
    var responseBody = json.decode(response.body);
    if(response.statusCode == 200) {
      var authenticateModel = AuthenticateModel.fromJson(responseBody);
      return authenticateModel;
    } else {
      var errorHandlerModel = ErrorHandlerModel.fromJson(responseBody);
      return errorHandlerModel;
    }
  }

}