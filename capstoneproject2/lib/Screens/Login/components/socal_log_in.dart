import 'package:flutter/material.dart';

import '../../../screens/Signup/components/or_divider.dart';
import '../../../screens/Signup/components/social_icon.dart';

class SocalLogin extends StatelessWidget {
  const SocalLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OrDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SocalIcon(
              iconSrc: "assets/icons/gmail.svg",
              press: () {},

            ),
            TextButton(
              onPressed: (){},
              child: Text('Login with email'),
            ),
          ],
        ),
      ],
    );
  }
}
