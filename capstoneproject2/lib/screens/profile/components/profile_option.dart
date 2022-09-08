import 'package:capstoneproject2/navigator/relative_check_in_navigator.dart';
import 'package:capstoneproject2/screens/profile/wallet_screen.dart';
import 'package:capstoneproject2/services/booking_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

// class ProfileOption extends StatelessWidget {
//   const ProfileOption({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return ListView(
//       scrollDirection: Axis.vertical,
//       shrinkWrap: true,
//       padding: const EdgeInsets.all(20),
//       children: [
//         ListTile(
//           title: const Text("Manage wallet"),
//           focusColor: Colors.purpleAccent,
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletManagementScreen(),));
//           },
//         ),
//
//         const SizedBox(height: 10),
//
//         ListTile(
//           title: const Text("Manage information"),
//           focusColor: Colors.purpleAccent,
//           onTap: () {
//
//           },
//         ),
//
//         const SizedBox(height: 10),
//
//         ListTile(
//           title: const Text("Booking otp"),
//           focusColor: Colors.purpleAccent,
//           onTap: () {
//             showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     title: const Center(child: Text("Booking otp"),),
//                     content: SizedBox(
//                       height: 100,
//                       width: 150,
//                       child: TextField(
//                         controller: otpTextFieldController,
//                         readOnly: true,
//                         decoration: InputDecoration(
//                             suffixIcon: IconButton(icon: const Icon(Icons.safety_check, color: Colors.green,),
//                               onPressed: () {
//                                 //Navigator.push(context, MaterialPageRoute(builder: (context) => BookingCheckInNavigator(bookingOtp: otpTextFieldController.text, bookingId: snapshotData.id, username: firebaseAuth.currentUser!.displayName),));
//                               },)
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

class ProfileOption extends StatefulWidget {
  const ProfileOption({
    this.username,
    Key? key
  }) : super(key: key);
  final String? username;

  @override
  State<ProfileOption> createState() => _ProfileOptionState();
}

class _ProfileOptionState extends State<ProfileOption> {

  final otpTextFieldController = TextEditingController();
  final globalFormKey = GlobalKey<FormState>();
  final bookingService = locator<IBookingService>();
  bool isInputBookingOtp = false;
  late String bookingOtp;
  @override
  void dispose() {

    otpTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      children: [
        ListTile(
          title: const Text("Manage wallet"),
          focusColor: Colors.purpleAccent,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletManagementScreen(),));
          },
        ),

        const SizedBox(height: 10),

        ListTile(
          title: const Text("Manage information"),
          focusColor: Colors.purpleAccent,
          onTap: () {

          },
        ),

        const SizedBox(height: 10),

        ListTile(
          title: const Text("Booking otp"),
          focusColor: Colors.purpleAccent,
          onTap: () {
            setState(() {
              isInputBookingOtp = !isInputBookingOtp;
            });
          },
        ),

        isInputBookingOtp == true ? Container(
          width: 100,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0,3)
                )
              ]
          ),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: otpTextFieldController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Enter your booking otp",
                    prefixIcon: Icon(Icons.add_business_sharp),
                    contentPadding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {

                    });
                  },
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CheckBookingOtpNavigator(username: widget.username, otp: otpTextFieldController.text),));
                        }, child: const Text("Submit")
                    ),
                  )
                ],
              )
            ],
          )
        ) : const SizedBox()
      ],
    );
  }
}
