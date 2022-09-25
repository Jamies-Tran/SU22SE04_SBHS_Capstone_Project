import 'package:capstoneproject2/screens/booking/booking_detail_screen.dart';
import 'package:capstoneproject2/services/model/booking_model.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services_impl/booking_service_impl.dart';
import 'package:flutter/material.dart';

import '../services/booking_service.dart';
import '../services/locator/service_locator.dart';

class DepositPaymentNavigator extends StatelessWidget {
  const DepositPaymentNavigator({
    Key? key,
    this.email,
    this.amount,
    this.bookingModel
  }) : super(key: key);
  final String? email;
  final int? amount;
  final BookingModel? bookingModel;

  @override
  Widget build(BuildContext context) {
    final bookingService = locator.get<IBookingService>();

    return Scaffold(
      body: FutureBuilder(
        future: bookingService.payBookingDeposit(email!, bookingModel!.id!, amount!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: const Center(
                child: Text("almost done"),
              ),
            );
          } else if(snapshot.hasData) {
            final snapshotData = snapshot.data;
            if(snapshotData is DepositAmount) {
              return BookingDetailsScreen(bookingId: bookingModel!.id, homestayName: bookingModel!.homestayName, email: email,);
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

