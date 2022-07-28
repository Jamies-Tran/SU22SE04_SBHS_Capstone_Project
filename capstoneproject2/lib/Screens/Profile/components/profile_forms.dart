import 'package:capstoneproject2/components/datePickerDOB.dart';
import 'package:capstoneproject2/components/radiobutton.dart';
import 'package:capstoneproject2/constants.dart';
import 'package:flutter/material.dart';

class ProfileInformationForms extends StatefulWidget {
  const ProfileInformationForms({Key? key}) : super(key: key);

  @override
  State<ProfileInformationForms> createState() => _ProfileInformationFormsState();
}

class _ProfileInformationFormsState extends State<ProfileInformationForms> {
  final myController = TextEditingController();
  bool enabled = false;
  String? CupertinoDateDOB;
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
  void intl1(){
    setState(() {
      enabled = true;
    });
  }
  @override
  Widget build(BuildContext context) {


     return Form(
         child: Column(
           children:<Widget> [
             TextFormField(
               keyboardType: TextInputType.text,
               textInputAction: TextInputAction.next,
               cursorColor: kPrimaryColor,
               onChanged: (value) {
               },
               decoration: InputDecoration(
                 labelText: "Username",
                 prefixIcon: Padding(
                   padding: const EdgeInsets.all(defaultPadding),
                   child: Icon(Icons.person),
                 ),
               ),
               enabled: false,
               controller: myController,
             ),
             const SizedBox(height: defaultPadding / 2),
             Padding(
               padding: const EdgeInsets.symmetric(vertical: defaultPadding),
               child: TextFormField(
                 textInputAction: TextInputAction.done,
                 obscureText: true,
                 cursorColor: kPrimaryColor,
                 onChanged: (value) {
                   // password = value;
                 },
                 decoration: const InputDecoration(
                   labelText: "Your password",
                   prefixIcon: Padding(
                     padding: EdgeInsets.all(defaultPadding),
                     child: Icon(Icons.lock),
                   ),
                 ),
                 enabled: false,
                 controller: myController,
               ),
             ),
             const SizedBox(height: defaultPadding / 2),

             TextFormField(
               keyboardType: TextInputType.streetAddress,
               textInputAction: TextInputAction.next,
               cursorColor: kPrimaryColor,
               onSaved: (email) {},
               decoration: InputDecoration(
                 labelText: "Address",
                 prefixIcon: Padding(
                   padding: const EdgeInsets.all(defaultPadding),
                   child: Icon(Icons.streetview),
                 ),
               ),
               enabled: false,
               controller: myController,
             ),
             const SizedBox(height: defaultPadding / 2),

             TextFormField(
               keyboardType: TextInputType.phone,
               textInputAction: TextInputAction.next,
               cursorColor: kPrimaryColor,
               onChanged: (value) {
               },
               decoration: const InputDecoration(
                 labelText: "Phone",
                 prefixIcon: Padding(
                   padding: EdgeInsets.all(defaultPadding),
                   child: Icon(
                     Icons.phone_android,
                   ),
                 ),
               ),
               enabled: false,
               controller: myController,
             ),
             const SizedBox(height: defaultPadding / 2),

             TextFormField(
               keyboardType: TextInputType.number,
               textInputAction: TextInputAction.next,
               cursorColor: kPrimaryColor,
               onChanged: (value) {
               },
               decoration: const InputDecoration(
                 labelText: "Citizen Identification",
                 prefixIcon: Padding(
                   padding: EdgeInsets.all(defaultPadding),
                   child: Icon(Icons.contacts_outlined),
                 ),
               ),
               enabled: false,
               controller: myController,
             ),
             const SizedBox(height: defaultPadding / 2),
             TextFormField(
               keyboardType: TextInputType.number,
               textInputAction: TextInputAction.next,
               cursorColor: kPrimaryColor,
               onChanged: (value) {
               },
               decoration: const InputDecoration(
                 labelText: "Gender",
                 prefixIcon: Padding(
                   padding: EdgeInsets.all(defaultPadding),
                   child: Icon(Icons.contacts_outlined),
                 ),
               ),
               enabled: false,
               controller: myController,
             ),
             TextFormField(
               keyboardType: TextInputType.number,
               textInputAction: TextInputAction.next,
               cursorColor: kPrimaryColor,
               onChanged: (value) {
               },
               decoration: const InputDecoration(
                 labelText: "Day of birth",
                 prefixIcon: Padding(
                   padding: EdgeInsets.all(defaultPadding),
                   child: Icon(Icons.contacts_outlined),
                 ),
               ),
               enabled: false,
               controller: myController,
             ),
             const SizedBox(height: defaultPadding / 2),
             ElevatedButton(
               onPressed: () {},
               child: Text("Edit profile".toUpperCase()),
             ),

           ],
         ),
     );
  }
}
