import 'package:capstoneproject2/locator/service_locator.dart';
import 'package:capstoneproject2/model/error_handler_model.dart';
import 'package:capstoneproject2/services/auth_service.dart';
import 'package:capstoneproject2/services/firebase_auth_service.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServiceImpl extends IFirebaseAuthService {

  final _passengerService = locator.get<IPassengerService>();
  final _authService = locator.get<IAuthenticateService>();
  final _googleSignIn = GoogleSignIn();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<dynamic> getGoogleSignInAccount() async {
    final googleUser = await _googleSignIn.signIn();

    return googleUser;
  }



  @override
  Future forgetGoogleSignIn() async {
   await _googleSignIn.disconnect();
   await _firebaseAuth.signOut();
  }

  @override
  Future confirmBrandNewAccount(GoogleSignInAccount? googleSignInAccount) async {
    final isAccountBrandNew = await _passengerService.checkEmailExistOnSystem(googleSignInAccount?.email);
    // account đã tồn tại trên hệ thống
    if(isAccountBrandNew is ErrorHandlerModel) {
     await _authService.loginByGoogleAccount(googleSignInAccount);
    }
    _firebaseAuth.currentUser;

    return googleSignInAccount;
  }

}