import 'package:capstoneproject2/Screens/ForgotPassword/forgot_password_screen.dart';
import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

// class LoginForm extends StatefulWidget {
//   LoginForm({Key? key, this.emailAfterSignUpSuccess}) : super(key: key);
//   String? emailAfterSignUpSuccess;
//
//   @override
//   State<LoginForm> createState() => _LoginFormState();
// }
//
// class _LoginFormState extends State<LoginForm> {
//   @override
//   Widget build(BuildContext context) {
//
//     return Material(
//       child: Form(
//         child: Column(
//           children: [
//             TextFormField(
//               keyboardType: TextInputType.emailAddress,
//               textInputAction: TextInputAction.next,
//               cursorColor: kPrimaryColor,
//               initialValue: widget.emailAfterSignUpSuccess ?? '',
//               onSaved: (email) {},
//               decoration: InputDecoration(
//                 hintText: "Your email",
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.all(defaultPadding),
//                   child: Icon(Icons.person),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: defaultPadding),
//               child: TextFormField(
//                 textInputAction: TextInputAction.done,
//                 obscureText: true,
//                 cursorColor: kPrimaryColor,
//                 decoration: InputDecoration(
//                   hintText: "Your password",
//                   prefixIcon: Padding(
//                     padding: const EdgeInsets.all(defaultPadding),
//                     child: Icon(Icons.lock),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: defaultPadding),
//             Hero(
//               tag: "login_btn",
//               child: ElevatedButton(
//                 onPressed: () {},
//                 child: Text(
//                   "Login".toUpperCase(),
//                 ),
//               ),
//             ),
//             const SizedBox(height: defaultPadding),
//             AlreadyHaveAnAccountCheck(
//               press: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return SignUpScreen();
//                     },
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
// }


class LoginForm extends StatelessWidget {
  LoginForm({Key? key, this.emailAfterSignUpSuccess}) : super(key: key);
  String? emailAfterSignUpSuccess;

  @override
  Widget build(BuildContext context) {
    print("Email receive from login: $emailAfterSignUpSuccess");
    return Material(
      child: Form(
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              initialValue: emailAfterSignUpSuccess ?? '',
              onSaved: (email) {},
              decoration: InputDecoration(
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                obscureText: true,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Your password",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),
                  ),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context){
                        return ForgotPasswordScreen();
                      },
                    ),
                  );
                },
                style: TextButton.styleFrom(primary: kPrimaryLightColor, elevation: 0),
                child: Text(
                  "Forgot Password ".toUpperCase(),
                  style: TextStyle(color: Colors.black),
                ),
            ),
            const SizedBox(height: defaultPadding),

            Hero(
              tag: "login_btn",
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Login".toUpperCase(),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
