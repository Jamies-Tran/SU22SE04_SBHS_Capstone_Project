import 'dart:convert';

import 'package:capstoneproject2/services/api_url_provider/api_url_provider.dart';
import 'package:capstoneproject2/services/auth_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/model/passenger_model.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class PassengerServiceImpl extends IPassengerService {
  final _registerPassengerUrl = "$USER_API_URL/register/passenger";

  final _checkUserExistUrl = "$USER_API_URL/exist";
  
  final _firebaseAuth = FirebaseAuth.instance;

  final _authService = locator.get<IAuthenticateService>();

  @override
  Future<dynamic> completeGoogleSignUpPassenger(PassengerModel passengerModel, GoogleSignInAccount? googleSignInAccount) async {
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
    final response = await http.get(uri, headers: {"content-type" : "application/json"}).timeout(const Duration(seconds: 5));
    if(response.statusCode == 200) {
      return true;
    } else {
      final responseBody = json.decode(response.body);
      final errorHandlerModel = ErrorHandlerModel.fromJson(responseBody);
      return errorHandlerModel;
    }
  }

  @override
  Future signUpWithSWMAccount(PassengerModel passengerModel) async {
    var client = http.Client();
    final uri = Uri.parse(_registerPassengerUrl);
    final response = await client.post(
        uri,
        headers: {"content-type" : "application/json"},
        body: json.encode(passengerModel.toJson())
    );
    if(response.statusCode == 201) {
      var responseBody = PassengerModel.fromJson(json.decode(response.body));
      await _firebaseAuth.createUserWithEmailAndPassword(email: passengerModel.email, password: passengerModel.password);
      return responseBody;
    }else {
      var errorHandler = ErrorHandlerModel.fromJson(json.decode(response.body));
      return errorHandler;
    }
  }

  @override
  Future signUpWithGoogleAccount(PassengerModel passengerModel, GoogleSignInAccount? googleSignInAccount) async {
    var client = http.Client();
    final password = "${googleSignInAccount?.id}";
    passengerModel.password = password;
    final uri = Uri.parse(_registerPassengerUrl);
    final response = await client.post(
        uri,
        headers: {"content-type" : "application/json"},
        body: json.encode(passengerModel.toJson())
    );
    if(response.statusCode == 201) {
      var responseBody = PassengerModel.fromJson(json.decode(response.body));
      // final credential = GoogleAuthProvider.credential(
      //   idToken: googleSignInAuth?.idToken,
      //   accessToken: googleSignInAuth?.accessToken
      // );
      // _firebaseAuth.signInWithCredential(credential);
      var authResult = await _authService.loginByGoogleAccount(googleSignInAccount);
      if(authResult is ErrorHandlerModel) {
        return authResult;
      }
      return responseBody;
    }else {
      var errorHandler = ErrorHandlerModel.fromJson(json.decode(response.body));
      return errorHandler;
    }
  }

  @override
  Future findUserByUsername(String username) async {
    var client = http.Client();
    final url = "$USER_API_URL/get/$username";
    final uri = Uri.parse(url);
    final response = await client.get(uri, headers: {"content-type" : "application/json"});
    if(response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final passengerModel = PassengerModel.fromJson(responseBody);
      return passengerModel;
    } else {
      final responseBody = json.decode(response.body);
      final errorHandlerModel = ErrorHandlerModel.fromJson(responseBody);
      return errorHandlerModel;
    }
  }

}