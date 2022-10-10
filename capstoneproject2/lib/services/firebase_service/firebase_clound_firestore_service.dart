import 'package:capstoneproject2/services/model/auth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class ICloudFirestoreService {
  //Future createGoogleSignIn(GoogleSignInAccount? googleSignInAccount, String accessToken);

  Future createUserSignIn(AuthenticateModel authenticateModel);

  Future findUserFireStore(String email);

  Future deleteUserWhenSignOut(String email);

  Future saveUserCurrentLocation(String latLng);

  Future getUserCurrentLocation(String latLng);
}