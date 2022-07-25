import 'package:google_sign_in/google_sign_in.dart';

abstract class IFirebaseAuthService {
  Future<dynamic> getGoogleSignInAccount();

  Future forgetGoogleSignIn();

}