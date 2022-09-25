import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/screens/booking/booking_detail_screen.dart';
import 'package:capstoneproject2/services/booking_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/booking_model.dart';
import 'package:capstoneproject2/services/model/wallet_model.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CancelBookingNavigator extends StatelessWidget {
  const CancelBookingNavigator({
    Key? key,
    this.email,
    this.bookingId,
    this.isFirstTimeCancelActive,
    this.isSecondTimeCancelActive
  }) : super(key: key);
  final String? email;
  final int? bookingId;
  final bool? isFirstTimeCancelActive;
  final bool? isSecondTimeCancelActive;

  @override
  Widget build(BuildContext context) {
    final bookingService = locator<IBookingService>();
    final passengerService = locator<IPassengerService>();
    final currencyFormat = NumberFormat("#,##0");

    return Scaffold(
      backgroundColor: Colors.grey,
      body: FutureBuilder(
        future: bookingService.cancelBooking(email, bookingId!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitComponent();
          } else if(snapshot.hasData) {
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
                      SizedBox(
                        height: 200,
                        child: FutureBuilder(
                          future: passengerService.getUserWallet(email!),
                          builder: (context, walletSnapshot) {
                            if(walletSnapshot.connectionState == ConnectionState.waiting) {
                              return const Text("Loading yor wallet balance...");
                            } else if(walletSnapshot.hasData) {
                              final walletSnapshotData = walletSnapshot.data;
                              if(walletSnapshotData is WalletModel) {
                                int depositReturn() {
                                  int deposit = snapshotData.deposit!;
                                  if(isFirstTimeCancelActive!) {
                                    deposit = deposit;
                                  } else if(isFirstTimeCancelActive! == false && isSecondTimeCancelActive == true) {
                                    deposit = deposit - (deposit * 5) ~/ 100;
                                  } else {
                                    deposit = deposit - deposit;
                                  }

                                  return deposit;
                                }

                                // int walletFinalBalance() {
                                //   int userCurrentBalance = walletSnapshotData.balance! + depositReturn();
                                //
                                //   return userCurrentBalance;
                                // }

                                // int walletFinalFuturePay() {
                                //   int futurePay = walletSnapshotData.futurePay! - (snapshotData.totalPrice! - snapshotData.deposit!);
                                //
                                //   return futurePay;
                                // }

                                return Column(
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
                                        Text(currencyFormat.format(walletSnapshotData.balance), style: const TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'OpenSans',
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                        )),
                                        const SizedBox(width: 20,),
                                        Text("+${currencyFormat.format(depositReturn())}", style: const TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'OpenSans',
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
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
                                        Text(currencyFormat.format(walletSnapshotData.futurePay), style: const TextStyle(
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
                                );
                              }
                            }
                            return const Center(
                              child: Text("Undefined error"),
                            );
                          },
                        ),
                      ),
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
          }
          return const Center(
            child: Text("Undefine error"),
          );
        },
      ),
    );
  }
}
