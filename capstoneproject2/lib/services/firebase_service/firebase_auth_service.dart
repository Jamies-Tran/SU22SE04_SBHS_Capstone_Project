import 'package:google_sign_in/google_sign_in.dart';

abstract class IFirebaseAuthenticateService {
  // Future<dynamic> getGoogleSignInAccount();
  Future forgetGoogleSignIn(String? email);

}