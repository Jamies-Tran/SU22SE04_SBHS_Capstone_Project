
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../Login/login_screen.dart';
import '../../Signup/signup_screen.dart';
import 'package:capstoneproject2/Screens/SignUpEmail/signup_email.dart';
class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "login_btn",
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignUpScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              primary: kPrimaryLightColor, elevation: 0),
          child: Text(
            "Sign Up".toUpperCase(),
            style: TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: (){
          Navigator.push(
              context,
            MaterialPageRoute(
                builder: (context){
                return SignUpEmailScreen();
              },
            ),
          );
        },
            style: ElevatedButton.styleFrom(primary: kPrimaryLightColor, elevation: 0),
            child: Text(
              "Sign Up With Email".toUpperCase(),
              style: TextStyle(color: Colors.black),
            ),
        ),

      ],
    );
  }
}
