
import 'package:capstoneproject2/Screens/signupaddtionalprofile/components/addtionalform_profile_signup.dart';
import 'package:capstoneproject2/components/background.dart';
import 'package:capstoneproject2/responsive.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:capstoneproject2/Screens/signupaddtionalprofile/components/complete_profile_top_image.dart';

class AdditionalProfileForm extends StatelessWidget {
  const AdditionalProfileForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileAddtionalProfileScreen(),
          desktop: Row(
            children: [
              const Expanded(
                child: CompleteProfileScreenTopImage(),
              ),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 450,
                          child: AddtionalProfileFormSignUp(),
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
class MobileAddtionalProfileScreen extends StatelessWidget {
  const MobileAddtionalProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CompleteProfileScreenTopImage(),
          Row(
            children: const [
              Spacer(),
              Expanded(
                flex: 8,
                child: AddtionalProfileFormSignUp(),
              ),
              Spacer(),
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
