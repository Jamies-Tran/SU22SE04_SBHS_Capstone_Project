import 'package:capstoneproject2/locator/service_locator.dart';
import 'package:capstoneproject2/model/error_handler_model.dart';
import 'package:capstoneproject2/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../screens/Signup/components/or_divider.dart';
import '../../../screens/Signup/components/social_icon.dart';

class SocalLogin extends StatelessWidget {
  SocalLogin({Key? key}) : super(key: key);
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
                dynamic getGoogleSignInAccount =  await _firebaseAuth.getGoogleSignInAccount();
                if(getGoogleSignInAccount is GoogleSignInAccount) {
                  print(getGoogleSignInAccount.email);
                } else if(getGoogleSignInAccount is ErrorHandlerModel){
                  print(getGoogleSignInAccount.message);
                }
              },

            ),
            TextButton(
              onPressed: () {

              },
              child: const Text('Login with email'),
            ),
          ],
        ),
      ],
    );
  }
}
