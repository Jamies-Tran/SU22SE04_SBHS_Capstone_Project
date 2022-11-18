import 'dart:async';

import 'package:staywithme_passenger_application/bloc/event/log_in_event.dart';
import 'package:staywithme_passenger_application/bloc/state/log_in_state.dart';

class LoginBlog {
  final eventController = StreamController<LogInEvent>();
  final stateController = StreamController<LoginState>();

  LoginState initData() =>
      LoginState(username: null, password: null, isFocusOnUsernameField: false);

  String? _username;
  String? _password;
  bool _isFocusOnUsernameField = false;

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
    } else if (event is FocusUsernameLoginEvent) {
      _isFocusOnUsernameField = event.isFocus!;
    }

    stateController.sink.add(LoginState(
        username: _username,
        password: _password,
        isFocusOnUsernameField: _isFocusOnUsernameField));
  }
}
