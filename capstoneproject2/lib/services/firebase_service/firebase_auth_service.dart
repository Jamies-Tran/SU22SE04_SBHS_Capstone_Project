import 'package:google_sign_in/google_sign_in.dart';

abstract class IFirebaseAuthenticateService {
  Future<dynamic> getGoogleSignInAccount();

  Future<dynamic> confirmBrandNewAccount(GoogleSignInAccount? googleSignInAccount);

  Future forgetGoogleSignIn();

}