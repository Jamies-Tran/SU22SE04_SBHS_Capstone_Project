import 'package:capstoneproject2/navigator_screen/google_sign_up_navigator.dart';
import 'package:capstoneproject2/locator/service_locator.dart';
import 'package:capstoneproject2/model/error_handler_model.dart';
import 'package:capstoneproject2/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../screens/Signup/components/or_divider.dart';
import '../../../screens/Signup/components/social_icon.dart';

class SocalSignUp extends StatelessWidget {
  SocalSignUp({
    Key? key,
  }) : super(key: key);

  final _firebaseAuth = locator.get<IFirebaseAuthService>();

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
              press: () async {
                GoogleSignInAccount? googleSignInAccount = await _firebaseAuth.getGoogleSignInAccount();
                if(googleSignInAccount != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleSignUpNavigator(googleSignUpFuture: _firebaseAuth.confirmBrandNewAccount(googleSignInAccount))));
                }
              },

            ),
            TextButton(
              onPressed: () async {
                await _firebaseAuth.forgetGoogleSignIn();
              },
              child: const Text('Signup with email'),
            ),
          ],
        ),
      ],
    );
  }
}