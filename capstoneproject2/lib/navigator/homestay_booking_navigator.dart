import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/screens/booking/booking_summary_screen.dart';
import 'package:capstoneproject2/services/booking_service.dart';
import 'package:capstoneproject2/services/model/booking_model.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:flutter/material.dart';

import '../services/locator/service_locator.dart';

class HomestayBookingNavigator extends StatelessWidget {
  const HomestayBookingNavigator({
    Key? key,
    this.bookingModel,
    this.username
  }) : super(key: key);
  final BookingModel? bookingModel;
  final String? username;


  @override
  Widget build(BuildContext context) {
    final bookingService = locator.get<IBookingService>();


    return FutureBuilder(
        future: bookingService.bookingHomestay(bookingModel!, username!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitComponent();
          } else if(snapshot.hasData) {
            final snapshotData = snapshot.data;
            if(snapshotData is BookingModel) {
              return BookingSummaryScreen(bookingId: snapshotData.id,);
            } else if(snapshotData is ErrorHandlerModel) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Center(child: Text("Error"),),
                    content: Center(child: Text("${snapshotData.message}"),),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Back")
                      )
                    ],
                  ),
              );
            }
          }

          return Center(
            child: Column(
              children: [
                const Text("Something wrong"),
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                    },
                  child: const Text("Back"),
                )
              ]
              ,)
            ,);
        },
    );
  }
}
