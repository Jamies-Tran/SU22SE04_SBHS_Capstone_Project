import 'package:capstoneproject2/Screens/Welcome/welcome_screen.dart';
import 'package:capstoneproject2/model/error_handler_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CompleteGoogleSignUpScreen extends StatefulWidget {
  const CompleteGoogleSignUpScreen({Key? key, googleSignInAccount, this.getGoogleSignInAccount}) : super(key: key);

  final Future<dynamic>? getGoogleSignInAccount;

  @override
  State<CompleteGoogleSignUpScreen> createState() => _CompleteGoogleSignUpScreenState();
}

class _CompleteGoogleSignUpScreenState extends State<CompleteGoogleSignUpScreen> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.getGoogleSignInAccount,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitThreeInOut(
            color: Colors.blue,
          );
        } else if(snapshot.hasData) {
          final snapShotData = snapshot.data;
          if(snapShotData is GoogleSignInAccount) {
            print(snapShotData.email);
          } else if(snapShotData is ErrorHandlerModel) {
            print(snapShotData.message);
          }
        }

        return const WelcomeScreen();
      },
    );
  }
}


