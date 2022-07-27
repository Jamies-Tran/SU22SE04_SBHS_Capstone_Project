import 'package:capstoneproject2/Screens/Login/login_screen.dart';
import 'package:capstoneproject2/model/auth_model.dart';
import 'package:capstoneproject2/model/error_handler_model.dart';
import 'package:capstoneproject2/navigator_screen/component/dialog_component.dart';
import 'package:capstoneproject2/navigator_screen/component/spinkit_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GoogleSignInNavigator extends StatefulWidget {
  GoogleSignInNavigator({Key? key, this.googleSignInFuture}) : super(key: key);
  Future<dynamic>? googleSignInFuture;

  @override
  State<GoogleSignInNavigator> createState() => _GoogleSignInNavigatorState();
}

class _GoogleSignInNavigatorState extends State<GoogleSignInNavigator> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.googleSignInFuture,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitComponent();
          } else if(snapshot.hasData) {
            final snapShotData = snapshot.data;
            if(snapShotData is AuthenticateModel) {
              print("User authenticated");
            } else if(snapShotData is ErrorHandlerModel) {
              return DialogComponent(message: snapShotData.message);
            }
          }

          return LoginScreen();
        },
    );
  }
}
