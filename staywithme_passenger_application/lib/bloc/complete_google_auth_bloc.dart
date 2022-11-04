import 'dart:async';

import 'package:flutter/material.dart';
import 'package:staywithme_passenger_application/bloc/event/auth_by_google_event.dart';
import 'package:staywithme_passenger_application/screen/authenticate/complete_google_register.screen.dart';

class CompleteGoogleAuthBloc {
  final eventController = StreamController<AuthenticateByGoogleEvent>();

  CompleteGoogleAuthBloc() {
    eventController.stream.listen((event) {
      eventHandler(event);
    });
  }

  void eventHandler(AuthenticateByGoogleEvent event) {
    if (event is ForwardCompleteGoogleRegisterScreenEvent) {
      final usernameTextEditingCtl = TextEditingController();
      final emailTextEditingCtl = TextEditingController();
      usernameTextEditingCtl.text = event.googleSignInAccount!.displayName!;
      emailTextEditingCtl.text = event.googleSignInAccount!.email;
      Navigator.pushReplacementNamed(event.context!,
          CompleteGoogleRegisterScreen.completeGoogleRegisterRoute,
          arguments: {
            "usernameTextEditingCtl": usernameTextEditingCtl,
            "emailTextEditingCtl": emailTextEditingCtl,
            "googleSignIn": event.googleSignIn
          });
    } else if (event is BackwardToRegisterScreenEvent) {
      Navigator.of(event.context!).pop();
    }
  }

  void dispose() {
    eventController.close();
  }
}
