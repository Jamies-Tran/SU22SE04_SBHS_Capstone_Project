import 'package:capstoneproject2/navigator/google_sign_up_navigator.dart';
import 'package:capstoneproject2/screens/signup/components/or_divider.dart';
import 'package:capstoneproject2/screens/signup/components/social_icon.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_auth_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SocialSignUp extends StatelessWidget {
  SocialSignUp({
    Key? key,
    this.isSignInFromBookingScreen,
    this.homestayName
  }) : super(key: key);

  final _firebaseAuth = locator.get<IFirebaseAuthenticateService>();
  bool? isSignInFromBookingScreen;
  String? homestayName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OrDivider(),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SocalIcon(
              iconSrc: "assets/icons/gmail.svg",
              press: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GoogleSignUpNavigator(isSignInFromBookingScreen: isSignInFromBookingScreen, homestayName: homestayName,)));
              },

            ),
            TextButton(
              onPressed: () async {

              },
              child: const Text('Signup with email'),
            ),
          ],
        ),
      ],
    );
  }
}