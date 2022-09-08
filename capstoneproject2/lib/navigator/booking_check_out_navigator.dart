import 'package:capstoneproject2/screens/booking/booking_detail_screen.dart';
import 'package:capstoneproject2/screens/booking/rating_homestay_screen.dart';
import 'package:capstoneproject2/services/booking_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/booking_model.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:flutter/material.dart';

class BookingCheckOutNavigator extends StatelessWidget {
  const BookingCheckOutNavigator({
    this.bookingId,
    this.username,
    Key? key
  }) : super(key: key);
  final int? bookingId;
  final String? username;

  @override
  Widget build(BuildContext context) {
    final bookingService = locator.get<IBookingService>();
    return Scaffold(
      body: FutureBuilder(
        future: bookingService.checkOut( username!, bookingId!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Check-out processing..."),);
          } else if(snapshot.hasData) {
            final snapshotData = snapshot.data;
            if(snapshotData is BookingModel) {
              return RatingHomestayScreen(homestayName: snapshotData.homestayName, username: username, bookingId : bookingId);
            } else if(snapshotData is ErrorHandlerModel) {
              return Center(child: Text("Error occur ${snapshotData.message}"),);
            }
          } else if(snapshot.hasError) {
            return Center(child: Text("Error occur ${snapshot.error}"),);
          }

          return const Center(child: Text("Undefine error"),);
        },
      ),
    );
  }
}