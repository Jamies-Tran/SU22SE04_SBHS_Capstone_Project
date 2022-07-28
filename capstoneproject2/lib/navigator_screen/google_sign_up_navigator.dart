import 'package:capstoneproject2/Screens/HomePage/home_page_screen.dart';
import 'package:capstoneproject2/Screens/Welcome/welcome_screen.dart';
import 'package:capstoneproject2/Screens/signupaddtionalprofile/additional_profile_screen.dart';
import 'package:capstoneproject2/locator/service_locator.dart';
import 'package:capstoneproject2/model/error_handler_model.dart';
import 'package:capstoneproject2/navigator_screen/component/dialog_component.dart';
import 'package:capstoneproject2/navigator_screen/component/spinkit_component.dart';
import 'package:capstoneproject2/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Screens/Login/login_screen.dart';

class GoogleSignUpNavigator extends StatefulWidget {
  const GoogleSignUpNavigator({Key? key, googleSignInAccount, this.googleSignUpFuture}) : super(key: key);

  final Future<dynamic>? googleSignUpFuture;

  @override
  State<GoogleSignUpNavigator> createState() => _GoogleSignUpNavigatorState();
}

class _GoogleSignUpNavigatorState extends State<GoogleSignUpNavigator> {
  final _authService = locator.get<IFirebaseAuthService>();
  final _fireAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.googleSignUpFuture,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitComponent();
        } else if(snapshot.hasData) {
          final snapShotData = snapshot.data;
          if(snapShotData is GoogleSignInAccount) {
            if(_fireAuth.currentUser == null) {
              return AdditionalProfileForm(googleSignInAccount: snapShotData);
            } else {
              return const HomePageScreen();
            }
          } else if(snapShotData is ErrorHandlerModel) {
            _authService.forgetGoogleSignIn();
            return DialogComponent(message: snapShotData.message);
          }
        }

        return LoginScreen();
      },
    );
  }
}


