import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:staywithme_passenger_application/bloc/event/authentication_event.dart';
import 'package:staywithme_passenger_application/bloc/register_bloc.dart';
// import 'package:staywithme_passenger_application/service/auth_by_google_service.dart';
// import 'package:staywithme_passenger_application/service_locator/service_locator.dart';

class CompleteGoogleRegisterScreen extends StatefulWidget {
  const CompleteGoogleRegisterScreen({super.key});

  static const completeGoogleRegisterRoute = "/complete_google_sign_in";

  @override
  State<CompleteGoogleRegisterScreen> createState() =>
      _CompleteGoogleRegisterScreenState();
}

// TODO: create complete google signin account screen
class _CompleteGoogleRegisterScreenState
    extends State<CompleteGoogleRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final getArguments = ModalRoute.of(context)!.settings.arguments as Map;
    final registerBloc = RegisterBloc();
    GoogleSignIn googleSignIn = getArguments["googleSignIn"];
    GoogleSignInAccount googleSignInAccount =
        getArguments["googleSignInAccount"];

    return Scaffold(
      appBar: AppBar(title: const Text("Complete google register")),
      body: Container(
        child: Column(children: [
          TextButton(
              onPressed: (() async {
                registerBloc.eventController.sink.add(
                    CancelCompleteGoogleAccountRegisterEvent(
                        context: context, googleSignIn: googleSignIn));
              }),
              child: const Text("Cancel"))
        ]),
      ),
    );
  }
}
