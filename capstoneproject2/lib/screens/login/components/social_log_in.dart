import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/screens/signup/components/or_divider.dart';
import 'package:capstoneproject2/screens/signup/components/social_icon.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_auth_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';



class SocialLogin extends StatelessWidget {
  SocialLogin({Key? key}) : super(key: key);
  final _firebaseAuth = locator.get<IFirebaseAuthenticateService>();

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
              //   dynamic getGoogleSignInAccount =  await _firebaseAuth.getGoogleSignInAccount();
              //   if(getGoogleSignInAccount is GoogleSignInAccount) {
              //     print(getGoogleSignInAccount.email);
              //   } else if(getGoogleSignInAccount is ErrorHandlerModel){
              //     print(getGoogleSignInAccount.message);
              //   }
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
