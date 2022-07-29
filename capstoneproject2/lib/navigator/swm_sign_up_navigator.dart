import 'package:capstoneproject2/Screens/Login/login_screen.dart';
import 'package:capstoneproject2/Screens/Signup/components/signup_formSWM.dart';
import 'package:capstoneproject2/navigator/component/dialog_component.dart';
import 'package:capstoneproject2/navigator/component/spinkit_component.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/model/passenger_model.dart';
import 'package:flutter/material.dart';

class SwmSignUpNavigator extends StatefulWidget {
  SwmSignUpNavigator({Key? key, this.swmSignUpFuture}) : super(key: key);

  Future<dynamic>? swmSignUpFuture;

  @override
  State<SwmSignUpNavigator> createState() => _SwmSignUpNavigatorState();
}

class _SwmSignUpNavigatorState extends State<SwmSignUpNavigator> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.swmSignUpFuture,
        builder: (fatherContext, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitComponent();
          } else if(snapshot.hasData) {
            final snapShotData = snapshot.data;
            if(snapShotData is PassengerModel) {
              print("Email get from snapshot: ${snapShotData.email}");
              return LoginScreen(emailAfterSignUpSuccess: snapShotData.email);
            } else if(snapShotData is ErrorHandlerModel) {
              return DialogComponent(message: snapShotData.message);
            }
          }

          return SignUpSWMForm();
        },
    );
  }
}
