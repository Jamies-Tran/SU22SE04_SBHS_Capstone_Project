import 'package:flutter/material.dart';

import '../../components/background.dart';
import '../../responsive.dart';
import 'components/login_signup_btn.dart';
import 'components/welcome_image.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key, this.isSignInFromBookingScreen, this.homestayName}) : super(key: key);
  final bool? isSignInFromBookingScreen;
  final String? homestayName;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Expanded(
                  child: WelcomeImage(),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 450,
                        child: LoginAndSignupBtn(isSignInFromBookingScreen : isSignInFromBookingScreen, homestayName : homestayName),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            mobile: MobileWelcomeScreen(isSignInFromBookingScreen: isSignInFromBookingScreen, homestayName: homestayName,),
          ),
        ),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    Key? key,
    this.isSignInFromBookingScreen,
    this.homestayName
  }) : super(key: key);

  final isSignInFromBookingScreen;
  final String? homestayName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const WelcomeImage(),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: LoginAndSignupBtn(isSignInFromBookingScreen: isSignInFromBookingScreen, homestayName: homestayName),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
