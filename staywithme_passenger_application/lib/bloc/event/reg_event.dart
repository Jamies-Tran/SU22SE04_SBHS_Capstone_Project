import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class RegisterEvent {}

class InputUsernameEvent extends RegisterEvent {
  InputUsernameEvent({this.username});

  String? username;
}

class InputPasswordEvent extends RegisterEvent {
  InputPasswordEvent({this.password});

  String? password;
}

class InputEmailEvent extends RegisterEvent {
  InputEmailEvent({this.email});

  String? email;
}

class InputAddressEvent extends RegisterEvent {
  InputAddressEvent({this.address});

  String? address;
}

class InputPhoneEvent extends RegisterEvent {
  InputPhoneEvent({this.phone});

  String? phone;
}

class ChooseGenderEvent extends RegisterEvent {
  ChooseGenderEvent({this.gender});

  String? gender;
}

class InputCitizenIdentificationEvent extends RegisterEvent {
  InputCitizenIdentificationEvent({this.citizenIdentification});

  String? citizenIdentification;
}

class InputDobEvent extends RegisterEvent {
  InputDobEvent({this.dob});

  String? dob;
}

class InputAvatarUrlEvent extends RegisterEvent {
  InputAvatarUrlEvent({this.avatarUrl});

  String? avatarUrl;
}

class FocusTextFieldRegisterEvent extends RegisterEvent {
  FocusTextFieldRegisterEvent({this.isFocus});

  bool? isFocus;
}

class ChooseGoogleAccountEvent extends RegisterEvent {
  ChooseGoogleAccountEvent({this.context});

  BuildContext? context;
}

class ValidateGoogleAccountEvent extends RegisterEvent {
  ValidateGoogleAccountEvent(
      {this.googleSignIn, this.googleSignInAccount, this.context});

  GoogleSignInAccount? googleSignInAccount;
  GoogleSignIn? googleSignIn;
  BuildContext? context;
}

class NavigateToCompleteGoogelRegScreenEvent extends RegisterEvent {
  NavigateToCompleteGoogelRegScreenEvent(
      {this.context, this.googleSignIn, this.googleSignInAccount});

  BuildContext? context;
  GoogleSignIn? googleSignIn;
  GoogleSignInAccount? googleSignInAccount;
}

class SubmitRegisterAccountEvent extends RegisterEvent {
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
