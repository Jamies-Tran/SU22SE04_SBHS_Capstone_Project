import 'package:flutter/cupertino.dart';

abstract class LogInEvent {}

class InputUsernameLoginEvent extends LogInEvent {
  InputUsernameLoginEvent({this.username});

  String? username;
}

class InputPasswordLoginEvent extends LogInEvent {
  InputPasswordLoginEvent({this.password});

  String? password;
}

class FocusTextFieldLoginEvent extends LogInEvent {
  FocusTextFieldLoginEvent({this.isFocus});

  bool? isFocus;
}

class NavigateToRegScreenEvent extends LogInEvent {
  NavigateToRegScreenEvent({this.context});

  BuildContext? context;
}
