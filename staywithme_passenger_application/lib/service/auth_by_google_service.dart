import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class IAuthenticateByGoogleService {
  Future<dynamic> authenticateByGoogle(GoogleSignInAccount googleSignInAccount);

  Future<dynamic> signOut(GoogleSignIn googleSignIn);
}

class AuthenticateByGoogleService extends IAuthenticateByGoogleService {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future authenticateByGoogle(GoogleSignInAccount googleSignInAccount) async {
    final googleAuthentication = await googleSignInAccount.authentication;
    final googleCredential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken);
    final signInWithGoogle =
        await _firebaseAuth.signInWithCredential(googleCredential);

    return signInWithGoogle;
  }

  @override
  Future signOut(GoogleSignIn googleSignIn) async {
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
