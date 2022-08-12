
import 'package:capstoneproject2/components/background.dart';
import 'package:capstoneproject2/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:capstoneproject2/Screens/additional_profile//components/complete_profile_top_image.dart';

import 'components/addtionalform_profile_signup.dart';

class AdditionalProfileForm extends StatelessWidget {
  const AdditionalProfileForm({Key? key, this.googleSignInAccount, this.isSignInFromBookingScreen, this.homestayName}) : super(key: key);
  final GoogleSignInAccount? googleSignInAccount;
  final bool? isSignInFromBookingScreen;
  final String? homestayName;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileAdditionalProfileScreen(googleSignInAccount: googleSignInAccount, isSignInFromBookingScreen: isSignInFromBookingScreen, homestayName: homestayName),
          desktop: Row(
            children: [
              const Expanded(
                child: CompleteProfileScreenTopImage(),
              ),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 450,
                          child: AdditionalProfileFormSignUp(isSignInFromBookingScreen: isSignInFromBookingScreen, homestayName: homestayName),
                        ),
                      ]
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class MobileAdditionalProfileScreen extends StatelessWidget {
  const MobileAdditionalProfileScreen({Key? key, this.googleSignInAccount, this.isSignInFromBookingScreen, this.homestayName}) : super(key: key);
  final GoogleSignInAccount? googleSignInAccount;
  final bool? isSignInFromBookingScreen;
  final String? homestayName;

  @override
  Widget build(BuildContext context) {

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CompleteProfileScreenTopImage(),
          Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 8,
                child: AdditionalProfileFormSignUp(googleSignInAccount: googleSignInAccount, isSignInFromBookingScreen: isSignInFromBookingScreen, homestayName: homestayName,),
              ),
              const Spacer(),
              // Expanded(
              //   flex: 8,
              //   child: SignUpFormEmail(),
              // )
            ],
          ),
        ]
    );
  }
}
