import 'package:capstoneproject2/locator/service_locator.dart';
import 'package:capstoneproject2/model/passenger_model.dart';
import 'package:capstoneproject2/services/google_auth_service.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthServiceImpl extends IGoogleAuthService {
  GoogleAuthServiceImpl() {
    setup();
  }
  final _googleUserFireStore = FirebaseFirestore.instance.collection("google_user");

  final _pasengerService = locator.get<IPassengerService>();

  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<GoogleSignInAccount> signUpWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    await _googleUserFireStore.add({"email" : googleUser?.displayName, "email" : googleUser?.email});
    final authentication = await googleUser?.authentication;
    final googleCredential = GoogleAuthProvider.credential(
      idToken: authentication?.idToken,
      accessToken: authentication?.accessToken
    );
    await _firebaseAuth.signInWithCredential(googleCredential);

    return googleUser!;
  }

}