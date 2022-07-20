import 'package:capstoneproject/base/base_event.dart';

class LoginEvent extends BaseEvent {
  LoginEvent({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}
