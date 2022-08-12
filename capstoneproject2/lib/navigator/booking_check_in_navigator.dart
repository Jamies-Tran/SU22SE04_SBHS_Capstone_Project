import 'package:capstoneproject2/screens/booking/booking_summary_screen.dart';
import 'package:capstoneproject2/services/booking_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/booking_model.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:flutter/material.dart';

class BookingCheckInNavigator extends StatelessWidget {
  const BookingCheckInNavigator({
    this.bookingOtp,
    this.bookingId,
    this.username,
    Key? key
  }) : super(key: key);
  final String? bookingOtp;
  final int? bookingId;
  final String? username;

  @override
  Widget build(BuildContext context) {
    final bookingService = locator.get<IBookingService>();
    return Scaffold(
      body: FutureBuilder(
          future: bookingService.checkIn(bookingOtp!, bookingId!, username!),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("Check-in processing..."),);
            } else if(snapshot.hasData) {
              final snapshotData = snapshot.data;
              if(snapshotData is BookingModel) {
                return BookingSummaryScreen(bookingId: snapshotData.id,);
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
