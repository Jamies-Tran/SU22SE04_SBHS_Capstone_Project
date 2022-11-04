import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticateByGoogleEvent {}

class ForwardCompleteGoogleRegisterScreenEvent
    extends AuthenticateByGoogleEvent {
  ForwardCompleteGoogleRegisterScreenEvent(
      {this.context, this.googleSignIn, this.googleSignInAccount});

  GoogleSignInAccount? googleSignInAccount;
  GoogleSignIn? googleSignIn;
  BuildContext? context;
}

class BackwardToRegisterScreenEvent extends AuthenticateByGoogleEvent {
  BackwardToRegisterScreenEvent({this.context});

  BuildContext? context;
}
