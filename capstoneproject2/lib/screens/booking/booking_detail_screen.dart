import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/navigator/booking_check_in_navigator.dart';
import 'package:capstoneproject2/navigator/booking_check_out_navigator.dart';
import 'package:capstoneproject2/navigator/cancel_booking_navigator.dart';
import 'package:capstoneproject2/navigator/pay_deposit_navigator.dart';
import 'package:capstoneproject2/screens/booking/booking_list_screen.dart';
import 'package:capstoneproject2/screens/home_page/home_page_screen.dart';
import 'package:capstoneproject2/screens/home_page/views/booking_history_screen.dart';
import 'package:capstoneproject2/services/booking_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/booking_model.dart';
import 'package:capstoneproject2/services/model/cancel_booking_ticket_model.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/model/wallet_model.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:capstoneproject2/services_impl/booking_service_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({
    Key? key,
    this.bookingId,
    this.homestayName,
    this.username
  }) : super(key: key);
  final int? bookingId;
  final String? homestayName;
  final String? username;

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
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
    final userService = locator.get<IPassengerService>();
    final firebaseAuth = FirebaseAuth.instance;
    late bool isFirstTimeCancelActive;
    late bool isSecondTimeCancelActive;
    late int balance;
    var rows = <TableRow>[];


    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking details"),
        automaticallyImplyLeading: false,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePageScreen(),))),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
                },
              icon: const Icon(Icons.refresh)
          )
        ],
      ),
      body: FutureBuilder(
        future: bookingService.findBookingById(widget.bookingId!),
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

              bool isUsingBookingCancelTicket() {
                return snapshotData.status.compareTo(bookingStatus["pending_check_in"]) == 0;
              }

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
                          child: snapshotData.homestayServiceList.isNotEmpty ? SizedBox(
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
                    FutureBuilder(
                        future: bookingService.findPassengerCancelBookingTicket(widget.username, widget.bookingId!),
                        builder: (context, cancelTicketSnapshot) {
                          if(cancelTicketSnapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                                child: Text(
                                  "Loading your cancel booking ticket..."
                                )
                            );
                          } else if(cancelTicketSnapshot.hasData) {
                            final cancelTicketSnapshotData = cancelTicketSnapshot.data;
                            if(cancelTicketSnapshotData is CancelBookingTicketModel) {
                              isFirstTimeCancelActive = cancelTicketSnapshotData.firstTimeCancelActive!;
                              isSecondTimeCancelActive = cancelTicketSnapshotData.secondTimeCancelActive!;
                              return SizedBox(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          cancelTicketSnapshotData.secondTimeCancelActive == true ? Icons.cancel_presentation : Icons.cancel_presentation_outlined,
                                          color: cancelTicketSnapshotData.secondTimeCancelActive == true ? Colors.green : Colors.red,
                                        ),
                                        Icon(
                                          cancelTicketSnapshotData.firstTimeCancelActive == true ? Icons.cancel_presentation : Icons.cancel_presentation_outlined,
                                          color: cancelTicketSnapshotData.firstTimeCancelActive == true ? Colors.green : Colors.red,
                                        )
                                      ],
                                    ),
                                    Center(
                                      child: Text(
                                          cancelTicketSnapshotData.firstTimeCancelActive == true
                                              ? "You have free cancel booking for first time" :
                                          cancelTicketSnapshotData.firstTimeCancelActive == false && cancelTicketSnapshotData.secondTimeCancelActive == true
                                              ? "You can cancel booking with 5% of deposit fee"
                                              : "You can cancel booking and will loss 100% of deposit fee"
                                      )
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                          return const SizedBox();
                        },
                    ),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: () {
                        if(snapshotData.status.compareTo(bookingStatus["pending_check_in"]) == 0) {
                          if(isCheckInDate) {
                            showDialog(context: context, builder: (context) => AlertDialog(
                              title: const Center(child: Text("Enter booking Otp"),),
                              content: TextField(
                                controller: otpTextFieldController,
                                readOnly: true,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(icon: const Icon(Icons.safety_check, color: Colors.green,),
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => BookingCheckInNavigator(bookingOtp: snapshotData.bookingOtp, bookingId: snapshotData.id, username: widget.username),));
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
                        } else if(snapshotData.status.compareTo(bookingStatus["check_in"]) == 0
                            || snapshotData.status.compareTo(bookingStatus["relative_check_in"])) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Center(
                                    child: Text("Confirm"),
                                  ),
                                  content: FutureBuilder(
                                    future: userService.getUserWallet(widget.username!),
                                    builder: (context, walletSnapshot) {
                                      if(walletSnapshot.connectionState == ConnectionState.waiting) {
                                        return const SizedBox(
                                          height: 50,
                                          child: Center(
                                            child: Text("Just a minutes..."),
                                          ),
                                        );
                                      } else if(walletSnapshot.hasData) {
                                        final walletSnapshotData = walletSnapshot.data;
                                        if(walletSnapshotData is WalletModel) {
                                          return SizedBox(
                                            height: 150,
                                            child: Column(
                                              children: [
                                                const Text("Your balance", style: TextStyle(
                                                  fontSize: 17,
                                                  fontFamily: 'OpenSans',
                                                  letterSpacing: 1.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                )),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(currencyFormat.format(walletSnapshotData.balance! - snapshotData.deposit!), style: const TextStyle(
                                                      fontSize: 17,
                                                      fontFamily: 'OpenSans',
                                                      letterSpacing: 1.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black54,
                                                    )),
                                                    const SizedBox(width: 20,),
                                                    Text("-${currencyFormat.format(snapshotData.deposit!)}", style: const TextStyle(
                                                      fontSize: 17,
                                                      fontFamily: 'OpenSans',
                                                      letterSpacing: 1.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.red,
                                                    )),
                                                  ],
                                                ),
                                                const SizedBox(height: 10,),
                                                const Text("Your future pay", style: TextStyle(
                                                  fontSize: 17,
                                                  fontFamily: 'OpenSans',
                                                  letterSpacing: 1.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                )),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(currencyFormat.format(walletSnapshotData.futurePay! - (snapshotData.totalPrice! - snapshotData.deposit!)), style: const TextStyle(
                                                      fontSize: 17,
                                                      fontFamily: 'OpenSans',
                                                      letterSpacing: 1.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black54,
                                                    )),
                                                    const SizedBox(width: 20,),
                                                    Text("-${currencyFormat.format(snapshotData.totalPrice! - snapshotData.deposit!)}", style: const TextStyle(
                                                      fontSize: 17,
                                                      fontFamily: 'OpenSans',
                                                      letterSpacing: 1.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.red,
                                                    )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                      } else if(walletSnapshot.hasError) {
                                        return SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Center(
                                            child: Text("${walletSnapshot.error}"),
                                          ),
                                        );
                                      }

                                      return const SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Center(
                                          child: Text("something wrong."),
                                        ),
                                      );
                                    },
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red,
                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                            maximumSize: const Size(120, 56),
                                            minimumSize: const Size(120, 56)
                                        ),
                                        child: Text("No".toUpperCase())
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => BookingCheckOutNavigator(bookingId: widget.bookingId, username: widget.username),));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.green,
                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                            maximumSize: const Size(150, 56),
                                            minimumSize: const Size(150, 56)
                                        ),
                                        child: Text("Yes".toUpperCase())
                                    )
                                  ],
                                );
                              },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: snapshotData.status.compareTo(bookingStatus["pending"]) == 0 || snapshotData.status.compareTo(bookingStatus["pending_alert_sent"]) == 0
                              ? Colors.grey
                              : snapshotData.status.compareTo(bookingStatus["pending_check_in"]) == 0 || snapshotData.status.compareTo(bookingStatus["pending_check_in_remain_sent"]) == 0 || snapshotData.status.compareTo(bookingStatus["pending_check_in_appointment_sent"]) == 0
                              ? Colors.green
                              : snapshotData.status.compareTo(bookingStatus["check_in"]) == 0 || snapshotData.status.compareTo(bookingStatus["relative_check_in"]) == 0 || snapshotData.status.compareTo(bookingStatus["landlord_check_in"]) == 0
                              ? Colors.amber
                              : snapshotData.status.compareTo(bookingStatus["check_out"]) == 0 || snapshotData.status.compareTo(bookingStatus["landlord_check_out"]) == 0 || snapshotData.status.compareTo(bookingStatus["relative_check_out"]) == 0
                              ? kPrimaryLightColor
                              : snapshotData.status.compareTo(bookingStatus["rejected"]) == 0 || snapshotData.status.compareTo(bookingStatus["canceled"]) == 0
                              ? Colors.red
                              : kPrimaryLightColor

                      ),
                      child: Text(snapshotData.status.compareTo(bookingStatus["pending"]) == 0 || snapshotData.status.compareTo(bookingStatus["pending_alert_sent"]) == 0
                          ? "Waiting for owner response".toUpperCase()
                          : snapshotData.status.compareTo(bookingStatus["pending_check_in"]) == 0 || snapshotData.status.compareTo(bookingStatus["pending_check_in_remain_sent"]) == 0 || snapshotData.status.compareTo(bookingStatus["pending_check_in_appointment_sent"]) == 0
                          ? "Check-in".toUpperCase()
                          : snapshotData.status.compareTo(bookingStatus["check_in"]) == 0 || snapshotData.status.compareTo(bookingStatus["relative_check_in"]) == 0 || snapshotData.status.compareTo(bookingStatus["landlord_check_in"]) == 0
                          ? "Check-out".toUpperCase()
                          : snapshotData.status.compareTo(bookingStatus["check_out"]) == 0 || snapshotData.status.compareTo(bookingStatus["landlord_check_out"]) == 0 || snapshotData.status.compareTo(bookingStatus["relative_check_out"]) == 0
                          ? "Finished".toUpperCase()
                          : snapshotData.status.compareTo(bookingStatus["rejected"]) == 0
                          ? "Rejected".toUpperCase()
                          : snapshotData.status.compareTo(bookingStatus["canceled"]) == 0
                          ? "Canceled".toUpperCase()
                          : "",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Center(child: Text("Caution"),),
                                  content: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Column(
                                      children: [
                                        isUsingBookingCancelTicket() == true ? Text(
                                          isFirstTimeCancelActive == true && isSecondTimeCancelActive == true ? "You're free to cancel booking"
                                              : isFirstTimeCancelActive == false && isSecondTimeCancelActive == true ? "You will be fined 5% of your deposit"
                                              : "You will lost 100% of your deposit",
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'OpenSans',
                                              letterSpacing: 1.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            )


                                        ) : const SizedBox(),
                                        const Text("Do you want to cancel booking?"),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red,
                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                            maximumSize: const Size(120, 56),
                                            minimumSize: const Size(120, 56)
                                        ),
                                        child: Text("no".toUpperCase())
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => CancelBookingNavigator(username: widget.username,bookingId: widget.bookingId, isFirstTimeCancelActive: isFirstTimeCancelActive, isSecondTimeCancelActive: isSecondTimeCancelActive,),));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.green,
                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                            maximumSize: const Size(120, 56),
                                            minimumSize: const Size(120, 56)
                                        ),
                                        child: Text("yes".toUpperCase())
                                    ),
                                  ],
                                );
                              },
                          );
                        },
                        child: Text("Cancel booking".toUpperCase())
                    ) 
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
