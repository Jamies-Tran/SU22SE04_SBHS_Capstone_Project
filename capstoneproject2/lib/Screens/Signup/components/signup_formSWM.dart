
import 'package:capstoneproject2/locator/service_locator.dart';
import 'package:capstoneproject2/model/error_handler_model.dart';
import 'package:capstoneproject2/model/passenger_model.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/avd.dart';
import 'package:capstoneproject2/components/datePickerDOB.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/radiobutton.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import 'package:capstoneproject2/components/checkboxbutton.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {

    var username = "";
    var password = "";
    var address = "";
    var gender = "";
    var email = "";
    var phone = "";
    var citizenIdentification = "";
    var dob = "";

    final _passengerService = locator.get<IPassengerService>();

    // This function is triggered when the button is clicked

    return Form(

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
              obscureText: true,
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
              children: [
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
            children: [
              const CheckBoxButton(),
              Text("I agree with condition and your terms")
            ],
          ),

          // Column(
          //     children: [
          //       Row(
          //         children: [
          //           Material(
          //             child: Checkbox(
          //               value: agree,
          //               onChanged: (value) {
          //                 setState(() {
          //                   agree = value == false;
          //                 });
          //               },
          //             ),
          //           ),
          //           const Text(
          //             'I have read and accept terms and conditions',
          //             overflow: TextOverflow.ellipsis,
          //           )
          //         ],
          //       ),
          //     ]),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () async {
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
                dynamic registerPassenger = await _passengerService.signUpWithSWMAccount(passengerModel);
                if(registerPassenger is PassengerModel) {
                  print("Username: ${registerPassenger.username}" );
                } else if(registerPassenger is ErrorHandlerModel) {
                  print("Message: ${registerPassenger.message}");
                }
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
                    return const LoginScreen();
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


// class SignUpForm extends StatelessWidget {
//   // final bool agree = false;
//
//   const SignUpForm({Key? key}) : super(key: key);
//
//   // bool agree = false;
//   @override
//   Widget build(BuildContext context) {
//
//     var username = "";
//     var password = "";
//     var address = "";
//     var gender = "";
//     var email = "";
//     var phone = "";
//     var citizenIdentification = "";
//     var dob = "";
//
//     // This function is triggered when the button is clicked
//
//     return Form(
//
//       child: Column(
//
//         children: [
//           TextFormField(
//             keyboardType: TextInputType.emailAddress,
//             textInputAction: TextInputAction.next,
//             cursorColor: kPrimaryColor,
//             onChanged: (value) {
//
//             },
//             decoration: const InputDecoration(
//               hintText: "User name",
//               prefixIcon: Padding(
//                 padding: EdgeInsets.all(defaultPadding),
//                 child: Icon(Icons.person),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: defaultPadding),
//             child: TextFormField(
//               textInputAction: TextInputAction.done,
//               obscureText: true,
//               cursorColor: kPrimaryColor,
//               decoration: const InputDecoration(
//                 hintText: "Your password",
//                 prefixIcon: Padding(
//                   padding: EdgeInsets.all(defaultPadding),
//                   child: Icon(Icons.lock),
//                 ),
//               ),
//             ),
//           ),
//           TextFormField(
//             keyboardType: TextInputType.streetAddress,
//             textInputAction: TextInputAction.next,
//             cursorColor: kPrimaryColor,
//             onSaved: (email) {},
//             decoration: const InputDecoration(
//               hintText: "Address",
//               prefixIcon: Padding(
//                 padding: EdgeInsets.all(defaultPadding),
//                 child: Icon(Icons.person),
//               ),
//             ),
//           ),
//           const SizedBox(height: defaultPadding / 2),
//           TextFormField(
//             keyboardType: TextInputType.text,
//             textInputAction: TextInputAction.next,
//             cursorColor: kPrimaryColor,
//             onSaved: (email) {},
//             decoration: const InputDecoration(
//               hintText: "Gender",
//               prefixIcon: Padding(
//                 padding: EdgeInsets.all(defaultPadding),
//                 child: Icon(Icons.person),
//               ),
//             ),
//           ),
//           const SizedBox(height: defaultPadding / 2),
//           TextFormField(
//             keyboardType: TextInputType.emailAddress,
//             textInputAction: TextInputAction.next,
//             cursorColor: kPrimaryColor,
//             onSaved: (email) {},
//             decoration: const InputDecoration(
//               hintText: "Email",
//               prefixIcon: Padding(
//                 padding: EdgeInsets.all(defaultPadding),
//                 child: Icon(Icons.person),
//               ),
//             ),
//           ),
//           const SizedBox(height: defaultPadding / 2),
//           TextFormField(
//             keyboardType: TextInputType.phone,
//             textInputAction: TextInputAction.next,
//             cursorColor: kPrimaryColor,
//             onSaved: (email) {},
//             decoration: const InputDecoration(
//               hintText: "Phone",
//               prefixIcon: Padding(
//                 padding: EdgeInsets.all(defaultPadding),
//                 child: Icon(Icons.person),
//               ),
//             ),
//           ),
//           const SizedBox(height: defaultPadding / 2),
//           TextFormField(
//             keyboardType: TextInputType.number,
//             textInputAction: TextInputAction.next,
//             cursorColor: kPrimaryColor,
//             onSaved: (email) {},
//             decoration: const InputDecoration(
//               hintText: "Citizen Identification",
//               prefixIcon: Padding(
//                 padding: EdgeInsets.all(defaultPadding),
//                 child: Icon(Icons.person),
//               ),
//             ),
//           ),
//           const SizedBox(height: defaultPadding / 2),
//           TextFormField(
//             keyboardType: TextInputType.datetime,
//             textInputAction: TextInputAction.next,
//             cursorColor: kPrimaryColor,
//             onSaved: (email) {},
//             decoration: const InputDecoration(
//               hintText: "Day of birth",
//               prefixIcon: Padding(
//                 padding: EdgeInsets.all(defaultPadding),
//                 child: Icon(Icons.person),
//               ),
//             ),
//           ),
//           const SizedBox(height: defaultPadding/2),
//           // Column(
//           //     children: [
//           //       Row(
//           //         children: [
//           //           Material(
//           //             child: Checkbox(
//           //               value: agree,
//           //               onChanged: (value) {
//           //                 setState(() {
//           //                   agree = value == false;
//           //                 });
//           //               },
//           //             ),
//           //           ),
//           //           const Text(
//           //             'I have read and accept terms and conditions',
//           //             overflow: TextOverflow.ellipsis,
//           //           )
//           //         ],
//           //       ),
//           //     ]),
//           const SizedBox(height: defaultPadding / 2),
//           ElevatedButton(
//             onPressed: () {},
//             child: Text("Sign Up".toUpperCase()),
//           ),
//
//           const SizedBox(height: defaultPadding),
//           AlreadyHaveAnAccountCheck(
//             login: false,
//             press: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) {
//                     return const LoginScreen();
//                   },
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }