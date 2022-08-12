
import 'package:flutter/material.dart';
import 'package:capstoneproject2/responsive.dart';

import '../../components/background.dart';
import '../signup/components/social_sign_up.dart';
import 'components/login_form.dart';
import 'components/login_screen_top_image.dart';
import 'components/social_log_in.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key, this.emailAfterSignUpSuccess, this.isSignInFromBookingScreen, this.homestayName}) : super(key: key);
  String? emailAfterSignUpSuccess;
  bool? isSignInFromBookingScreen;
  String? homestayName;

  @override
  Widget build(BuildContext context) {
    print("email from login screen: ${emailAfterSignUpSuccess}");
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileLoginScreen(emailAfterSignUpSuccess: emailAfterSignUpSuccess, isSignInFromBookingScreen: isSignInFromBookingScreen,
              homestayName: homestayName
          ),
          desktop: Row(
            children: [
              const Expanded(
                child: LoginScreenTopImage(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: LoginForm(emailAfterSignUpSuccess: emailAfterSignUpSuccess),
                    ),
                    SizedBox(
                      width: 450,
                      child: SocialSignUp(isSignInFromBookingScreen : isSignInFromBookingScreen, homestayName: homestayName),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  MobileLoginScreen({
    Key? key,
    this.emailAfterSignUpSuccess,
    this.isSignInFromBookingScreen,
    this.homestayName
  }) : super(key: key);
  String? emailAfterSignUpSuccess;
  bool? isSignInFromBookingScreen;
  String? homestayName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const LoginScreenTopImage(),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(emailAfterSignUpSuccess: emailAfterSignUpSuccess),
            ),
            const Spacer(),
          ],

        ),
         SocialSignUp(isSignInFromBookingScreen: isSignInFromBookingScreen, homestayName: homestayName),
      ],
    );
  }
}
