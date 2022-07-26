import 'package:capstoneproject2/components/datePickerDOB.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:capstoneproject2/components/radiobutton.dart';

class AddtionalProfileFormSignUp extends StatefulWidget {
  const AddtionalProfileFormSignUp({Key? key}) : super(key: key);

  @override
  State<AddtionalProfileFormSignUp> createState() => _AddtionalProfileFormSignUpState();
}

class _AddtionalProfileFormSignUpState extends State<AddtionalProfileFormSignUp> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
          children: <Widget> [
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              decoration: InputDecoration(
                hintText: "Username",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email_rounded),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
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
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Icon(Icons.accessibility),
                  Text("Gender"),
                ],
              ),
            ),

            SizedBox(
              height: 115 ,
              child: Center(
                child: const RadioButtonOnlyOne(),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
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

            ElevatedButton(
              onPressed: () {},
              child: Text("Complete Sign Up".toUpperCase()),
            ),
          ],
        ),
    );
  }
}
