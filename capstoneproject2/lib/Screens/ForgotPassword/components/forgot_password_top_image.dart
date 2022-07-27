import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class ForgotPasswordScreenTopImage extends StatelessWidget {
  const ForgotPasswordScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Forgot Password".toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: defaultPadding),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset("assets/icons/forgotpassword.svg"),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding),

      ],
    );
  }
}
