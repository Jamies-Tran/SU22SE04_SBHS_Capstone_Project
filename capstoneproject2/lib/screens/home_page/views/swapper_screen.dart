
import 'package:capstoneproject2/Screens/Welcome/welcome_screen.dart';
import 'package:capstoneproject2/navigator/component/spinkit_component.dart';
import 'package:capstoneproject2/screens/profile/screen_profile.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_clound_firestore_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fireAuth = FirebaseAuth.instance;

    return StreamBuilder(
        stream: fireAuth.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitComponent();
          } else if(snapshot.hasData) {
            User? user = snapshot.data as User;
            return ProfileInforScreen(user: user,);
          } else {
            return const WelcomeScreen();
          }
        },
    );
  }
}
