import 'dart:async';

import 'package:flutter/material.dart';
import 'package:staywithme_passenger_application/bloc/event/log_in_event.dart';
import 'package:staywithme_passenger_application/bloc/state/log_in_state.dart';
import 'package:staywithme_passenger_application/screen/authenticate/register_screen.dart';

class LoginBlog {
  final eventController = StreamController<LogInEvent>();
  final stateController = StreamController<LoginState>();

  LoginState initData() =>
      LoginState(username: null, password: null, isFocusOnTextField: false);

  String? _username;
  String? _password;
  bool _isFocusOnTextField = false;

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
      _isFocusOnTextField = event.isFocus!;
    } else if (event is NavigateToRegScreenEvent) {
      Navigator.of(event.context!)
          .pushNamed(RegisterScreen.registerAccountRoute);
    }

    stateController.sink.add(LoginState(
        username: _username,
        password: _password,
        isFocusOnTextField: _isFocusOnTextField));
  }
}
