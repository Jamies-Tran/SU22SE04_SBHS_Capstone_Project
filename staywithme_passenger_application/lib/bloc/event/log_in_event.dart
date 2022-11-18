import 'package:staywithme_passenger_application/bloc/log_in_bloc.dart';

abstract class LogInEvent {}

class InputUsernameLoginEvent extends LogInEvent {
  InputUsernameLoginEvent({this.username});

  String? username;
}

class InputPasswordLoginEvent extends LogInEvent {
  InputPasswordLoginEvent({this.password});

  String? password;
}

class FocusUsernameLoginEvent extends LogInEvent {
  FocusUsernameLoginEvent({this.isFocus});

  bool? isFocus;
}
