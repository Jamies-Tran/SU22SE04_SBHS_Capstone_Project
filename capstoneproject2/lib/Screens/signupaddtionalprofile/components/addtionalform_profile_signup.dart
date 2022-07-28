import 'package:capstoneproject2/components/datePickerDOB.dart';
import 'package:capstoneproject2/locator/service_locator.dart';
import 'package:capstoneproject2/model/error_handler_model.dart';
import 'package:capstoneproject2/model/passenger_model.dart';
import 'package:capstoneproject2/navigator_screen/google_sign_in_navigator.dart';
import 'package:capstoneproject2/services/auth_service.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../constants.dart';
import 'package:capstoneproject2/components/radiobutton.dart';

import '../../../navigator_screen/component/dialog_component.dart';


class AdditionalProfileFormSignUp extends StatefulWidget {
  AdditionalProfileFormSignUp({Key? key, this.googleSignInAccount}) : super(key: key);
  GoogleSignInAccount? googleSignInAccount;

  final _passengerService = locator.get<IPassengerService>();
  final _authService = locator.get<IAuthenticateService>();

  @override
  State<AdditionalProfileFormSignUp> createState() => _AdditionalProfileFormSignUpState();
}

class _AdditionalProfileFormSignUpState extends State<AdditionalProfileFormSignUp> {

  var _username;
  var _password;
  var _email;
  var _address;
  var _phone;
  var _gender;
  var _citizenIdentification;
  var _dob;

  final _textEditingMailController = TextEditingController();

  final _textEditingUsernameController = TextEditingController();

  @override
  void initState() {
    _textEditingMailController.text = widget.googleSignInAccount!.email.toString();
    _textEditingUsernameController.text = widget.googleSignInAccount!.displayName.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
          children: <Widget> [
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _textEditingUsernameController,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
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
              controller: _textEditingMailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              readOnly: true,
              onFieldSubmitted: (value) {
                _email = value;
              },
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
              onChanged: (value) {
                _address = value;
              },
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
                setState(() {
                  _phone = value;
                });
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
                _citizenIdentification = value;
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
              onPressed: () async {
                _email = _textEditingMailController.text;
                _username = _textEditingUsernameController.text;
                print("email in additional profile: ${_email}");
                print("username in additional profile: ${_username}");
                _dob = dateValue;
                _gender = character.toString().split(".").last;
                PassengerModel passengerModel = PassengerModel(
                  username: _username,
                  email: _email,
                  address: _address,
                  phone: _phone,
                  dob: _dob,
                  gender: _gender,
                  citizenIdentificationString: _citizenIdentification,
                  avatarUrl: widget.googleSignInAccount?.photoUrl
                );
                final _confirmLogin = await widget._passengerService.signUpWithGoogleAccount(passengerModel, widget.googleSignInAccount);
                if(_confirmLogin is PassengerModel) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleSignInNavigator(googleSignInFuture: widget._authService.loginByGoogleAccount(widget.googleSignInAccount))));
                } else if(_confirmLogin is ErrorHandlerModel) {
                  showDialog(context: context, builder: (context) {
                    return DialogComponent(message: _confirmLogin.message);
                  },);
                }
              },
              child: Text("Complete Sign Up".toUpperCase()),
            ),
          ],
        ),
    );
  }
}
