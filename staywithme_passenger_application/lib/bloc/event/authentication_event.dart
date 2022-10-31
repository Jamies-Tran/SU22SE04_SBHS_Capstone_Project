import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationEvent {}

class InputUsernameEvent extends AuthenticationEvent {
  InputUsernameEvent({this.username});

  String? username;
}

class InputPasswordEvent extends AuthenticationEvent {
  InputPasswordEvent({this.password});

  String? password;
}

class InputEmailEvent extends AuthenticationEvent {
  InputEmailEvent({this.email});

  String? email;
}

class InputAddressEvent extends AuthenticationEvent {
  InputAddressEvent({this.address});

  String? address;
}

class InputPhoneEvent extends AuthenticationEvent {
  InputPhoneEvent({this.phone});

  String? phone;
}

class InputGenderEvent extends AuthenticationEvent {
  InputGenderEvent({this.gender});

  String? gender;
}

class InputCitizenIdentificationEvent extends AuthenticationEvent {
  InputCitizenIdentificationEvent({this.citizenIdentification});

  String? citizenIdentification;
}

class InputDobEvent extends AuthenticationEvent {
  InputDobEvent({this.dob});

  String? dob;
}

class InputAvatarUrlEvent extends AuthenticationEvent {
  InputAvatarUrlEvent({this.avatarUrl});

  String? avatarUrl;
}

class ChooseGoogleAccountEvent extends AuthenticationEvent {
  ChooseGoogleAccountEvent({this.context});

  BuildContext? context;
}

class CancelChooseGoogleAccountEvent extends AuthenticationEvent {
  CancelChooseGoogleAccountEvent({this.context});

  BuildContext? context;
}

class CancelCompleteGoogleAccountRegisterEvent extends AuthenticationEvent {
  CancelCompleteGoogleAccountRegisterEvent({this.context, this.googleSignIn});

  GoogleSignIn? googleSignIn;
  BuildContext? context;
}

class NavigateToCompleteGoogelRegisterAccountEvent extends AuthenticationEvent {
  NavigateToCompleteGoogelRegisterAccountEvent(
      {this.context, this.googleSignIn, this.googleSignInAccount});

  BuildContext? context;
  GoogleSignIn? googleSignIn;
  GoogleSignInAccount? googleSignInAccount;
}

class SubmitRegisterAccountEvent extends AuthenticationEvent {
  SubmitRegisterAccountEvent(
      {this.username,
      this.password,
      this.email,
      this.address,
      this.phone,
      this.gender,
      this.citizenIdentification,
      this.dob,
      this.avatarUrl});

  String? username;
  String? password;
  String? email;
  String? address;
  String? phone;
  String? gender;
  String? citizenIdentification;
  String? dob;
  String? avatarUrl;
}
