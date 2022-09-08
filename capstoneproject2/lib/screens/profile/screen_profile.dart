
import 'package:capstoneproject2/screens/Profile/components/profile_edit_top_image.dart';
import 'package:capstoneproject2/screens/profile/components/profile_option.dart';
import 'package:capstoneproject2/services/auth_service.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_auth_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:capstoneproject2/responsive.dart';
import '../../components/background.dart';
import 'components/profile_forms.dart';

class ProfileInforScreen extends StatelessWidget {
  const ProfileInforScreen({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileProfileInforScreen(user: user),
          desktop: Row(
            children: [
              Expanded(
                child: ProfileEditScreenTopImage(user: user),
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
    this.user
  }) : super(key: key);
  final User? user;
  @override
  Widget build(BuildContext context) {
    final firebaseAuth = locator.get<IFirebaseAuthenticateService>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ProfileEditScreenTopImage(user: user),
        const SizedBox(height: 30,),
        ProfileOption(username: user!.displayName),
        const SizedBox(height: 40,),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.redAccent,
            onPrimary: Colors.white
          ),
          onPressed: () async {
            await firebaseAuth.forgetGoogleSignIn(user!.displayName!);
          },
          child: Text("Log Out".toUpperCase()),
        ),
      ],
    );
  }
}
