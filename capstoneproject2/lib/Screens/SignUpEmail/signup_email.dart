import 'package:capstoneproject2/Screens/Signup/components/sign_up_top_image.dart';
import 'package:capstoneproject2/Screens/Signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/responsive.dart';
import '../../components/background.dart';
import 'package:capstoneproject2/components/background.dart';
import 'package:capstoneproject2/Screens/SignUpEmail/components/signup_FromEmail.dart';

    class SignUpEmailScreen extends StatelessWidget {
      const SignUpEmailScreen({Key? key}) : super(key: key);

      @override
      Widget build(BuildContext context) {
        return Background(
            child: SingleChildScrollView(
              child: Responsive(
                  mobile: const MobileSignupEmailScreen(),
                  desktop: Row(
                      children: [
                        const Expanded(
                          child: SignUpScreenTopImage(),
                        ),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                    SizedBox(
                      width: 450,
                      child: SignUpEmail(),
                        ),
                      ]
                    )
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
    class MobileSignupEmailScreen extends StatelessWidget {
      const MobileSignupEmailScreen({Key? key}) : super(key: key);

      @override
      Widget build(BuildContext context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SignUpScreenTopImage(),
              Row(
                children: const [
                  Spacer(),
                  Expanded(
                    flex: 8,
                    child: SignUpEmail(),
                  ),
                  Spacer(),
                  // Expanded(
                  //   flex: 8,
                  //   child: SignUpFormEmail(),
                  // )
                ],
              ),
            ]
        );
      }
    }

