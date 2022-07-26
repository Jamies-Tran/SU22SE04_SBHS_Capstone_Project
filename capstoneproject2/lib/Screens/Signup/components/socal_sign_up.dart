import 'package:capstoneproject2/Screens/complete_google_sign_up.dart';
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteGoogleSignUpScreen(getGoogleSignInAccount: _firebaseAuth.getGoogleSignInAccount())));
              },

            ),
            TextButton(
              onPressed: () async {
                dynamic getGoogleSignInAccount =  await _firebaseAuth.getGoogleSignInAccount();
                if(getGoogleSignInAccount is GoogleSignInAccount) {
                  print(getGoogleSignInAccount.email);
                } else if(getGoogleSignInAccount is ErrorHandlerModel){
                  print(getGoogleSignInAccount.message);
                }
              },
              child: const Text('Signup with email'),
            ),
          ],
        ),
      ],
    );
  }
}