import 'dart:convert';

import 'package:capstoneproject2/model/error_handler_model.dart';
import 'package:capstoneproject2/model/passenger_model.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class PassengerServiceImpl extends IPassengerService {
  final _registerPassengerUrl = "$baseUserUrl/register/passenger";

  final _checkUserExistUrl = "$baseUserUrl/exist";
  
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<dynamic> completeGoogleSignInPassenger(PassengerModel passengerModel, GoogleSignInAccount? googleSignInAccount) async {
    var client = http.Client();
    Uri registerPassengerUri = Uri.parse(_registerPassengerUrl);
    var response = await client.post(
        registerPassengerUri,
        headers: {"content-type" : "application/json"},
        body: json.encode(passengerModel.toJson())
    );
    Map<String, dynamic> responseBody = json.decode(response.body);
    if(response.statusCode == 201) {
      final authentication = await googleSignInAccount?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: authentication?.accessToken,
        idToken: authentication?.idToken
      );
      _firebaseAuth.signInWithCredential(credential);
      PassengerModel passengerResponseModel = PassengerModel.fromJson(responseBody);
      return passengerResponseModel;
    } else {
      ErrorHandlerModel errorHandlerResponseModel = ErrorHandlerModel.fromJson(responseBody);
      return errorHandlerResponseModel;
    }
  }

  @override
  Future checkEmailExistOnSystem(String? email) async {
    final actualCheckUserExistUrl = "$_checkUserExistUrl/$email";
    final uri = Uri.parse(actualCheckUserExistUrl);
    final response = await http.get(uri, headers: {"content-type" : "application/json"});
    print("Response status code: ${response.statusCode}");
    if(response.statusCode == 200) {
      return true;
    } else {
      final responseBody = json.decode(response.body);
      final errorHandlerModel = ErrorHandlerModel.fromJson(responseBody);
      return errorHandlerModel;
    }
  }

}