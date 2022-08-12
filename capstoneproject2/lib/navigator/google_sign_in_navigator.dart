import 'package:capstoneproject2/Screens/Login/login_screen.dart';
import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/navigator/google_sign_up_navigator.dart';
import 'package:capstoneproject2/screens/home_page/home_page_screen.dart';
import 'package:capstoneproject2/screens/homestay_detail/view_homestay_detail.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/auth_model.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/model/passenger_model.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../components/dialog_component.dart';

final _fireAuth = FirebaseAuth.instance;

class GoogleSignInNavigator extends StatefulWidget {
  const GoogleSignInNavigator({Key? key, this.googleSignInAccount, this.passengerModel, this.isSignInFromBookingScreen, this.homestayName}) : super(key: key);
  final GoogleSignInAccount? googleSignInAccount;
  final PassengerModel? passengerModel;
  final bool? isSignInFromBookingScreen;
  final String? homestayName;

  @override
  State<GoogleSignInNavigator> createState() => _GoogleSignInNavigatorState();
}

class _GoogleSignInNavigatorState extends State<GoogleSignInNavigator> {

  final _passengerService = locator.get<IPassengerService>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _passengerService.signUpWithGoogleAccount(widget!.passengerModel!, widget!.googleSignInAccount!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitComponent();
          } else if(snapshot.hasData) {
            final snapShotData = snapshot.data;
            if(snapShotData is PassengerModel) {
              return SignInWithGoogleFromAdditionalProfile(
                googleSignInAccount: widget.googleSignInAccount,
                passengerModel: widget.passengerModel
              );

            } else if(snapShotData is ErrorHandlerModel) {
              return DialogComponent(message: snapShotData.message, eventHandler: () => Navigator.pop(context));
            }
          } else if(snapshot.hasError) {
            return Center(child: Text("Error occured: ${snapshot.error}"),);
          }

          return const Center(child: Text("Undefine error"),);
        },
    );
  }
}

class SignInWithGoogleFromAdditionalProfile extends StatelessWidget {
  const SignInWithGoogleFromAdditionalProfile({
    Key? key,
    this.googleSignInAccount,
    this.passengerModel
  }) : super(key: key);
  final GoogleSignInAccount? googleSignInAccount;
  final PassengerModel? passengerModel;

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
            return FinalGoogleSignInSetupFromAdditionalProfile(
                credential: googleCredential,
                passengerModel: passengerModel
            );
          }
        } else if(snapshot.hasError) {
          return Center(child: Text("Something wrong occur ${snapshot.error}"),);
        }

        return const Center(child: Text("Undefine error"),);
      },
    );
  }
}

class FinalGoogleSignInSetupFromAdditionalProfile extends StatelessWidget {
  const FinalGoogleSignInSetupFromAdditionalProfile({
    Key? key,
    this.credential,
    this.passengerModel
  }) : super(key: key);
  final OAuthCredential? credential;
  final PassengerModel? passengerModel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fireAuth.signInWithCredential(credential!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitComponent();
        } else if (snapshot.hasData) {
          final snapshotData = snapshot.data;
          if (snapshotData is UserCredential) {
            if(snapshotData.user!.displayName!.compareTo(passengerModel!.username) != 0) {
              snapshotData.user!.updateDisplayName(passengerModel!.username);
            }
            return const HomePageScreen();
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Something wrong occur ${snapshot.error}"),);
        }

        return const Center(child: Text("Undefine error"),);
      },
    );
  }

}