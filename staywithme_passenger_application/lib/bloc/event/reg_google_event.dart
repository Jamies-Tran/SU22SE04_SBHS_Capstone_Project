import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class CompleteGoogleRegisterEvent {}

class ForwardCompleteGoogleRegisterScreenEvent
    extends CompleteGoogleRegisterEvent {
  ForwardCompleteGoogleRegisterScreenEvent(
      {this.context, this.googleSignIn, this.googleSignInAccount});

  GoogleSignInAccount? googleSignInAccount;
  GoogleSignIn? googleSignIn;
  BuildContext? context;
}

class BackwardToRegisterScreenEvent extends CompleteGoogleRegisterEvent {
  BackwardToRegisterScreenEvent({this.context});

  BuildContext? context;
}

class CancelCompleteGoogleAccountRegisterEvent
    extends CompleteGoogleRegisterEvent {
  CancelCompleteGoogleAccountRegisterEvent(
      {this.context, this.googleSignIn, this.isChangeGoogleAccount});

  GoogleSignIn? googleSignIn;
  BuildContext? context;
  bool? isChangeGoogleAccount;
}

class CancelChooseAnotherGoogleAccountEvent
    extends CompleteGoogleRegisterEvent {
  CancelChooseAnotherGoogleAccountEvent({this.context});

  BuildContext? context;
}

class SubmitGoogleCompleteRegisterEvent extends CompleteGoogleRegisterEvent {
  SubmitGoogleCompleteRegisterEvent(
      {this.username,
      this.email,
      this.phone,
      this.address,
      this.gender,
      this.citizenIdentification,
      this.avatarUrl,
      this.dob});

  String? username;
  String? email;
  String? phone;
  String? address;
  String? gender;
  String? citizenIdentification;
  String? avatarUrl;
  String? dob;
}

class FocusTextFieldCompleteGoogleRegEvent extends CompleteGoogleRegisterEvent {
  FocusTextFieldCompleteGoogleRegEvent({this.isFocusOnTextField});

  bool? isFocusOnTextField;
}

class InputUsernameGoogleAuthEvent extends CompleteGoogleRegisterEvent {
  InputUsernameGoogleAuthEvent({this.username});

  String? username;
}

class ReceiveEmailGoogleAuthEvent extends CompleteGoogleRegisterEvent {
  ReceiveEmailGoogleAuthEvent({this.email});

  String? email;
}

class InputPhoneGoogleAuthEvent extends CompleteGoogleRegisterEvent {
  InputPhoneGoogleAuthEvent({this.phone});

  String? phone;
}

class InputAddressGoogleAuthEvent extends CompleteGoogleRegisterEvent {
  InputAddressGoogleAuthEvent({this.address});

  String? address;
}

class ChooseGenderGoogleAuthEvent extends CompleteGoogleRegisterEvent {
  ChooseGenderGoogleAuthEvent({this.gender});

  String? gender;
}

class InputCitizenIdentificationGoogleAuthEvent
    extends CompleteGoogleRegisterEvent {
  InputCitizenIdentificationGoogleAuthEvent({this.citizenIdentification});

  String? citizenIdentification;
}

class InputAvatarUrlGoogleAuthEvent extends CompleteGoogleRegisterEvent {
  InputAvatarUrlGoogleAuthEvent({this.avatarUrl});

  String? avatarUrl;
}

class InputDobGoogleAuthEvent extends CompleteGoogleRegisterEvent {
  InputDobGoogleAuthEvent({this.dob});

  String? dob;
}
