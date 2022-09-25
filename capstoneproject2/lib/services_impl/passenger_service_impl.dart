import 'dart:convert';

import 'package:capstoneproject2/services/api_url_provider/api_url_provider.dart';
import 'package:capstoneproject2/services/auth_service.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_clound_firestore_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/auth_model.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/model/passenger_model.dart';
import 'package:capstoneproject2/services/model/wallet_model.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class PassengerServiceImpl extends IPassengerService {
  final _registerPassengerUrl = "$userApiUrl/register/passenger";

  final _getUserWalletUrl = "$userApiUrl/get/wallet/passenger_wallet";

  final _checkUserExistUrl = "$userApiUrl/exist";
  
  final _firebaseAuth = FirebaseAuth.instance;

  final _authService = locator.get<IAuthenticateService>();

  final _firebaseFirestore = locator.get<ICloudFirestoreService>();

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
  Future signUpWithGoogleAccount(PassengerModel passengerModel, GoogleSignInAccount googleSignInAccount) async {
    var client = http.Client();
    final password = googleSignInAccount!.id;
    passengerModel.password = password;
    final uri = Uri.parse(_registerPassengerUrl);
    final response = await client.post(
        uri,
        headers: {"content-type" : "application/json"},
        body: json.encode(passengerModel.toJson())
    ).timeout(const Duration(seconds: 20));
    if(response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      final passengerModel = PassengerModel.fromJson(responseBody);
      await _authService.loginByGoogleAccount(googleSignInAccount);
      return passengerModel;
    }else {
      var errorHandler = ErrorHandlerModel.fromJson(json.decode(response.body));
      return errorHandler;
    }
  }

  @override
  Future findUserByUsername(String username) async {
    var client = http.Client();
    final url = "$userApiUrl/get/$username";
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

  @override
  Future getUserWallet(String email) async {
    final user = await _firebaseFirestore.findUserFireStore(email);
    if(user is AuthenticateModel) {
      final client = http.Client();
      final url = Uri.parse(_getUserWalletUrl);
      final response = await client.get(
          url,
          headers: {"content-type":"application/json", "Authorization":"Bearer ${user.accessToken}"}
      ).timeout(const Duration(seconds: 20));
      final responseBody = json.decode(response.body);
      if(response.statusCode == 200) {
        final walletModel = WalletModel.fromJson(responseBody);
        return walletModel;
      } else {
        final errorHandler = ErrorHandlerModel.fromJson(responseBody);
        return errorHandler;
      }
    }
  }

}