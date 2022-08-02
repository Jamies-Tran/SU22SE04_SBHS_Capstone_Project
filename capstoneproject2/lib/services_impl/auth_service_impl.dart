import 'dart:convert';

import 'package:capstoneproject2/services/api_url_provider/api_url_provider.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_clound_firestore_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/auth_service.dart';
import 'package:capstoneproject2/services/model/auth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;



class AuthenticateServiceImpl extends IAuthenticateService {

  final loginUrl = "$USER_API_URL/login";
  
  final _fireStore = locator.get<ICloudFirestoreService>();

  final _fireAuth = FirebaseAuth.instance;

  @override
  Future<dynamic> loginBySwmAccount(AuthenticateModel authenticateModel) async {
    var client = http.Client();
    var uri = Uri.parse(loginUrl);
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
  Future loginByGoogleAccount(GoogleSignInAccount? googleSignInAccount) async {
    final client = http.Client();
    final googleSignInAuth = await googleSignInAccount?.authentication;
    final getPassword = "${googleSignInAccount?.id}";
    final getUserInfo = googleSignInAccount?.email;
    AuthenticateModel authenticateModel = AuthenticateModel(email: getUserInfo, password: getPassword);
    final uri = Uri.parse(loginUrl);
    var response = await client.post(
        uri,
        headers: {"content-type" : "application/json"},
        body: json.encode(authenticateModel.toJson())
    ).timeout(const Duration(seconds: 5));
    if(response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final authenticateModel =  AuthenticateModel.fromJson(responseBody);
      authenticateModel.avatarUrl = googleSignInAccount?.photoUrl;
      //await _fireStore.createGoogleSignIn(googleSignInAccount, authenticateModel.accessToken);
      await _fireStore.createUserSignIn(authenticateModel);
      final googleAuth = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth?.accessToken,
        idToken: googleSignInAuth?.idToken
      );
      await _fireAuth.signInWithCredential(googleAuth).timeout(const Duration(seconds: 5));
      return authenticateModel;
    } else {
      final responseBody = json.decode(response.body);
      final errorHandlerModel = ErrorHandlerModel.fromJson(responseBody);
      return errorHandlerModel;
    }

  }

}