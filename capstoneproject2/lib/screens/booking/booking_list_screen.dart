import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/screens/booking/component/homestay_booking_list_component.dart';
import 'package:flutter/material.dart';

class BookingListScreen extends StatelessWidget {
  const BookingListScreen({
    Key? key,
    this.homestayName,
    this.email
  }) : super(key: key);
  final String? homestayName;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking list"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 700,
              child: HomestayBookingListComponent(homestayName: homestayName!, status: bookingStatus["all"], email: email),
            )
          ],
        ),
      ),
    );
  }
}
