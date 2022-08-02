import 'package:capstoneproject2/Screens/Login/login_screen.dart';
import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/screens/home_page/home_page_screen.dart';
import 'package:capstoneproject2/services/model/auth_model.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:flutter/material.dart';

import '../components/dialog_component.dart';

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
              return const HomePageScreen();
            } else if(snapShotData is ErrorHandlerModel) {
              return DialogComponent(message: snapShotData.message, eventHandler: () => Navigator.pop(context));
            }
          }

          return LoginScreen();
        },
    );
  }
}
