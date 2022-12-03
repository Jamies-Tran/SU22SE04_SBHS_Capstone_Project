import 'dart:async';

import 'package:flutter/material.dart';
import 'package:staywithme_passenger_application/bloc/event/reg_google_event.dart';
import 'package:staywithme_passenger_application/bloc/state/reg_google_state.dart';
import 'package:staywithme_passenger_application/screen/authenticate/complete_google_reg_screen.dart';
import 'package:staywithme_passenger_application/screen/authenticate/register_screen.dart';
import 'package:staywithme_passenger_application/service/auth_by_google_service.dart';
import 'package:staywithme_passenger_application/service_locator/service_locator.dart';

class CompleteGoogleRegBloc {
  final eventController = StreamController<CompleteGoogleRegisterEvent>();
  final stateController = StreamController<CompleteGoogleRegisterState>();

  final googleAuthService = locator.get<IAuthenticateByGoogleService>();

  String? _username;
  String? _email;
  String? _phone;
  String? _address;
  String? _citizenIdentification;
  String? _gender;
  String? _dob;
  final genderSelection = ["Male", "Female"];
  String? _cancelGoogleRegRoute;

  Color? _focusUsernameColor;
  Color? _focusPhoneColor;
  Color? _focusCitizenIdentificationColor;
  Color? _focusBirthDayColor;
  Color? _focusAddressColor;

  CompleteGoogleRegBloc() {
    eventController.stream.listen((event) {
      eventHandler(event);
    });
  }

  CompleteGoogleRegisterState initData(String? username, String? email) {
    _username = username;
    _email = email;
    return CompleteGoogleRegisterState(
      username: username,
      email: email,
      address: null,
      citizenIdentification: null,
      gender: genderSelection[0],
      phone: null,
      dob: null,
      focusAddressColor: Colors.white,
      focusBirthDayColor: Colors.white,
      focusCitizenIdentificationColor: Colors.white,
      focusPhoneColor: Colors.white,
      focusUsernameColor: Colors.white,
    );
  }

  void eventHandler(CompleteGoogleRegisterEvent event) {
    if (event is ForwardCompleteGoogleRegisterScreenEvent) {
      final usernameTextEditingCtl = TextEditingController();
      final emailTextEditingCtl = TextEditingController();
      usernameTextEditingCtl.text = event.googleSignInAccount!.displayName!;
      emailTextEditingCtl.text = event.googleSignInAccount!.email;
      Navigator.pushReplacementNamed(event.context!,
          CompleteGoogleRegisterScreen.completeGoogleRegisterScreenRoute,
          arguments: {
            "usernameTextEditingCtl": usernameTextEditingCtl,
            "emailTextEditingCtl": emailTextEditingCtl,
            "googleSignIn": event.googleSignIn
          });
    } else if (event is BackwardToRegisterScreenEvent) {
      Navigator.of(event.context!).pop();
    } else if (event is CancelCompleteGoogleAccountRegisterEvent) {
      if (event.isChangeGoogleAccount!) {
        _cancelGoogleRegRoute =
            ChooseGoogleAccountScreen.chooseGoogleAccountScreenRoute;
      } else {
        _cancelGoogleRegRoute = RegisterScreen.registerAccountRoute;
      }
      googleAuthService.signOut(event.googleSignIn!).then((value) =>
          Navigator.of(event.context!)
              .pushReplacementNamed(_cancelGoogleRegRoute!));
    } else if (event is InputUsernameGoogleAuthEvent) {
      _username = event.username;
    } else if (event is ReceiveEmailGoogleAuthEvent) {
      _email = event.email;
    } else if (event is InputPhoneGoogleAuthEvent) {
      _phone = event.phone;
    } else if (event is InputAddressGoogleAuthEvent) {
      _address = event.address;
    } else if (event is InputCitizenIdentificationGoogleAuthEvent) {
      _citizenIdentification = event.citizenIdentification;
    } else if (event is ChooseGenderGoogleAuthEvent) {
      _gender = event.gender;
    } else if (event is InputDobGoogleAuthEvent) {
      _dob = event.dob;
    } else if (event is FocusTextFieldCompleteGoogleRegEvent) {
      if (event.isFocusOnUsername == true) {
        _focusUsernameColor = Colors.black45;
      } else {
        _focusUsernameColor = Colors.white;
      }
      if (event.isFocusOnPhone == true) {
        _focusPhoneColor = Colors.black45;
      } else {
        _focusPhoneColor = Colors.white;
      }
      if (event.isFocusOnAddress == true) {
        _focusAddressColor = Colors.black45;
      } else {
        _focusAddressColor = Colors.white;
      }
      if (event.isFocusOnCitizenIdentification == true) {
        _focusCitizenIdentificationColor = Colors.black45;
      } else {
        _focusCitizenIdentificationColor = Colors.white;
      }
      if (event.isFocusOnBirthDay == true) {
        _focusBirthDayColor = Colors.black45;
      } else {
        _focusBirthDayColor = Colors.white;
      }
    } else if (event is CancelChooseAnotherGoogleAccountEvent) {
      Navigator.of(event.context!).pop();
    } else if (event is SubmitGoogleCompleteRegisterEvent) {}

    //TODO: sửa isFocusOnTextField-bool thành focusColor-Color
    stateController.sink.add(CompleteGoogleRegisterState(
      username: _username,
      email: _email,
      address: _address,
      phone: _phone,
      citizenIdentification: _citizenIdentification,
      gender: _gender,
      dob: _dob,
      focusAddressColor: _focusAddressColor,
      focusBirthDayColor: _focusBirthDayColor,
      focusCitizenIdentificationColor: _focusCitizenIdentificationColor,
      focusPhoneColor: _focusPhoneColor,
      focusUsernameColor: _focusUsernameColor,
    ));
  }

  void dispose() {
    eventController.close();
    stateController.close();
  }
}
