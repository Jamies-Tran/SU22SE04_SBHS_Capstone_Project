import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/navigator/booking_check_in_navigator.dart';
import 'package:capstoneproject2/navigator/pay_deposit_navigator.dart';
import 'package:capstoneproject2/services/booking_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/booking_model.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services_impl/booking_service_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingSummaryScreen extends StatefulWidget {
  const BookingSummaryScreen({Key? key, this.bookingId}) : super(key: key);
  final int? bookingId;

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  final firebaseAuth = FirebaseAuth.instance;
  final bookingService = locator.get<IBookingService>();
  final depositTextFieldController = TextEditingController();
  final otpTextFieldController = TextEditingController();
  final formatDate = DateFormat("yyyy-MM-dd");

  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    depositTextFieldController.dispose();
    otpTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat("#,##0");
    final bookingService = locator.get<IBookingService>();
    final firebaseAuth = FirebaseAuth.instance;
    var rows = <TableRow>[];


    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking details"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 15)).asyncMap((event) => bookingService.findBookingById(widget!.bookingId!)),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Getting booking details..."),);
          }else if(snapshot.hasData) {
            final snapshotData = snapshot.data;
            if(snapshotData is BookingModel) {
              final bool isCheckInDate = DateTime.now().difference(formatDate.parse(snapshotData.checkIn)).inDays == 0;
              final int remainingDate = formatDate.parse(snapshotData.checkIn).difference(DateTime.now()).inDays;
              snapshotData.homestayServiceList.forEach((element) {
                rows.add(TableRow(
                    children: [
                      TableCell(
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.all(15),
                            child: Text("${element.name}", style: const TextStyle(
                                fontSize: 17,
                                fontFamily: 'OpenSans',
                                letterSpacing: 3.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),),
                          )),
                      TableCell(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text("${currencyFormat.format(element.price)} / vnd", style: const TextStyle(
                              fontSize: 17,
                              fontFamily: 'OpenSans',
                              letterSpacing: 3.0,
                              color: Colors.black,
                            ),),
                          )
                      )
                    ]
                ));
              });

              depositTextFieldController.text = snapshotData.deposit.toString();
              otpTextFieldController.text = snapshotData.bookingOtp;

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(height: 40,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Booking Info: ", style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'OpenSans',
                            letterSpacing: 1.5,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold
                        )),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on, color: kPrimaryLightColor,),
                            Text("${snapshotData.homestayLocation!}", style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'OpenSans',
                              letterSpacing: 1.5,
                              color: Colors.black87,
                            )),
                            const SizedBox(width: 10,),
                            const Icon(Icons.location_city, color: kPrimaryLightColor,),
                            Text("${snapshotData.homestayCity!}", style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'OpenSans',
                              letterSpacing: 1.5,
                              color: Colors.black87,
                            )),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.calendar_month_sharp, color: Colors.green,),
                            Text("${snapshotData.checkIn!}", style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'OpenSans',
                              letterSpacing: 1.5,
                              color: Colors.black87,
                            )),
                            const Icon(Icons.forward, color: Colors.amber,),
                            const Icon(Icons.calendar_month_sharp, color: Colors.redAccent,),
                            Text("${snapshotData.checkOut!}", style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'OpenSans',
                              letterSpacing: 1.5,
                              color: Colors.black87,
                            )),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 90,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Owner contacts: ", style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'OpenSans',
                            letterSpacing: 1.5,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold
                        )),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.account_circle, color: kPrimaryLightColor,),
                            Text("${snapshotData.homestayOwner!}", style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'OpenSans',
                              letterSpacing: 1.5,
                              color: Colors.black87,
                            )),
                            const SizedBox(width: 10,),
                            const Icon(Icons.phone, color: Colors.green),
                            Text("${snapshotData.homestayOwnerPhone!}", style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'OpenSans',
                              letterSpacing: 1.5,
                              color: Colors.black87,
                            ))
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.email, color: Colors.red,),
                            Text("${snapshotData.homestayOwnerEmail!}", style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'OpenSans',
                              letterSpacing: 1.5,
                              color: Colors.black87,
                            ))
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 90,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Your service list: ", style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'OpenSans',
                            letterSpacing: 1.5,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold
                        )),
                        Center(
                          child: snapshotData.homestayServiceList!.isNotEmpty ? Container(
                            width: 300,
                            child: Table(
                                border: TableBorder.all(color: Colors.black54.withOpacity(0.2)),
                                columnWidths: const {
                                  0 : IntrinsicColumnWidth(),
                                  2 : IntrinsicColumnWidth()
                                },
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                children: rows
                            ),
                          ) : const Text("You didn't register any service",style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'OpenSans',
                            letterSpacing: 1.0,
                            color: Colors.black,
                          )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Total: ", style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'OpenSans',
                            letterSpacing: 1.5,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold
                        )),
                        Text("${currencyFormat.format(snapshotData.totalPrice!)}/VND", style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 1.5,
                          color: Colors.black87,
                        )),
                        const SizedBox(width: 10,),
                        const Text("Deposit: ", style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'OpenSans',
                            letterSpacing: 1.5,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold
                        )),
                        Text("${currencyFormat.format(snapshotData.deposit!)}/VND", style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 1.5,
                          color: Colors.black87,

                        )),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: () {
                        if(snapshotData.status.compareTo(bookingStatus["deposit"]) == 0) {
                          showDialog(context: context, builder: (context) => AlertDialog(
                            title: const Center(child: Text("Pay deposit"),),
                            content: TextField(
                              controller: depositTextFieldController,
                              readOnly: true,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(icon: const Icon(Icons.wallet, color: Colors.green,),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DepositPaymentNavigator(bookingModel: snapshotData, username: firebaseAuth.currentUser!.displayName, amount: int.parse(depositTextFieldController.text)),));
                                    },)
                              ),
                            ),
                            actions: [
                              ElevatedButton(onPressed: () {
                                Navigator.pop(context);
                              }
                                  , child: const Text("Cancel")
                              )
                            ],
                          ),);
                        } else if(snapshotData.status.compareTo(bookingStatus["pending_check_in"]) == 0) {
                          if(isCheckInDate) {
                            showDialog(context: context, builder: (context) => AlertDialog(
                              title: const Center(child: Text("Enter booking Otp"),),
                              content: TextField(
                                controller: otpTextFieldController,
                                readOnly: true,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(icon: const Icon(Icons.safety_check, color: Colors.green,),
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => BookingCheckInNavigator(bookingOtp: snapshotData.bookingOtp, bookingId: snapshotData.id, username: firebaseAuth.currentUser!.displayName),));
                                      },)
                                ),
                              ),
                              actions: [
                                ElevatedButton(onPressed: () {
                                  Navigator.pop(context);
                                }
                                    , child: const Text("Cancel")
                                )
                              ],
                            ),);

                          } else {
                            showDialog(context: context, builder: (context) => AlertDialog(
                              title: const Center(child: Text("Enter booking Otp"),),
                              content: Padding(padding: const EdgeInsets.all(20.0),child: Text("$remainingDate days till your booking date."),),
                              actions: [
                                ElevatedButton(onPressed: () {
                                  Navigator.pop(context);
                                }
                                    , child: const Text("Cancel")
                                )
                              ],
                            ),);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: snapshotData.status.compareTo(bookingStatus["pending"]) == 0
                              ? Colors.grey
                              : snapshotData.status.compareTo(bookingStatus["deposit"]) == 0
                              ? Colors.orange
                              : snapshotData.status.compareTo(bookingStatus["pending_check_in"]) == 0
                              ? Colors.green
                              : snapshotData.status.compareTo(bookingStatus["check_in"]) == 0
                              ? Colors.redAccent : kPrimaryLightColor

                      ),
                      child: Text(snapshotData.status.compareTo(bookingStatus["pending"]) == 0
                          ? "Waiting for owner response".toUpperCase()
                          : snapshotData.status.compareTo(bookingStatus["deposit"]) == 0
                          ? "Pay deposit".toUpperCase()
                          : snapshotData.status.compareTo(bookingStatus["pending_check_in"]) == 0
                          ? "Check-in".toUpperCase()
                          : snapshotData.status.compareTo(bookingStatus["check_in"]) == 0
                          ? "Check-out"
                          : "",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),



                  ],
                ),
              );
            }else if(snapshotData is ErrorHandlerModel) {
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



// class BookingSummaryScreen extends StatefulWidget {
//   const BookingSummaryScreen({Key? key, this.bookingModel}) : super(key: key);
//   final BookingModel? bookingModel;
//
//   @override
//   State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
// }
//
// class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
//   final firebaseAuth = FirebaseAuth.instance;
//   final bookingService = locator.get<IBookingService>();
//   final depositTextFieldController = TextEditingController();
//   final formatDate = DateFormat("yyyy-MM-dd");
//
//   @override
//   void initState() {
//     depositTextFieldController.text = widget.bookingModel!.deposit.toString();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     depositTextFieldController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final currencyFormat = NumberFormat("#,##0");
//     final bookingService = locator.get<IBookingService>();
//     final firebaseAuth = FirebaseAuth.instance;
//     var rows = <TableRow>[];
//
//     widget.bookingModel!.homestayServiceList.forEach((element) {
//       rows.add(TableRow(
//           children: [
//             TableCell(
//                 child: Container(
//                   margin: const EdgeInsets.only(right: 10),
//                   padding: const EdgeInsets.all(15),
//                   child: Text("${element.name}", style: const TextStyle(
//                       fontSize: 17,
//                       fontFamily: 'OpenSans',
//                       letterSpacing: 3.0,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold
//                   ),),
//                 )),
//             TableCell(
//                 child: Container(
//                   margin: const EdgeInsets.only(left: 10),
//                   child: Text("${currencyFormat.format(element.price)} / vnd", style: const TextStyle(
//                     fontSize: 17,
//                     fontFamily: 'OpenSans',
//                     letterSpacing: 3.0,
//                     color: Colors.black,
//                   ),),
//                 )
//             )
//           ]
//       ));
//     });
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("${widget.bookingModel!.homestayName}"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           children: [
//             const SizedBox(height: 40,),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Text("Booking Info: ", style: TextStyle(
//                     fontSize: 15,
//                     fontFamily: 'OpenSans',
//                     letterSpacing: 1.5,
//                     color: Colors.black87,
//                     fontWeight: FontWeight.bold
//                 )),
//                 const SizedBox(height: 20,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.location_on, color: kPrimaryLightColor,),
//                     Text("${widget.bookingModel!.homestayLocation!}", style: const TextStyle(
//                       fontSize: 15,
//                       fontFamily: 'OpenSans',
//                       letterSpacing: 1.5,
//                       color: Colors.black87,
//                     )),
//                     const SizedBox(width: 10,),
//                     const Icon(Icons.location_city, color: kPrimaryLightColor,),
//                     Text("${widget.bookingModel!.homestayCity!}", style: const TextStyle(
//                       fontSize: 15,
//                       fontFamily: 'OpenSans',
//                       letterSpacing: 1.5,
//                       color: Colors.black87,
//                     )),
//                   ],
//                 ),
//                 const SizedBox(height: 10,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.calendar_month_sharp, color: Colors.green,),
//                     Text("${widget.bookingModel!.checkIn!}", style: const TextStyle(
//                       fontSize: 15,
//                       fontFamily: 'OpenSans',
//                       letterSpacing: 1.5,
//                       color: Colors.black87,
//                     )),
//                     const Icon(Icons.forward, color: Colors.amber,),
//                     const Icon(Icons.calendar_month_sharp, color: Colors.redAccent,),
//                     Text("${widget.bookingModel!.checkOut!}", style: const TextStyle(
//                       fontSize: 15,
//                       fontFamily: 'OpenSans',
//                       letterSpacing: 1.5,
//                       color: Colors.black87,
//                     )),
//                   ],
//                 )
//               ],
//             ),
//             const SizedBox(height: 90,),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Text("Owner contacts: ", style: TextStyle(
//                     fontSize: 15,
//                     fontFamily: 'OpenSans',
//                     letterSpacing: 1.5,
//                     color: Colors.black87,
//                     fontWeight: FontWeight.bold
//                 )),
//                 const SizedBox(height: 20,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.account_circle, color: kPrimaryLightColor,),
//                     Text("${widget.bookingModel!.homestayOwner!}", style: const TextStyle(
//                       fontSize: 15,
//                       fontFamily: 'OpenSans',
//                       letterSpacing: 1.5,
//                       color: Colors.black87,
//                     )),
//                     const SizedBox(width: 10,),
//                     const Icon(Icons.phone, color: Colors.green),
//                     Text("${widget.bookingModel!.homestayOwnerPhone!}", style: const TextStyle(
//                       fontSize: 15,
//                       fontFamily: 'OpenSans',
//                       letterSpacing: 1.5,
//                       color: Colors.black87,
//                     ))
//                   ],
//                 ),
//                 const SizedBox(height: 10,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.email, color: Colors.red,),
//                     Text("${widget.bookingModel!.homestayOwnerEmail!}", style: const TextStyle(
//                       fontSize: 15,
//                       fontFamily: 'OpenSans',
//                       letterSpacing: 1.5,
//                       color: Colors.black87,
//                     ))
//                   ],
//                 )
//               ],
//             ),
//             const SizedBox(height: 90,),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Text("Your service list: ", style: TextStyle(
//                     fontSize: 15,
//                     fontFamily: 'OpenSans',
//                     letterSpacing: 1.5,
//                     color: Colors.black87,
//                     fontWeight: FontWeight.bold
//                 )),
//                 Center(
//                   child: widget.bookingModel!.homestayServiceList!.isNotEmpty ? Container(
//                     width: 300,
//                     child: Table(
//                         border: TableBorder.all(color: Colors.black54.withOpacity(0.2)),
//                         columnWidths: const {
//                           0 : IntrinsicColumnWidth(),
//                           2 : IntrinsicColumnWidth()
//                         },
//                         defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                         children: rows
//                     ),
//                   ) : const Text("You didn't register any service",style: TextStyle(
//                       fontSize: 17,
//                       fontFamily: 'OpenSans',
//                       letterSpacing: 1.0,
//                       color: Colors.black,
//                   )),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("Total: ", style: TextStyle(
//                     fontSize: 15,
//                     fontFamily: 'OpenSans',
//                     letterSpacing: 1.5,
//                     color: Colors.black87,
//                     fontWeight: FontWeight.bold
//                 )),
//                 Text("${currencyFormat.format(widget.bookingModel!.totalPrice!)}/VND", style: const TextStyle(
//                   fontSize: 15,
//                   fontFamily: 'OpenSans',
//                   letterSpacing: 1.5,
//                   color: Colors.black87,
//                 )),
//                 const SizedBox(width: 10,),
//                 const Text("Deposit: ", style: TextStyle(
//                     fontSize: 15,
//                     fontFamily: 'OpenSans',
//                     letterSpacing: 1.5,
//                     color: Colors.black87,
//                     fontWeight: FontWeight.bold
//                 )),
//                 Text("${currencyFormat.format(widget.bookingModel!.deposit!)}/VND", style: const TextStyle(
//                   fontSize: 15,
//                   fontFamily: 'OpenSans',
//                   letterSpacing: 1.5,
//                   color: Colors.black87,
//
//                 )),
//               ],
//             ),
//             const SizedBox(height: 10,),
//             ElevatedButton(
//               onPressed: () {
//                 if(widget.bookingModel!.status.compareTo(bookingStatus["deposit"]) == 0) {
//                   showDialog(context: context, builder: (context) => AlertDialog(
//                     title: const Center(child: Text("Pay deposit"),),
//                     content: TextField(
//                       controller: depositTextFieldController,
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         suffixIcon: IconButton(icon: const Icon(Icons.wallet, color: Colors.green,),
//                           onPressed: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => DepositPaymentNavigator(bookingModel: widget.bookingModel, username: firebaseAuth.currentUser!.displayName, amount: int.parse(depositTextFieldController.text)),));
//                             },)
//                       ),
//                     ),
//                     actions: [
//                       ElevatedButton(onPressed: () {
//                         Navigator.pop(context);
//                       }
//                       , child: const Text("Cancel")
//                       )
//                     ],
//                   ),);
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                   primary: widget.bookingModel!.status.compareTo(bookingStatus["pending"]) == 0
//                       ? Colors.grey
//                       : widget.bookingModel!.status.compareTo(bookingStatus["deposit"]) == 0
//                       ? Colors.orange
//                       : widget.bookingModel!.status.compareTo(bookingStatus["pending_check_in"]) == 0
//                       ? Colors.green : kPrimaryLightColor
//               ),
//               child: Text(widget.bookingModel!.status.compareTo(bookingStatus["pending"]) == 0
//                   ? "Waiting for owner response".toUpperCase()
//                   : widget.bookingModel!.status.compareTo(bookingStatus["deposit"]) == 0
//                   ? "Pay deposit".toUpperCase()
//                   : widget.bookingModel!.status.compareTo(bookingStatus["pending_check_in"]) == 0
//                   ? "Your booking is ready".toUpperCase() : "",
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
