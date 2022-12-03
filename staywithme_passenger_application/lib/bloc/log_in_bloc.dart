import 'dart:async';

import 'package:flutter/material.dart';
import 'package:staywithme_passenger_application/bloc/event/log_in_event.dart';
import 'package:staywithme_passenger_application/bloc/state/log_in_state.dart';
import 'package:staywithme_passenger_application/screen/authenticate/register_screen.dart';

class LoginBlog {
  final eventController = StreamController<LogInEvent>();
  final stateController = StreamController<LoginState>();

  bool _isShowPassword = false;

  LoginState initData() => LoginState(
      username: null,
      password: null,
      focusUsernameColor: Colors.white,
      focusPasswordColor: Colors.white,
      isShowPassword: _isShowPassword);

  String? _username;
  String? _password;

  Color? _focusUsernameColor;
  Color? _focusPasswordColor;

  LoginBlog() {
    eventController.stream.listen((event) {
      eventHandler(event);
    });
  }

  void eventHandler(LogInEvent event) {
    if (event is InputUsernameLoginEvent) {
      _username = event.username;
    } else if (event is InputPasswordLoginEvent) {
      _password = event.password;
    } else if (event is FocusTextFieldLoginEvent) {
      _focusUsernameColor =
          event.isFocusUsername == true ? Colors.black45 : Colors.white;
      _focusPasswordColor =
          event.isFocusPassword == true ? Colors.black45 : Colors.white;
    } else if (event is ShowPasswordLoginEvent) {
      _isShowPassword = !_isShowPassword;
    } else if (event is NavigateToRegScreenEvent) {
      Navigator.of(event.context!)
          .pushNamed(RegisterScreen.registerAccountRoute);
    }

    stateController.sink.add(LoginState(
        username: _username,
        password: _password,
        focusUsernameColor: _focusUsernameColor,
        focusPasswordColor: _focusPasswordColor,
        isShowPassword: _isShowPassword));
  }
}
