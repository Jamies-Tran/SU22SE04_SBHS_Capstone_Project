import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/checkboxbutton.dart';
import '../../../components/radiobutton.dart';
import '../../../constants.dart';
import 'package:capstoneproject2/Screens/Login/login_screen.dart';
import 'package:capstoneproject2/components/datePickerDOB.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class SignUpEmail extends StatelessWidget {
  const SignUpEmail({Key? key}) : super(key: key);
  static const String _title = 'Gender';
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
                hintText: "Email",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
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
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              decoration: InputDecoration(
                hintText: "Address",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.streetview),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            Row(
              children: [
                Icon(Icons.accessibility),
                Text("Gender"),
              ],
            ),
            Center(
              child: RadioButtonOnlyOne(),
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Icon(Icons.date_range_outlined),
                  Text("Day of birth"),
                ],
              ),
            ),
            Center(
              child: CupertinoDateDOB(),
            ),

            const SizedBox(height: defaultPadding / 2),
            TextFormField(
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onChanged: (value) {
              },
              decoration: const InputDecoration(
                hintText: "Phone",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(
                    Icons.phone_android,
                  ),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onChanged: (value) {
              },
              decoration: const InputDecoration(
                hintText: "Citizen Identification",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.contacts_outlined),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            Row(
              children: [
                const CheckBoxButton(),
                Linkify(
                    onOpen: (link) => print("Clicked ${link.url}!"),
                    text: "I agree https://www.garena.vn/terms ")
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text("Sign Up".toUpperCase()),
            ),

            const SizedBox(height: defaultPadding),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
    );
  }
}
