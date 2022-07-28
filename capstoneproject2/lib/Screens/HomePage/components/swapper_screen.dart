import 'package:capstoneproject2/Screens/Profile/screen_profile.dart';
import 'package:capstoneproject2/Screens/Welcome/welcome_screen.dart';
import 'package:capstoneproject2/navigator_screen/component/spinkit_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _fireAuth = FirebaseAuth.instance;

    return StreamBuilder(
        stream: _fireAuth.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return SpinKitComponent();
          } else if(snapshot.hasData) {
            return ProfileInforScreen();
          } else {
            return WelcomeScreen();
          }
        },
    );
  }
}
