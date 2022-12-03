import 'dart:async';
import 'package:flutter/material.dart';
import 'package:staywithme_passenger_application/bloc/event/reg_event.dart';
import 'package:staywithme_passenger_application/bloc/state/reg_state.dart';
import 'package:staywithme_passenger_application/screen/authenticate/complete_google_reg_screen.dart';
import 'package:staywithme_passenger_application/screen/authenticate/log_in_screen.dart';
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
  final genderSelection = ["Male", "Female"];

  Color? _focusUsernameColor;
  Color? _focusPasswordColor;
  Color? _focusEmailColor;
  Color? _focusAddressColor;
  Color? _focusPhoneColor;
  Color? _focusCitizenIdentificationColor;
  Color? _focusBirthdayColor;

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
      focusUsernameColor: Colors.white,
      focusPasswordColor: Colors.white,
      focusAddressColor: Colors.white,
      focusEmailColor: Colors.white,
      focusPhoneColor: Colors.white,
      focusCitizenIdentificationColor: Colors.white,
      focusBirthdayColor: Colors.white);

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
      _focusUsernameColor =
          event.isFocusOnUsername == true ? Colors.black45 : Colors.white;
      _focusPasswordColor =
          event.isFocusOnPassword == true ? Colors.black45 : Colors.white;
      _focusEmailColor =
          event.isFocusOnEmail == true ? Colors.black45 : Colors.white;
      _focusAddressColor =
          event.isFocusOnAddress == true ? Colors.black45 : Colors.white;
      _focusPhoneColor =
          event.isFocusOnPhone == true ? Colors.black45 : Colors.white;
      _focusCitizenIdentificationColor =
          event.isFocusOnCitizenIdentification == true
              ? Colors.black45
              : Colors.white;
      _focusBirthdayColor =
          event.isFocusOnBirthday == true ? Colors.black45 : Colors.white;
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
    } else if (event is NaviageToLoginScreenEvent) {
      Navigator.of(event.context!)
          .pushReplacementNamed(LoginScreen.loginScreenRoute);
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
        focusUsernameColor: _focusUsernameColor,
        focusPasswordColor: _focusPasswordColor,
        focusEmailColor: _focusEmailColor,
        focusAddressColor: _focusAddressColor,
        focusPhoneColor: _focusPhoneColor,
        focusCitizenIdentificationColor: _focusCitizenIdentificationColor,
        focusBirthdayColor: _focusBirthdayColor));
  }

  void dispose() {
    eventController.close();
    stateController.close();
  }
}
