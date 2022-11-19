import 'dart:async';
import 'package:flutter/material.dart';
import 'package:staywithme_passenger_application/bloc/event/reg_event.dart';
import 'package:staywithme_passenger_application/bloc/state/reg_state.dart';
import 'package:staywithme_passenger_application/screen/authenticate/complete_google_reg_screen.dart';
import 'package:staywithme_passenger_application/screen/authenticate/register_screen.dart';

class RegisterBloc {
  final eventController = StreamController<RegisterEvent>();

  final stateController = StreamController<RegisterState>();

  String? _username;
  String? _password;
  String? _email;
  String? _address;
  String? _citizenIdentification;
  String? _dob;
  String? _gender;
  String? _phone;
  String? _avatarUrl;
  bool? _isFocusOnTextField = false;
  final genderSelection = ["Male", "Female"];

  final initData = RegisterState(
      username: null,
      address: null,
      avatarUrl: null,
      citizenIdentification: null,
      dob: null,
      email: null,
      gender: "Male",
      password: null,
      phone: null,
      isFocusOnTextField: false);

  RegisterBloc() {
    eventController.stream.listen((event) {
      eventHandler(event);
    });
  }

  void eventHandler(RegisterEvent event) {
    if (event is InputUsernameEvent) {
      _username = event.username;
    } else if (event is InputPasswordEvent) {
      _password = event.password;
    } else if (event is InputEmailEvent) {
      _email = event.email;
    } else if (event is InputAddressEvent) {
      _address = event.address;
    } else if (event is InputCitizenIdentificationEvent) {
      _citizenIdentification = event.citizenIdentification;
    } else if (event is InputDobEvent) {
      _dob = event.dob;
    } else if (event is ChooseGenderEvent) {
      _gender = event.gender;
    } else if (event is InputPhoneEvent) {
      _phone = event.phone;
    } else if (event is InputAvatarUrlEvent) {
      _avatarUrl = event.avatarUrl;
    } else if (event is FocusTextFieldRegisterEvent) {
      _isFocusOnTextField = event.isFocus;
    } else if (event is ChooseGoogleAccountEvent) {
      Navigator.of(event.context!)
          .pushNamed(ChooseGoogleAccountScreen.chooseGoogleAccountScreenRoute);
    } else if (event is ValidateGoogleAccountEvent) {
      Navigator.pushReplacementNamed(event.context!,
          GoogleAccountValidationScreen.checkValidGoogleAccountRoute,
          arguments: {
            'googleSignInAccount': event.googleSignInAccount,
            'googleSignIn': event.googleSignIn
          });
    } else if (event is NavigateToCompleteGoogelRegScreenEvent) {
      Navigator.of(event.context!).pushReplacementNamed(
          CompleteGoogleRegisterScreen.completeGoogleRegisterScreenRoute,
          arguments: {
            "googleSignInAccount": event.googleSignInAccount,
            "googleSignIn": event.googleSignIn
          });
    } else if (event is SubmitRegisterAccountEvent) {}
    stateController.sink.add(RegisterState(
        username: _username,
        password: _password,
        address: _address,
        avatarUrl: _avatarUrl,
        citizenIdentification: _citizenIdentification,
        dob: _dob,
        email: _email,
        gender: _gender,
        phone: _phone,
        isFocusOnTextField: _isFocusOnTextField));
  }

  void dispose() {
    eventController.close();
    stateController.close();
  }
}
