import 'package:capstoneproject2/Screens/Profile/components/profile_edit_top_image.dart';
import 'package:capstoneproject2/Screens/Profile/components/profile_forms.dart';
import 'package:flutter/material.dart';

import 'package:capstoneproject2/responsive.dart';
import '../../components/background.dart';

class ProfileInforScreen extends StatelessWidget {
  const ProfileInforScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileProfileInforScreen(),
          desktop: Row(
            children: [
              const Expanded(
                child: ProfileEditScreenTopImage(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 450,
                      child: ProfileInformationForms(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MobileProfileInforScreen extends StatelessWidget {
  const MobileProfileInforScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const ProfileEditScreenTopImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: ProfileInformationForms(),
            ),
            Spacer(),
            // Expanded(
            //   flex: 8,
            //   child: SignUpFormEmail(),
            // )
          ],
        ),
      ],
    );
  }
}
