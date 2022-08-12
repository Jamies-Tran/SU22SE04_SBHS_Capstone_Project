// import 'package:capstoneproject2/components/dialog_component.dart';
import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/screens/home_page/home_page_screen.dart';
import 'package:capstoneproject2/screens/homestay_detail/view_homestay_detail.dart';
// import 'package:capstoneproject2/screens/homestay_detail/view_homestay_detail.dart';
// import 'package:capstoneproject2/screens/welcome/components/login_signup_btn.dart';
import 'package:capstoneproject2/services/auth_service.dart';
// import 'package:capstoneproject2/services/firebase_service/firebase_auth_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/auth_model.dart';
// import 'package:capstoneproject2/services/model/error_handler_model.dart';
// import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Screens/Login/login_screen.dart';
import '../Screens/Welcome/welcome_screen.dart';
import '../screens/additional_profile/additional_profile_screen.dart';


final _fireAuth = FirebaseAuth.instance;

class GoogleSignUpNavigator extends StatefulWidget {
  const GoogleSignUpNavigator({
    Key? key, googleSignInAccount,
    this.isSignInFromBookingScreen,
    this.homestayName
  }) : super(key: key);
  final bool? isSignInFromBookingScreen;
  final String? homestayName;

  @override
  State<GoogleSignUpNavigator> createState() => _GoogleSignUpNavigatorState();
}

class _GoogleSignUpNavigatorState extends State<GoogleSignUpNavigator> {
  // final _authService = locator.get<IAuthenticateService>();
  // final _passengerService = locator.get<IPassengerService>();
  final _googleSignInAccount = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _googleSignInAccount.signIn(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitComponent();
        } else if(snapshot.hasData) {
          final snapShotData = snapshot.data;
          if(snapShotData is GoogleSignInAccount) {
            return ValidateSignUp(
              googleSignInAccount: snapShotData,
              isSignInFromBookingScreen: widget.isSignInFromBookingScreen,
              homestayName: widget.homestayName,);
          } else {
            Navigator.pop(context);
          }
        } else if(snapshot.hasError) {
          return Center(child: Text("Something wrong occur ${snapshot.error}"),);
        }

        return const WelcomeScreen();
      },
    );
  }
}

class ValidateSignUp extends StatelessWidget {
  const ValidateSignUp({
    Key? key, this.googleSignInAccount,
    this.isSignInFromBookingScreen,
    this.homestayName
  }) : super(key: key);
  final GoogleSignInAccount? googleSignInAccount;
  final bool? isSignInFromBookingScreen;
  final String? homestayName;

  @override
  Widget build(BuildContext context) {
    final authService = locator.get<IAuthenticateService>();
    return FutureBuilder(
        future: authService.loginByGoogleAccount(googleSignInAccount!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitComponent();
          } else if(snapshot.hasData) {
            final snapshotData = snapshot.data;
            if(snapshotData is AuthenticateModel) {
              return SignInWithGoogle(googleSignInAccount: googleSignInAccount, isSignInFromBookingScreen: isSignInFromBookingScreen, homestayName: homestayName,);
            } else {
              return AdditionalProfileForm(googleSignInAccount: googleSignInAccount, isSignInFromBookingScreen: isSignInFromBookingScreen, homestayName: homestayName,);
            }
          } else if(snapshot.hasError) {
            return Center(child: Text("Something wrong occur ${snapshot.error}"),);
          }

          return const Center(child: Text("Undefine error"),);
        },
    );
  }
}

class SignInWithGoogle extends StatelessWidget {
  const SignInWithGoogle({
    Key? key, this.googleSignInAccount,
    this.isSignInFromBookingScreen,
    this.homestayName
  }) : super(key: key);

  final GoogleSignInAccount? googleSignInAccount;
  final bool? isSignInFromBookingScreen;
  final String? homestayName;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: googleSignInAccount!.authentication,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitComponent();
          } else if(snapshot.hasData) {
            final snapshotData = snapshot.data;
            if(snapshotData is GoogleSignInAuthentication) {
              final googleCredential = GoogleAuthProvider.credential(
                accessToken: snapshotData.accessToken,
                idToken: snapshotData.idToken
              );
              return FinalGoogleSignInSetup(credential: googleCredential, homestayName: homestayName, isSignInFromBookingScreen: isSignInFromBookingScreen,);
            }
          } else if(snapshot.hasError) {
            return Center(child: Text("Something wrong occur ${snapshot.error}"),);
          }

          return const Center(child: Text("Undefine error"),);
        },
    );
  }
}

class FinalGoogleSignInSetup extends StatelessWidget {
  const FinalGoogleSignInSetup({
    Key? key,
    this.credential,
    this.isSignInFromBookingScreen,
    this.homestayName
  }) : super(key: key);
  final OAuthCredential? credential;
  final bool? isSignInFromBookingScreen;
  final String? homestayName;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fireAuth.signInWithCredential(credential!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitComponent();
          } else if(snapshot.hasData) {
            final snapshotData = snapshot.data;
            if(snapshotData is UserCredential) {
              if(isSignInFromBookingScreen!) {
                return HomestayDetailsScreen(homestayName: homestayName);
              } else {
                return const HomePageScreen();
              }
            }
          } else if(snapshot.hasError) {
            return Center(child: Text("Something wrong occur ${snapshot.error}"),);
          }

          return const Center(child: Text("Undefine error"),);
        },
    );
  }
}


