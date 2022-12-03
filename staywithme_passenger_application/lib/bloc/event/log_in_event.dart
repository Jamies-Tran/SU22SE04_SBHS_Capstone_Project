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
  FocusTextFieldLoginEvent({this.isFocusUsername, this.isFocusPassword});

  bool? isFocusUsername;
  bool? isFocusPassword;
}

class ShowPasswordLoginEvent extends LogInEvent {
  ShowPasswordLoginEvent({this.isShowPassword});

  bool? isShowPassword;
}

class NavigateToRegScreenEvent extends LogInEvent {
  NavigateToRegScreenEvent({this.context});

  BuildContext? context;
}
