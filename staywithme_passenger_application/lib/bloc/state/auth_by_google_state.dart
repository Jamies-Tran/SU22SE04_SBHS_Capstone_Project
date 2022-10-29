abstract class AuthenticateByGoogleState {}

class RegisterByGoogleState extends AuthenticateByGoogleState {
  RegisterByGoogleState({this.email});

  String? email;
}
