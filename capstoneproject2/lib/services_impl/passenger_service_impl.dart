import 'dart:convert';

import 'package:capstoneproject2/model/error_handler_model.dart';
import 'package:capstoneproject2/model/passenger_model.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:http/http.dart' as http;

class PassengerServiceImpl extends IPassengerService {
  final registerPassengerUrl = "$baseUserUrl/register/passenger";

  @override
  Future<dynamic> registerPassenger(PassengerModel passengerModel) async {
    var client = http.Client();
    Uri registerPassengerUri = Uri.parse(registerPassengerUrl);
    var response = await client.post(
        registerPassengerUri,
        headers: {"content-type" : "application/json"},
        body: json.encode(passengerModel.toJson())
    );
    Map<String, dynamic> responseBody = json.decode(response.body);
    if(response.statusCode == 201) {
      PassengerModel passengerResponseModel = PassengerModel.fromJson(responseBody);
      return passengerResponseModel;
    } else {
      ErrorHandlerModel errorHandlerResponseModel = ErrorHandlerModel.fromJson(responseBody);
      return errorHandlerResponseModel;
    }
  }

}