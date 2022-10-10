import 'dart:convert';
import 'dart:math';

import 'package:capstoneproject2/services/firebase_service/firebase_clound_firestore_service.dart';
import 'package:capstoneproject2/services/model/auth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CloudFireStoreServiceImpl extends ICloudFirestoreService {
  // final _googleUserCollection = FirebaseFirestore.instance.collection("google_user");
  final systemUserCollection = FirebaseFirestore.instance.collection("system_user");
  final userLocationCollection = FirebaseFirestore.instance.collection("user_location");
  final firebaseAuth = FirebaseAuth.instance;


  @override
  Future createUserSignIn(AuthenticateModel authenticateModel) async {
    await systemUserCollection.add({
      "username" : authenticateModel.username,
      "email" : authenticateModel.email,
      "loginDate" : authenticateModel.loginDate,
      "accessToken" : authenticateModel.accessToken,
      "photoUrl" : authenticateModel.avatarUrl ?? "/assets/images/passenger-default.png"
    }).timeout(const Duration(seconds: 20));
  }

  @override
  Future findUserFireStore(String email) async {
    final result = await systemUserCollection.where("email", isEqualTo: email).get();
    if(result.docs.isNotEmpty) {
      AuthenticateModel authenticateModel = AuthenticateModel(
          username: result.docs[0].data()["username"],
          email: result.docs[0].data()["email"],
          loginDate: result.docs[0].data()["loginDate"],
          accessToken: result.docs[0].data()["accessToken"],
          avatarUrl: result.docs[0].data()["photoUrl"]
      );
      return authenticateModel;
    }

    return null;
  }

  @override
  Future deleteUserWhenSignOut(String email) async {
    final result = await systemUserCollection.where("email", isEqualTo: email).get().timeout(const Duration(seconds: 20));
    for (var element in result.docs) {
      element.reference.delete();
    }
  }

  @override
  Future saveUserCurrentLocation(String latLng) async {
    await userLocationCollection.add({
      "latLng" : latLng
    });
  }

  @override
  Future getUserCurrentLocation(String latLng) async {
    final result = await userLocationCollection.where("latLng", isEqualTo: latLng).get();
    if(result.docs.isNotEmpty) {
      return result.docs[0].data()["latLng"];
    }
  }

}