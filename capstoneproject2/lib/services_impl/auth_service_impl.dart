import 'dart:convert';

import 'package:capstoneproject2/services/api_url_provider/api_url_provider.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_clound_firestore_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/auth_service.dart';
import 'package:capstoneproject2/services/model/auth_model.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;



class AuthenticateServiceImpl extends IAuthenticateService {

  final _loginUrl = "$USER_API_URL/login";

  final _fireStore = locator.get<ICloudFirestoreService>();

  final _fireAuth = FirebaseAuth.instance;

  final _googleSignIn = GoogleSignIn();

  @override
  Future<dynamic> loginBySwmAccount(AuthenticateModel authenticateModel) async {
    var client = http.Client();
    var uri = Uri.parse(_loginUrl);
    var response = await client.post(
        uri,
        headers: {"content-type" : "application/json"},
        body: json.encode(authenticateModel.toJson())
    ).timeout(const Duration(seconds: 5));
    var responseBody = json.decode(response.body);
    if(response.statusCode == 200) {
      var authenticateModel = AuthenticateModel.fromJson(responseBody);

      await _fireStore.createUserSignIn(authenticateModel).timeout(const Duration(seconds: 5));
      await _fireAuth.signInWithEmailAndPassword(email: authenticateModel.email, password: authenticateModel.password).timeout(const Duration(seconds: 5));
      return authenticateModel;
    } else {
      var errorHandlerModel = ErrorHandlerModel.fromJson(responseBody);
      return errorHandlerModel;
    }
  }

  @override
  Future loginByGoogleAccount(GoogleSignInAccount googleSignInAccount) async {
        final client = http.Client();
        final uri = Uri.parse(_loginUrl);
        final requestBody = {"userInfo" : googleSignInAccount.email, "password" : googleSignInAccount.id};
        final response = await client.post(
            uri,
            headers: {"content-type":"application/json"},
            body: json.encode(requestBody)
        );
        if(response.statusCode == 200) {
          var responseData = json.decode(response.body);
          AuthenticateModel authenticateModel = AuthenticateModel.fromJson(responseData);
          await _fireStore.createUserSignIn(authenticateModel);
          return authenticateModel;
        } else {
          var responseData = json.decode(response.body);
          ErrorHandlerModel errorHandlerModel = ErrorHandlerModel.fromJson(responseData);
          return errorHandlerModel;
        }
  }

  // @override
  // Future loginByGoogleAccount() async {
  //   final googleSignInAccount = await _googleSignIn.signIn();
  //   if(googleSignInAccount != null) {
  //     final client = http.Client();
  //     final uri = Uri.parse(_loginUrl);
  //     final requestBody = {"userInfo" : googleSignInAccount!.email, "password" : googleSignInAccount!.id};
  //     final response = await client.post(
  //         uri,
  //         headers: {"content-type":"application/json"},
  //         body: json.encode(requestBody)
  //     );
  //     if(response.statusCode == 200) {
  //       var responseData = json.decode(response.body);
  //       AuthenticateModel authenticateModel = AuthenticateModel.fromJson(responseData);
  //       await _fireStore.createUserSignIn(authenticateModel);
  //       final googleAuthenticate = await googleSignInAccount.authentication;
  //       final googleCredential = GoogleAuthProvider.credential(
  //           idToken: googleAuthenticate.idToken,
  //           accessToken: googleAuthenticate.accessToken
  //       );
  //       final userCredential = await _fireAuth.signInWithCredential(googleCredential);
  //       return userCredential;
  //     } else {
  //       var responseData = json.decode(response.body);
  //       ErrorHandlerModel errorHandlerModel = ErrorHandlerModel.fromJson(responseData);
  //       return errorHandlerModel;
  //     }
  //   }
  // }



}