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

import '../../Login/login_screen.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({
    Key? key,
    this.bookingList
  }) : super(key: key);
  final List<BookingModel>? bookingList;

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  final bookingService = locator<IBookingService>();
  final firebaseAuth = FirebaseAuth.instance;
  final currencyFormat = NumberFormat("#,##0");
  final dateFormat = DateFormat("yyyy-MM-dd");
  int getDaysRemaining(DateTime checkIn) {
    return checkIn.difference(DateTime.now()).inDays;
  }
  String homestayNameDropDownValue = "all";
  String bookingStatusDropDownValue = "all";

  @override
  Widget build(BuildContext context) {
    if(firebaseAuth.currentUser != null) {
      return FutureBuilder(
        future: bookingService.getUserBookingList(firebaseAuth.currentUser!.displayName!, bookingStatus["all"]!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitComponent();
          }else if(snapshot.hasData) {
            var snapshotData = snapshot.data;
            if(snapshotData is List<BookingModel>) {
              List<BookingModel> getBookingListOfUser = snapshotData;
              //homestay drop down list
              List<String> getAllHomestayName = <String>["all"];

              getBookingListOfUser.forEach((element) {
                if(getAllHomestayName.where((e) => e.compareTo(element.homestayName) == 0).isEmpty) {
                  getAllHomestayName.add(element.homestayName);
                }
              });

              List<String> getAllBookingStatus = <String>[];

              bookingStatusDropdown.forEach((key, value) {
                String status = "";
                if(key.compareTo("all") == 0) {
                  status = "all";
                  getAllBookingStatus.add(status);
                } else if(key.compareTo("pending") == 0) {
                  status = "pending";
                  getAllBookingStatus.add(status);
                } else if(
                key.compareTo("accepted") == 0 || key.compareTo("pending_check_in") == 0
                    || key.compareTo("pending_check_in_remain_sent") == 0
                    || key.compareTo("pending_check_in_appointment_sent") == 0
                ) {
                  status = "accepted";
                  getAllBookingStatus.add(status);
                } else if (key.compareTo("rejected") == 0) {
                  status = "rejected";
                  getAllBookingStatus.add(status);
                } else if (key.compareTo("canceled") == 0) {
                  status = "canceled";
                  getAllBookingStatus.add(status);
                } else if(key.compareTo("check_in") == 0 || key.compareTo("relative_check_in") == 0 || key.compareTo("landlord_check_in") == 0) {
                  status = "check-in";
                  getAllBookingStatus.add(status);
                } else if(key.compareTo("check_out") == 0 || key.compareTo("landlord_check_out") == 0 || key.compareTo("relative_check_out") == 0 || key.compareTo("finish") == 0 ) {
                  status = "finish";
                  getAllBookingStatus.add(status);
                }
              });

              List<BookingModel> filterBookingList() {
                if(bookingStatusDropDownValue.compareTo("all") == 0 && homestayNameDropDownValue.compareTo("all") == 0) {
                  getBookingListOfUser = getBookingListOfUser;
                } else if(bookingStatusDropDownValue.compareTo("all") != 0 && homestayNameDropDownValue.compareTo("all") == 0) {
                  getBookingListOfUser = getBookingListOfUser.where((element) => element.status.compareTo(bookingStatusDropdown[bookingStatusDropDownValue]) == 0).toList();

                } else if(bookingStatusDropDownValue.compareTo("all") == 0 && homestayNameDropDownValue.compareTo("all") != 0) {
                  getBookingListOfUser = getBookingListOfUser.where((element) => element.homestayName.compareTo(homestayNameDropDownValue) == 0).toList();

                } else if(bookingStatusDropDownValue.compareTo("all") != 0 && homestayNameDropDownValue.compareTo("all") != 0) {
                  if(bookingStatusDropDownValue.compareTo("accepted") == 0)
                  {
                    getBookingListOfUser = getBookingListOfUser.where((element) => element.homestayName.compareTo(homestayNameDropDownValue) == 0)
                        .where(
                            (element) =>
                                      element.status.compareTo(bookingStatus["accepted"]) == 0 ||
                                          element.status.compareTo(bookingStatus["pending_check_in"]) == 0 ||
                                          element.status.compareTo(bookingStatus["pending_check_in_remain_sent"]) == 0 ||
                                          element.status.compareTo(bookingStatus["pending_check_in_appointment_sent"]) == 0
                    ).toList();
                  } else if(bookingStatusDropDownValue.compareTo("rejected") == 0) {
                    getBookingListOfUser = getBookingListOfUser.where((element) => element.homestayName.compareTo(homestayNameDropDownValue) == 0)
                        .where((element) => element.status.compareTo(bookingStatus["rejected"]) == 0).toList();
                  } else if(bookingStatusDropDownValue.compareTo("pending") == 0) {
                    getBookingListOfUser = getBookingListOfUser.where((element) => element.homestayName.compareTo(homestayNameDropDownValue) == 0)
                        .where((element) => element.status.compareTo(bookingStatus["pending"]) == 0).toList();
                  } else if(bookingStatusDropDownValue.compareTo("canceled") == 0) {
                    getBookingListOfUser = getBookingListOfUser.where((element) => element.homestayName.compareTo(homestayNameDropDownValue) == 0)
                        .where((element) => element.status.compareTo(bookingStatus["canceled"]) == 0).toList();
                  } else if(bookingStatusDropDownValue.compareTo("check-in") == 0) {
                    getBookingListOfUser = getBookingListOfUser.where((element) => element.homestayName.compareTo(homestayNameDropDownValue) == 0)
                        .where((element) =>
                                            element.status.compareTo(bookingStatus["check-in"]) == 0 ||
                                                element.status.compareTo(bookingStatus["relative_check_in"]) == 0 ||
                                                element.status.compareTo(bookingStatus["landlord_check_in"]) == 0
                    ).toList();
                  } else if(bookingStatusDropDownValue.compareTo("finish") == 0) {
                    getBookingListOfUser = getBookingListOfUser.where((element) => element.homestayName.compareTo(homestayNameDropDownValue) == 0)
                        .where((element) =>
                                            element.status.compareTo(bookingStatus["check_out"]) == 0 ||
                                                element.status.compareTo(bookingStatus["landlord_check_out"]) == 0 ||
                                                element.status.compareTo(bookingStatus["relative_check_out"]) == 0 ||
                                                element.status.compareTo(bookingStatus["finish"]) == 0
                    ).toList();
                  }
                  // getBookingListOfUser = getBookingListOfUser.where((element) => element.homestayName.compareTo(homestayNameDropDownValue) == 0)
                  //     .where((element) => element.status.compareTo(bookingStatusDropdown[bookingStatusDropDownValue]) == 0).toList();
                }

                return getBookingListOfUser;
              }

              String getBookingStatus(String bookingStatusStr) {
                String status = "";
                if(bookingStatusStr.compareTo(bookingStatus["pending"]!) == 0 || bookingStatusStr.compareTo(bookingStatus["pending_alert_sent"]!) == 0) {
                  status = "pending".toUpperCase();
                } else if(bookingStatusStr.compareTo(bookingStatus["accepted"]!) == 0
                    || bookingStatusStr.compareTo(bookingStatus["pending_check_in"]!) == 0
                    || bookingStatusStr.compareTo(bookingStatus["pending_check_in_appointment_sent"]!) == 0
                    || bookingStatusStr.compareTo(bookingStatus["pending_check_in_remain_sent"]!) == 0) {
                  status = "accepted".toUpperCase();
                } else if(bookingStatusStr.compareTo(bookingStatus["rejected"]!) == 0) {
                  status = "rejected".toUpperCase();
                } else if(bookingStatusStr.compareTo(bookingStatus["canceled"]!) == 0) {
                  status = "canceled".toUpperCase();
                } else if(bookingStatusStr.compareTo(bookingStatus["check_in"]!) == 0
                    || bookingStatusStr.compareTo(bookingStatus["relative_check_in"]!) == 0
                    || bookingStatusStr.compareTo(bookingStatus["landlord_check_in"]!) == 0) {
                  status = "check-in".toUpperCase();
                } else if(bookingStatusStr.compareTo(bookingStatus["check_out"]!) == 0
                    || bookingStatusStr.compareTo(bookingStatus["relative_check_out"]!) == 0
                    || bookingStatusStr.compareTo(bookingStatus["landlord_check_out"]!) == 0 || bookingStatusStr.compareTo(bookingStatus["finish"]!) == 0) {
                  status = "finish".toUpperCase();
                }
                
                return status;
              }
              return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    title: const Text("Booking history"),
                    centerTitle: true,
                  ),
                  body: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Homestay"),
                                    DropdownButton<String>(
                                      value: homestayNameDropDownValue,
                                      icon: const Icon(Icons.arrow_downward),
                                      elevation: 16,
                                      style: const TextStyle(color: Colors.deepPurple),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          homestayNameDropDownValue = newValue!;
                                        });
                                      },
                                      items: getAllHomestayName
                                          .map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20,),
                              const SizedBox(
                                width: 100,
                                child: Divider(
                                  height: 1.0,
                                  thickness: 1.0,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(width: 20,),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Status"),
                                    DropdownButton<String>(
                                      value: bookingStatusDropDownValue,
                                      icon: const Icon(Icons.arrow_downward),
                                      elevation: 16,
                                      style: const TextStyle(color: Colors.deepPurple),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          bookingStatusDropDownValue = newValue!;
                                        });
                                      },
                                      items: getAllBookingStatus
                                          .map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(
                          height: 600,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: filterBookingList().length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDetailsScreen(bookingId: getBookingListOfUser[index].id, username: firebaseAuth.currentUser!.displayName,),))
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
                                          Text("Status: ${getBookingStatus(getBookingListOfUser[index].status)}", style: const TextStyle(
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
                          ),
                        )
                      ],
                    ),
                  )
              );
            }else if(snapshotData is ErrorHandlerModel) {
              return Center(child: Text("${snapshotData.message}"),);
            }
          } else if(snapshot.hasError) {
            throw "$snapshot.error";
            return Center(child: Text("${snapshot.error}"),);
          }

          return const Center(child: Text("Something went wrong"),);
        },
      );
      // return Scaffold(
      //     appBar: AppBar(
      //       automaticallyImplyLeading: false,
      //       title: const Text("Booking history"),
      //       centerTitle: true,
      //     ),
      //     body: SingleChildScrollView(
      //       scrollDirection: Axis.vertical,
      //       child: Column(
      //
      //       ),
      //     ),
      // );
    } else {
      return Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("You must login to view booking history.", style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'OpenSans',
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                )),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 160,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(isSignInFromBookingScreen: false),));
                      },
                      child: Row(
                        children: [
                          Text("to login page".toUpperCase()),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
