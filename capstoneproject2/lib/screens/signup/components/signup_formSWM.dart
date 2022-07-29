import 'package:capstoneproject2/navigator/swm_sign_up_navigator.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/passenger_model.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:flutter/material.dart';
import 'package:capstoneproject2/components/datePickerDOB.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/radiobutton.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import 'package:capstoneproject2/components/checkboxbutton.dart';

class SignUpSWMForm extends StatefulWidget {
  SignUpSWMForm({Key? key}) : super(key: key);


  @override
  State<SignUpSWMForm> createState() => _SignUpSWMFormState();
}

class _SignUpSWMFormState extends State<SignUpSWMForm> {
  @override
  Widget build(BuildContext context) {

    var username;
    var password;
    var address;
    var gender;
    var email;
    var phone;
    var citizenIdentification;
    var dob;

    final _passengerService = locator.get<IPassengerService>();

    return SingleChildScrollView(
      child: Material(
        child: Form(

          child: Column(

            children: [

              TextFormField(

                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onChanged: (value) {
                  username = value;
                },
                decoration: const InputDecoration(
                  hintText: "User name",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  cursorColor: kPrimaryColor,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: const InputDecoration(
                    hintText: "Your password",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.lock),
                    ),
                  ),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onChanged: (value) {
                  address = value;
                },
                decoration: const InputDecoration(
                  hintText: "Address",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.streetview),
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding / 2),
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
                    child: RadioButtonOnlyOne()
                ),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onChanged: (value) {
                  email = value;
                },
                decoration: const InputDecoration(
                  hintText: "Email",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.email_rounded),
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onChanged: (value) {
                  phone = value;
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
                  citizenIdentification = value;
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
                  children: const [
                    Icon(Icons.date_range_outlined),
                    Text("Day of birth"),
                  ],
                ),
              ),
              Center(
                child: CupertinoDateDOB(),
              ),
              const SizedBox(height: defaultPadding/2),
              Row(
                children: const [
                  CheckBoxButton(),
                  Text("I agree with condition and your terms")
                ],
              ),
              const SizedBox(height: defaultPadding / 2),
              ElevatedButton(
                onPressed: () {
                  gender = character.toString();
                  gender = gender.split(".").last;
                  dob = dateValue;
                  PassengerModel passengerModel = PassengerModel(
                      username: username,
                      password: password,
                      email: email,
                      phone: phone,
                      gender: gender,
                      dob: dob,
                      address: address,
                      citizenIdentificationString: citizenIdentification,
                      avatarUrl: "firstImageExm1"
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SwmSignUpNavigator(swmSignUpFuture: _passengerService.signUpWithSWMAccount(passengerModel)))
                  );
                },
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
        ),
      ),
    );
  }
}