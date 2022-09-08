import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/screens/booking/booking_detail_screen.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/rating_model.dart';
import 'package:capstoneproject2/services/rating_service.dart';
import 'package:flutter/material.dart';

class RatingHomestayNavigator extends StatelessWidget {
  const RatingHomestayNavigator({
    Key? key,
    this.username,
    this.ratingModel,
    this.bookingId
  }) : super(key: key);
  final String? username;
  final RatingModel? ratingModel;
  final int? bookingId;

  @override
  Widget build(BuildContext context) {
    final ratingService = locator.get<IRatingService>();

    return Scaffold(
      body: FutureBuilder(
        future: ratingService.ratingHomestay(username, ratingModel!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitComponent();
          } else if(snapshot.hasData) {
            final snapshotData = snapshot.data;
            if(snapshotData is RatingModel) {
              return Center(
                child: Container(
                  width: 270,
                  height: 270,
                  padding: const EdgeInsets.only(left: 10),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Thank you for your contribution", style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'OpenSans',
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      )),
                      const SizedBox(height: 20,),
                      const Text("Your rating will help us evaluate the quality of the homestay", style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'OpenSans',
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      )),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BookingDetailsScreen(homestayName: snapshotData.homestayName, bookingId: bookingId, username: username),));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("booking details".toUpperCase()),
                                    const Icon(Icons.arrow_forward_ios),
                                  ],
                                )
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          } else if(snapshot.hasError) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text("${snapshot.error}"),
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
