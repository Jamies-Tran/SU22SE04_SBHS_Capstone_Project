import 'package:flutter/material.dart';

class LoginState {
  LoginState(
      {this.username,
      this.password,
      this.isFocusOnUsernameField,
      this.isFocusOnPasswordField});

  String? username;
  String? password;

  bool? isFocusOnUsernameField;
  bool? isFocusOnPasswordField;

  Color focusColor() {
    if (isFocusOnUsernameField!) {
      return Colors.white;
    } else {
      return Colors.white24;
    }
  }

  String? validateUsername() {
    if (username == null || username == "") {
      return "Enter username";
    }

    return null;
  }

  String? validatePassword() {
    if (password == null || password == "") {
      return "Enter password";
    }

    return null;
  }
}
