import 'package:capstoneproject2/Screens/additional_profile/components/addtionalform_profile_signup.dart';
import 'package:capstoneproject2/components/background.dart';
import 'package:capstoneproject2/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:capstoneproject2/Screens/additional_profile//components/complete_profile_top_image.dart';

class AdditionalProfileForm extends StatelessWidget {
  AdditionalProfileForm({Key? key, this.googleSignInAccount}) : super(key: key);
  GoogleSignInAccount? googleSignInAccount;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileAdditionalProfileScreen(googleSignInAccount: googleSignInAccount),
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
                          child: AdditionalProfileFormSignUp(googleSignInAccount: googleSignInAccount),
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
  MobileAdditionalProfileScreen({Key? key, this.googleSignInAccount}) : super(key: key);
  GoogleSignInAccount? googleSignInAccount;

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
                child: AdditionalProfileFormSignUp(googleSignInAccount: googleSignInAccount),
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
