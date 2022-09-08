import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/navigator/booking_check_in_navigator.dart';
import 'package:capstoneproject2/screens/home_page/home_page_screen.dart';
import 'package:capstoneproject2/screens/homestay_detail/component/homestay_details_body.dart';
import 'package:capstoneproject2/screens/homestay_detail/component/homestay_details_top.dart';
import 'package:capstoneproject2/services/homestay_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/homestay_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomestayDetailsScreen extends StatefulWidget {
  const HomestayDetailsScreen({
    Key? key,
    this.homestayName
  }) : super(key: key);
  final String? homestayName;
  @override
  State<HomestayDetailsScreen> createState() => _HomestayDetailsScreenState();
}

class _HomestayDetailsScreenState extends State<HomestayDetailsScreen> {
  final firebaseAuth = FirebaseAuth.instance;
  final otpTextFieldController = TextEditingController();
  @override
  void dispose() {
    otpTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final homestayService = locator.get<IHomestayService>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePageScreen(),))),
        title: const Text("Details", style: TextStyle(
            fontSize: 15,
            fontFamily: 'OpenSans',
            letterSpacing: 3.0,
            color: Colors.black87,
            fontWeight: FontWeight.bold
        )),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: (){
              showDialog(context: context, builder: (context) => AlertDialog(
                title: const Center(child: Text("Enter booking Otp"),),
                content: TextField(
                  controller: otpTextFieldController,
                  readOnly: true,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(icon: const Icon(Icons.safety_check, color: Colors.green,),
                        onPressed: () {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => BookingCheckInNavigator(bookingOtp: otpTextFieldController.text, bookingId: snapshotData.id, username: firebaseAuth.currentUser!.displayName),));
                        },)
                  ),
                ),
                actions: [
                  ElevatedButton(onPressed: () {
                    Navigator.pop(context);
                  }
                      , child: const Text("Cancel")
                  )
                ],
              ),);
            },
            child: Text("booking-otp".toUpperCase(), style: const TextStyle(
                fontFamily: 'OpenSans',
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),),
          )
        ],
        backgroundColor: kPrimaryColor,
      ),
      body: FutureBuilder(
        future: homestayService.findHomestayByName(widget.homestayName!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Just a minute...", style: TextStyle(
                fontSize: 15,
                fontFamily: 'OpenSans',
                letterSpacing: 3.0,
                color: Colors.black87,
                fontWeight: FontWeight.bold
            )));
          } else if(snapshot.hasData) {
            final snapshotData = snapshot.data;
            if(snapshotData is HomestayModel) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  height: 3000,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 340,
                        width: double.infinity,
                        child: HomestayDetailsTop(homestayImages: snapshotData.homestayImages),
                      ),
                      HomestayDetailsBody(homestayModel: snapshotData,)
                    ],
                  ),
                ),
              );
            }
          }

          return const HomePageScreen();
        },
      ),
    );
  }
}


// class HomestayDetailsScreen extends StatelessWidget {
//   const HomestayDetailsScreen({Key? key, required this.homestayName}) : super(key: key);
//   final homestayName;
//
//
//   @override
//   Widget build(BuildContext context) {
//     final homestayService = locator.get<IHomestayService>();
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePageScreen(),))),
//         title: const Text("Details", style: TextStyle(
//             fontSize: 15,
//             fontFamily: 'OpenSans',
//             letterSpacing: 3.0,
//             color: Colors.black87,
//             fontWeight: FontWeight.bold
//         )),
//         centerTitle: false,
//         actions: [
//           TextButton(
//             onPressed: (){
//               showDialog(context: context, builder: (context) => AlertDialog(
//                 title: const Center(child: Text("Enter booking Otp"),),
//                 content: TextField(
//                   controller: otpTextFieldController,
//                   readOnly: true,
//                   decoration: InputDecoration(
//                       suffixIcon: IconButton(icon: const Icon(Icons.safety_check, color: Colors.green,),
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => BookingCheckInNavigator(bookingOtp: snapshotData.bookingOtp, bookingId: snapshotData.id, username: firebaseAuth.currentUser!.displayName),));
//                         },)
//                   ),
//                 ),
//                 actions: [
//                   ElevatedButton(onPressed: () {
//                     Navigator.pop(context);
//                   }
//                       , child: const Text("Cancel")
//                   )
//                 ],
//               ),);
//             },
//             child: Text("booking-otp".toUpperCase(), style: const TextStyle(
//                 fontFamily: 'OpenSans',
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold
//             ),),
//           )
//         ],
//         backgroundColor: kPrimaryColor,
//       ),
//       body: FutureBuilder(
//           future: homestayService.findHomestayByName(homestayName),
//           builder: (context, snapshot) {
//             if(snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: Text("Just a minute...", style: TextStyle(
//               fontSize: 15,
//               fontFamily: 'OpenSans',
//               letterSpacing: 3.0,
//               color: Colors.black87,
//                   fontWeight: FontWeight.bold
//               )));
//             } else if(snapshot.hasData) {
//               final snapshotData = snapshot.data;
//               if(snapshotData is HomestayModel) {
//                 return SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: SizedBox(
//                     height: 3000,
//                     width: double.infinity,
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 340,
//                           width: double.infinity,
//                           child: HomestayDetailsTop(homestayImages: snapshotData.homestayImages),
//                         ),
//                         HomestayDetailsBody(homestayModel: snapshotData,)
//                       ],
//                     ),
//                   ),
//                 );
//               }
//             }
//
//             return const HomePageScreen();
//           },
//       ),
//     );
//   }
// }
