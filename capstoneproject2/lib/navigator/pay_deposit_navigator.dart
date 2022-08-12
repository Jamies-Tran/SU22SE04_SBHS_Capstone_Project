import 'package:capstoneproject2/screens/booking/booking_summary_screen.dart';
import 'package:capstoneproject2/services/model/booking_model.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services_impl/booking_service_impl.dart';
import 'package:flutter/material.dart';

import '../services/booking_service.dart';
import '../services/locator/service_locator.dart';

class DepositPaymentNavigator extends StatelessWidget {
  const DepositPaymentNavigator({
    Key? key,
    this.username,
    this.amount,
    this.bookingModel
  }) : super(key: key);
  final String? username;
  final int? amount;
  final BookingModel? bookingModel;

  @override
  Widget build(BuildContext context) {
    final bookingService = locator.get<IBookingService>();

    return Scaffold(
      body: FutureBuilder(
        future: bookingService.payBookingDeposit(username!, bookingModel!.id!, amount!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: const Center(
                child: Text("Processing your payment..."),
              ),
            );
          } else if(snapshot.hasData) {
            final snapshotData = snapshot.data;
            if(snapshotData is DepositAmount) {
              return BookingSummaryScreen(bookingId: bookingModel!.id);
            } else if(snapshotData is ErrorHandlerModel) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: Text("Error occur ${snapshotData.message}"),
                ),
              );
            }
          } else if(snapshot.hasError) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text("Error occur ${snapshot.error}"),
              ),
            );
          }

          return Container(
            color: Colors.white,
            child: const Center(
              child: Text("Error undefine"),
            ),
          );
        },
      ),
    );
  }
}

