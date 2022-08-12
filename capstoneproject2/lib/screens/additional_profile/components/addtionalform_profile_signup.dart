import 'package:capstoneproject2/components/datePickerDOB.dart';

import 'package:capstoneproject2/navigator/google_sign_in_navigator.dart';
import 'package:capstoneproject2/screens/home_page/home_page_screen.dart';

import 'package:capstoneproject2/services/model/passenger_model.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../constants.dart';
import 'package:capstoneproject2/components/radiobutton.dart';

class AdditionalProfileFormSignUp extends StatefulWidget {
  const AdditionalProfileFormSignUp({Key? key, this.googleSignInAccount, this.isSignInFromBookingScreen, this.homestayName}) : super(key: key);
  final GoogleSignInAccount? googleSignInAccount;
  final bool? isSignInFromBookingScreen;
  final String? homestayName;

  @override
  State<AdditionalProfileFormSignUp> createState() => _AdditionalProfileFormSignUpState();
}

class _AdditionalProfileFormSignUpState extends State<AdditionalProfileFormSignUp> {
  late String gender;
  final _mailTextEditingController = TextEditingController();
  final _usernameTextEditingController = TextEditingController();
  final _addressTextEditingController = TextEditingController();
  final _phoneTextEditingController = TextEditingController();
  final _genderTextEditingController = TextEditingController();
  final _citizenIdentificationTextEditingController = TextEditingController();
  final _dobTextEditingController = TextEditingController();
  var isErrorOccur = false;
  var errorMsg = "";
  // final _passengerService = locator.get<IPassengerService>();
  // final _authService = locator.get<IAuthenticateService>();

  @override
  void initState() {
    _mailTextEditingController.text = widget.googleSignInAccount!.email!;
    _usernameTextEditingController.text = widget.googleSignInAccount!.displayName!;
    super.initState();
  }

  @override
  void dispose() {
    _mailTextEditingController.dispose();
    _usernameTextEditingController.dispose();
    _addressTextEditingController.dispose();
    _phoneTextEditingController.dispose();
    _genderTextEditingController.dispose();
    _citizenIdentificationTextEditingController.dispose();
    _dobTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
          children: <Widget> [
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _usernameTextEditingController,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Username",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),

            const SizedBox(height: 20),
            TextFormField(
              controller: _mailTextEditingController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              readOnly: true,
              // onFieldSubmitted: (value) {
              //   email = value;
              // },
              decoration: const InputDecoration(
                hintText: "Email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email_rounded),
                ),
              ),
            ),

            const SizedBox(height: 20),
            TextFormField(
              controller: _addressTextEditingController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              // onChanged: (value) {
              //   address = value;
              // },
              decoration: const InputDecoration(
                hintText: "Address",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.streetview),
                ),
              ),
            ),

            const SizedBox(height: 20),
            TextFormField(
              controller: _phoneTextEditingController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              // onChanged: (value) {
              //   setState(() {
              //     phone = value;
              //   });
              // },
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

            const SizedBox(height: 20),
            TextFormField(
              controller: _citizenIdentificationTextEditingController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              // onChanged: (value) {
              //   citizenIdentification = value;
              // },
              decoration: const InputDecoration(
                hintText: "Citizen Identification",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.contacts_outlined),
                ),
              ),
            ),

            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: Row(
                children: const [
                  Icon(Icons.accessibility),
                  Text("Gender"),
                ],
              ),
            ),

            const SizedBox(
              height: 115 ,
              child: Center(
                child: RadioButtonOnlyOne(),
              ),
            ),

            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: Row(
                children: const [
                  Icon(Icons.date_range_outlined),
                  Text("Day of birth"),
                ],
              ),
            ),

            Center(
              child: CupertinoDateDOB(),
            ),

            const SizedBox(height: 20),

            isErrorOccur ? Center(child: Text(errorMsg,style: const TextStyle(
                fontSize: 10,
                fontFamily: 'OpenSans',
                letterSpacing: 1.0,
                color: Colors.red,
                fontWeight: FontWeight.bold
            )),) : const SizedBox(),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                gender = character.toString().split(".").last;
                PassengerModel passengerModel = PassengerModel(
                  username: _usernameTextEditingController.text,
                  email: _mailTextEditingController.text,
                  address: _addressTextEditingController.text,
                  phone: _phoneTextEditingController.text,
                  dob: dateValue,
                  gender: gender,
                  citizenIdentificationString: _citizenIdentificationTextEditingController.text,
                  avatarUrl: widget.googleSignInAccount!.photoUrl
                );

                Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleSignInNavigator(googleSignInAccount: widget!.googleSignInAccount, passengerModel: passengerModel,homestayName: widget.homestayName, isSignInFromBookingScreen: widget.isSignInFromBookingScreen),));
              },
              child: Text("Complete Sign Up".toUpperCase()),
            ),
            TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePageScreen())),
                child: const Text("Cancel", style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'OpenSans',
                    letterSpacing: 1.0,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline
                )),

            )
          ],
        ),
    );
  }
}
