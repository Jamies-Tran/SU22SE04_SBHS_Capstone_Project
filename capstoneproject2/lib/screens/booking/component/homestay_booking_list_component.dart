import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/screens/booking/booking_detail_screen.dart';
import 'package:capstoneproject2/services/booking_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/booking_model.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomestayBookingListComponent extends StatelessWidget {
  const HomestayBookingListComponent({
    Key? key,
    this.homestayName,
    this.status,
    this.email
  }) : super(key: key);
  final String? homestayName;
  final String? status;
  final String? email;

  @override
  Widget build(BuildContext context) {
    final bookingService = locator<IBookingService>();
    final firebaseAuth = FirebaseAuth.instance;
    final currencyFormat = NumberFormat("#,##0");
    final dateFormat = DateFormat("yyyy-MM-dd");
    int getDaysRemaining(DateTime checkIn) {
      return checkIn.difference(DateTime.now()).inDays;
    }

    return FutureBuilder(
        future: bookingService.getHomestayBookingList(homestayName!, status!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitComponent();
          }else if(snapshot.hasData) {
            var snapshotData = snapshot.data;
            if(snapshotData is List<BookingModel>) {
              List<BookingModel> getBookingListOfUser = snapshotData.where(
                      (element) => element.passengerName.compareTo(firebaseAuth.currentUser!.displayName!) == 0).toList();
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: getBookingListOfUser.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDetailsScreen(bookingId: getBookingListOfUser[index].id, email: email),))
                      },
                      child: Container(
                        height: 170,
                        width: 250,
                        margin: const EdgeInsets.only(top: 20),
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
                        child: Column (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${getBookingListOfUser[index].homestayName}", style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'OpenSans',
                                letterSpacing: 1.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold
                            )),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                const Text("From:", style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.0,
                                  color: Colors.black87,
                                )),
                                const SizedBox(width: 10,),
                                const Icon(Icons.calendar_month_sharp, color: kPrimaryLightColor, size: 17,),
                                Text("${getBookingListOfUser[index].checkIn}", style: const TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.0,
                                  color: Colors.black87,
                                )),

                                const SizedBox(width: 30,),

                                const Text("To:", style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.0,
                                  color: Colors.black87,
                                )),
                                const SizedBox(width: 10,),
                                const Icon(Icons.calendar_month_sharp, color: kPrimaryLightColor, size: 17,),
                                Text("${getBookingListOfUser[index].checkOut}", style: const TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.0,
                                  color: Colors.black87,
                                )),
                              ],
                            ),

                            const SizedBox(height: 5,),

                            Row(
                              children: [
                                const Text("Total:", style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.0,
                                  color: Colors.black87,
                                )),
                                const SizedBox(width: 5,),
                                Text("${currencyFormat.format(getBookingListOfUser[index].totalPrice)} VND", style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.0,
                                  color: Colors.black87,
                                )),
                                const SizedBox(width: 5,),
                                const Text("-", style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.0,
                                  color: Colors.black87,
                                )),
                                const SizedBox(width: 5,),
                                const Text("Deposit:", style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.0,
                                  color: Colors.black87,
                                )),
                                const SizedBox(width: 10,),
                                Text("${currencyFormat.format(getBookingListOfUser[index].deposit)} VND", style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.0,
                                  color: Colors.black87,
                                )),
                              ],
                            ),

                            const SizedBox(height: 5,),

                            Row(
                              children: [
                                Text("Status: ${getBookingListOfUser[index].status}", style: const TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.0,
                                  color: Colors.black87,
                                )),

                              ],
                            ),

                            const SizedBox(height: 10,),

                            Row(
                              children: [
                                const Icon(Icons.access_alarms_sharp, color: Colors.green, size: 20,),
                                const SizedBox(width: 10,),
                                const Text("Your booking will start in ", style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.0,
                                  color: Colors.black87,
                                )),
                                Text(getDaysRemaining(dateFormat.parse(getBookingListOfUser[index].checkIn)) == 0 ? "today" : getDaysRemaining(dateFormat.parse(getBookingListOfUser[index].checkIn)) == 1 ? "tomorrow" : "${getDaysRemaining(dateFormat.parse(getBookingListOfUser[index].checkIn))} days", style: const TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.0,
                                  color: Colors.black87,
                                )),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
              );
            }else if(snapshotData is ErrorHandlerModel) {
              return Center(child: Text("Something went wrong - ${snapshotData.message}"),);
            }
          }

          return const Center(child: Text("Something went wrong"),);
        },
    );
  }
}
