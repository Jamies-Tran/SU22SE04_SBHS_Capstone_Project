import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticateByGoogleEvent {}

class RegisterWithGoogleEvent extends AuthenticateByGoogleEvent {
  RegisterWithGoogleEvent({this.googleSignInAccount});

  GoogleSignInAccount? googleSignInAccount;
}
