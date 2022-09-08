import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/screens/booking/booking_detail_screen.dart';
import 'package:capstoneproject2/services/booking_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/model/booking_model.dart';

class CheckBookingOtpNavigator extends StatefulWidget {
  const CheckBookingOtpNavigator({
    Key? key,
    this.otp,
    this.username
  }) : super(key: key);
  final String? otp;
  final String? username;

  @override
  State<CheckBookingOtpNavigator> createState() => _CheckBookingOtpNavigatorState();
}

class _CheckBookingOtpNavigatorState extends State<CheckBookingOtpNavigator> {
  final bookingService = locator<IBookingService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: FutureBuilder(
          future: bookingService.findBookingByOtp(widget.username, widget.otp!),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const SpinKitThreeInOut(
                color: Colors.white,
              );
            } else if(snapshot.hasData) {
              final snapshotData = snapshot.data;
              if(snapshotData is BookingModel) {
                return Center(
                  child: Container(
                    width: 270,
                    height: 150,
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
                        Text("Do you want to check-in with homestay ${snapshotData.homestayName}?", style: const TextStyle(
                          fontSize: 17,
                          fontFamily: 'OpenSans',
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        )),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(Icons.arrow_back_ios),
                                      Text("no".toUpperCase())
                                    ],
                                  )
                              ),
                            ),
                            const SizedBox(width: 50,),
                            SizedBox(
                              width: 100,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CheckInByRelativeNavigator(username: widget.username, otp: widget.otp!,),));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("yes".toUpperCase()),
                                      const Icon(Icons.arrow_forward_ios),
                                    ],
                                  )
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              } else if(snapshotData is ErrorHandlerModel) {
                return Center(
                  child: Container(
                    width: 270,
                    height: 150,
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
                        const Text("Invalid booking otp", style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'OpenSans',
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        )),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(Icons.arrow_back_ios),
                                      Text("back".toUpperCase())
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
              final snapshotError = snapshot.error;
              return Container(
                width: 150,
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
                    Text("error occurred: $snapshotError")
                  ],
                ),
              );
            }
            return Container(
              width: 150,
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
                children: const [
                  Text("Something wrong")
                ],
              ),
            );
          },
        ),
    );
  }
}

class CheckInByRelativeNavigator extends StatefulWidget {
  const CheckInByRelativeNavigator({
    Key? key,
    this.username,
    this.otp
  }) : super(key: key);
  final String? username;
  final String? otp;

  @override
  State<CheckInByRelativeNavigator> createState() => _CheckInByRelativeNavigatorState();
}

class _CheckInByRelativeNavigatorState extends State<CheckInByRelativeNavigator> {
  final bookingService = locator<IBookingService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: FutureBuilder(
        future: bookingService.checkInByRelative(widget.username, widget.otp!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitThreeInOut(
              color: Colors.white,
            );
          }else if(snapshot.hasData) {
            final snapshotData = snapshot.data;
            if(snapshotData is BookingModel) {
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
                      Text("You have check-in homestay ${snapshotData.homestayName} successfully", style: const TextStyle(
                        fontSize: 17,
                        fontFamily: 'OpenSans',
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      )),
                      const SizedBox(height: 20,),
                      Text("Your appointment will start in ${snapshotData.checkIn}.", style: const TextStyle(
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
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BookingDetailsScreen(homestayName: snapshotData.homestayName, bookingId: snapshotData.id),));
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
            return Center(
              child: Container(
                width: 270,
                height: 150,
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
                    Text("Error occurred ${snapshot.error}", style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    )),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Row(
                                children: [
                                  Text("back".toUpperCase()),
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

          return Center(
            child: Container(
              width: 270,
              height: 150,
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
                  const Text("Something wrong", style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'OpenSans',
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  )),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.arrow_back_ios),
                                Text("back".toUpperCase()),
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
        },
      ),
    );
  }
}
