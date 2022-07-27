import 'package:capstoneproject2/constants.dart';
import 'package:flutter/material.dart';
class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.email_outlined),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding /2  ),

          ElevatedButton(
              onPressed: () async{
              },
              child: Text("Send OTP".toUpperCase()),
          ),
        ],
      ),
    );
  }
}
