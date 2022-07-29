
import 'package:capstoneproject2/components/background.dart';
import 'package:capstoneproject2/responsive.dart';
import 'package:capstoneproject2/screens/forgot_password/components/forgot_password_form.dart';
import 'package:capstoneproject2/screens/forgot_password/components/forgot_password_top_image.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background( child: SingleChildScrollView(
      child: Responsive(
        mobile: const MobileForgotPasswordScreen(),
        desktop: Row(
          children: [
            const Expanded(
              child: ForgotPasswordScreenTopImage(),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 10,
                    child: ForgotPasswordForm(),
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
class MobileForgotPasswordScreen extends StatelessWidget {
  const MobileForgotPasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const ForgotPasswordScreenTopImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: ForgotPasswordForm(),
            ),
            Spacer(),
            // Expanded(
            //   flex: 8,
            //   child: SignUpFormEmail(),
            // )
          ],
        ),
      ],
    );
  }
}