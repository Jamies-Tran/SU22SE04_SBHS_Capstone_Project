import 'package:capstoneproject2/services/firebase_service/firebase_clound_firestore_service.dart';
import 'package:capstoneproject2/services/model/auth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CloudFireStoreServiceImpl extends ICloudFirestoreService {
  // final _googleUserCollection = FirebaseFirestore.instance.collection("google_user");
  final _systemUserCollection = FirebaseFirestore.instance.collection("system_user");


  @override
  Future createUserSignIn(AuthenticateModel authenticateModel) async {
    await _systemUserCollection.add({
      "username" : authenticateModel.username,
      "email" : authenticateModel.email,
      "loginDate" : authenticateModel.loginDate,
      "accessToken" : authenticateModel.accessToken,
      "photoUrl" : authenticateModel.avatarUrl ?? "/assets/images/passenger-default.png"
    }).timeout(const Duration(seconds: 5));
  }

  @override
  Future findUserFireStore(String username) async {
    final result = await _systemUserCollection.where("username", isEqualTo: username).get().timeout(const Duration(seconds: 20));
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
  Future deleteUserWhenSignOut(String username) async {
    final result = await _systemUserCollection.where("username", isEqualTo: username).get().timeout(const Duration(seconds: 20));
    result.docs.forEach((element) {
      element.reference.delete();
    });
  }

}