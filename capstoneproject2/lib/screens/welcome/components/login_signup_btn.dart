
// import 'package:capstoneproject2/Screens/email_sign_up/signup_email.dart';
import 'package:capstoneproject2/navigator/google_sign_up_navigator.dart';
// import 'package:capstoneproject2/services/auth_service.dart';
// import 'package:capstoneproject2/services/firebase_service/firebase_auth_service.dart';
// import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

import '../../../constants.dart';

import '../../Signup/signup_screen.dart';
import '../../login/login_screen.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
    this.homestayName,
    this.isSignInFromBookingScreen
  }) : super(key: key);
  final bool? isSignInFromBookingScreen;
  final String? homestayName;

  @override
  Widget build(BuildContext context) {
    // final _firebaseAuth = locator.get<IFirebaseAuthenticateService>();
    // final _authService = locator.get<IAuthenticateService>();
    return Column(
      children: [
        Hero(
          tag: "login_btn",
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen(isSignInFromBookingScreen: isSignInFromBookingScreen, homestayName: homestayName);
                  },
                ),
              );
            },
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const SignUpScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              primary: kPrimaryLightColor, elevation: 0),
          child: Text(
            "Sign Up".toUpperCase(),
            style: const TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleSignUpNavigator(isSignInFromBookingScreen: isSignInFromBookingScreen, homestayName : homestayName)));
        },
            style: ElevatedButton.styleFrom(primary: Colors.redAccent, elevation: 0),
            child: Text(
              "Sign Up With Gmail".toUpperCase(),
              style: const TextStyle(color: Colors.black),
            ),
        ),

      ],
    );
  }
}
