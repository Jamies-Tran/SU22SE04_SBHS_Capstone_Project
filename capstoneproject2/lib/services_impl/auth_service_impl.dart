import 'dart:convert';

import 'package:capstoneproject2/model/auth_model.dart';
import 'package:capstoneproject2/model/error_handler_model.dart';
import 'package:capstoneproject2/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthenticateServiceImpl extends IAuthenticateService {

  final loginUrl = "$baseUserUrl/login";
  
  final _fireStore = FirebaseFirestore.instance.collection("user");

  final _fireAuth = FirebaseAuth.instance;

  @override
  Future<dynamic> loginBySwmAccount(AuthenticateModel authenticateModel) async {
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
      _fireStore.add({"email" : authenticateModel.userInfo, "loginDate" : authenticateModel.loginDate, "token" : authenticateModel.jwtToken});
      _fireAuth.signInWithEmailAndPassword(email: authenticateModel.userInfo, password: authenticateModel.password);
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
    AuthenticateModel authenticateModel = AuthenticateModel(userInfo: getUserInfo, password: getPassword);
    final uri = Uri.parse(loginUrl);
    var response = await client.post(
        uri,
        headers: {"content-type" : "application/json"},
        body: json.encode(authenticateModel.toJson())
    );
    if(response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final authenticateModel =  AuthenticateModel.fromJson(responseBody);
      _fireStore.add({"email" : authenticateModel.userInfo, "loginDate" : authenticateModel.loginDate, "token" : authenticateModel.jwtToken});
      final googleAuth = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth?.accessToken,
        idToken: googleSignInAuth?.idToken
      );
      await _fireAuth.signInWithCredential(googleAuth);
      return authenticateModel;
    } else {
      final responseBody = json.decode(response.body);
      final errorHandlerModel = ErrorHandlerModel.fromJson(responseBody);
      return errorHandlerModel;
    }

  }

}