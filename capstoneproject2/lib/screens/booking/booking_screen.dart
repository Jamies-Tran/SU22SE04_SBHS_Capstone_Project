import 'package:capstoneproject2/components/dialog_component.dart';
import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/navigator/homestay_booking_navigator.dart';
import 'package:capstoneproject2/screens/booking/component/booking_schedule_component.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/booking_model.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/model/homestay_model.dart';
import 'package:capstoneproject2/services/model/wallet_model.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({
    Key? key,
    this.homestayModel,
    this.CheckInDate,
    this.CheckOutDate
  }) : super(key: key);
  final HomestayModel? homestayModel;
  final CheckInDate;
  final CheckOutDate;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final dateFormat = DateFormat("yyyy-MM-dd");
  var checkInController = TextEditingController();
  var checkOutController = TextEditingController();
  var isChosen = false;
  var checkBalance = true;
  List<HomestayServiceModel> homestayChosenService = <HomestayServiceModel>[];
  Map<int, bool> markSelected = {};
  final currencyFormat = NumberFormat("#,##0");

  // get total booking bill
  int getTotalPrice(DateTime checkIn, DateTime checkOut, List<HomestayServiceModel> services) {
    int bookingTotal = 0;
    int servicesTotal = 0;
    services.isEmpty ? bookingTotal = 0 : services.forEach((element) {
      servicesTotal = servicesTotal + element!.price!;
    });
    bookingTotal = bookingTotal + widget.homestayModel!.price!  * ( checkOut.difference(checkIn).inDays == 0 ? 1 :  checkOut.difference(checkIn).inDays) + servicesTotal;

    return bookingTotal;
  }

  // calculate deposit
  int getTotalDeposit(int totalPrice) {
    return (totalPrice * 50) ~/ 100;
  }

  @override
  void initState() {
    checkInController.text = widget.CheckInDate;
    checkOutController.text = widget.CheckOutDate;
    super.initState();
  }

  @override
  void dispose() {
    checkInController.dispose();
    checkOutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var selectedCheckInDate = checkInController.text;
    var selectedCheckOutDate = checkOutController.text;
    final currencyFormat = NumberFormat("#,##0");
    final passengerService = locator.get<IPassengerService>();
    final firebaseAuth = FirebaseAuth.instance;


    return FutureBuilder(
        future: passengerService.getUserWallet(firebaseAuth.currentUser!.displayName!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitComponent();
          } else if(snapshot.hasData) {
            final snapshotData = snapshot.data;
            if(snapshotData is WalletModel) {
              // check balance
              bool isWalletHasEnoughBalance(int totalPrice) {
                if(snapshotData!.balance! < totalPrice) {
                  return false;
                }
                return true;
              }
              int totalPrice = getTotalPrice(dateFormat.parse(selectedCheckInDate), dateFormat.parse(selectedCheckOutDate), homestayChosenService);
              int totalDeposit = getTotalDeposit(totalPrice);
              checkBalance = isWalletHasEnoughBalance(totalPrice);
              
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Booking"),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                          if(checkBalance) {
                            BookingModel bookingModel = BookingModel(
                              homestayName: widget.homestayModel!.name!,
                              homestayServiceList: homestayChosenService,
                              totalPrice: totalPrice,
                              deposit: totalDeposit,
                              checkIn: selectedCheckInDate,
                              checkOut: selectedCheckOutDate
                            );

                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomestayBookingNavigator(bookingModel: bookingModel, username: firebaseAuth.currentUser!.displayName!),));
                          }
                      },
                      icon: const Icon(Icons.check),
                      color: checkBalance ? Colors.white : Colors.grey,
                    )
                  ],
                ),
                body: SingleChildScrollView(
                  child: Material(
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            margin: const EdgeInsets.only(left: 10, top: 20, bottom: 5),
                            child: const Text("Check-in", style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'OpenSans',
                              letterSpacing: 2.0,
                              color: Colors.black,
                            )),
                          ),
                          Container(
                            height: 50,
                            width: 200,
                            margin: const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextFormField(
                              controller: checkInController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero),
                                  prefixIcon: Icon(
                                      Icons.calendar_month, color: kPrimaryColor)
                              ),
                              readOnly: true,
                              onTap: () async {
                                var getCheckInDateFromCalendar = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BookingScheduleComponent(
                                              homestayModel: widget.homestayModel,
                                              chosenDate: selectedCheckInDate,
                                              isUpdateCheckInDate: true,
                                              isUpdateCheckOutDate: false),));
                                setState(() {
                                  if (dateFormat.parse(getCheckInDateFromCalendar)
                                      .isAfter(
                                      dateFormat.parse(checkOutController.text))) {
                                    checkInController.text = getCheckInDateFromCalendar;
                                    checkOutController.text = getCheckInDateFromCalendar;
                                  } else {
                                    checkInController.text = getCheckInDateFromCalendar;
                                  }
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, top: 20, bottom: 5),
                            child: const Text("Check-out", style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'OpenSans',
                              letterSpacing: 2.0,
                              color: Colors.black,
                            )),
                          ),
                          Container(
                            height: 50,
                            width: 200,
                            margin: const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextFormField(
                              controller: checkOutController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero),
                                  prefixIcon: Icon(
                                      Icons.calendar_month, color: kPrimaryColor)
                              ),
                              onTap: () async {
                                var getCheckOutDateFromCalendar = await Navigator.push(
                                    context, MaterialPageRoute(builder: (context) =>
                                    BookingScheduleComponent(
                                      homestayModel: widget.homestayModel,
                                      chosenDate: selectedCheckOutDate,
                                      isUpdateCheckInDate: false,
                                      isUpdateCheckOutDate: true,)));
                                setState(() {
                                  if (dateFormat.parse(getCheckOutDateFromCalendar)
                                      .isBefore(
                                      dateFormat.parse(checkInController.text))) {
                                    checkInController.text = getCheckOutDateFromCalendar;
                                    checkOutController.text = getCheckOutDateFromCalendar;
                                  } else {
                                    checkOutController.text = getCheckOutDateFromCalendar;
                                  }
                                });
                              },
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(left: 10, top: 20, bottom: 5),
                            child: const Text("Choose services", style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'OpenSans',
                              letterSpacing: 2.0,
                              color: Colors.black,
                            )),
                          ),
                          widget.homestayModel!.homestayServices.isEmpty ? const Text(
                              "Landlord didn't register any service", style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'OpenSans',
                              letterSpacing: 1.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          )) : Container(
                            height: 200,
                            child: ListView.builder(
                              itemCount: widget.homestayModel!.homestayServices.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    setState(() {
                                      markSelected[index] = markSelected[index] != null ? !markSelected[index]! : true;
                                      if(markSelected[index]!) {
                                        homestayChosenService.add(widget.homestayModel!.homestayServices[index]);
                                      } else {
                                        homestayChosenService.remove(widget.homestayModel!.homestayServices[index]);
                                      }
                                    });
                                  },
                                  title: Text(widget.homestayModel!.homestayServices[index].name, style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'OpenSans',
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.bold
                                  )),
                                  subtitle: Text("${currencyFormat.format(widget.homestayModel!.homestayServices[index].price)}/vnd", style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'OpenSans',
                                    letterSpacing: 1.0,
                                  )),
                                  selected: markSelected[index] != null ? markSelected[index]! : false,
                                  selectedTileColor: Colors.green,
                                  selectedColor: Colors.white,
                                );
                              },
                            ),
                          ),
                          Center(
                            child: Container(
                                height: 100,
                                width: 200,
                                decoration: const BoxDecoration(
                                  color: Colors.amber,
                                ),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${currencyFormat.format(totalPrice)} / VND",style: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'OpenSans',
                                          letterSpacing: 1.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      )),
                                      const Text("Total price",style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'OpenSans',
                                        color: Colors.white,
                                        letterSpacing: 1.0,
                                      ))
                                    ],
                                  ),
                                )
                            ),
                          ),
                          Center(
                            child: Container(
                                height: 50,
                                width: 200,
                                decoration: const BoxDecoration(

                                  color: Colors.red,
                                ),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${currencyFormat.format(totalDeposit)} / VND",style: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'OpenSans',
                                          letterSpacing: 1.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      )),
                                      const Text("Deposit",style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'OpenSans',
                                        color: Colors.white,
                                        letterSpacing: 1.0,
                                      ))
                                    ],
                                  ),
                                )
                            ),
                          ),
                          checkBalance ? Container() : Center(
                            child: Column(
                              children:  [
                                const Text("You don't have enough balance to process booking.",style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'OpenSans',
                                    letterSpacing: 1.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold
                                )),
                                Text("Your balance ${currencyFormat.format(snapshotData.balance)} vnd",style: const TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'OpenSans',
                                    letterSpacing: 1.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold
                                )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if(snapshotData is ErrorHandlerModel) {
              return DialogComponent(message: snapshotData.message, eventHandler: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScheduleComponent(homestayModel: widget.homestayModel),)),);
            }
            
          } else if(snapshot.hasError) {
            return Center(child: Text("Something went wrong - ${snapshot.error.toString()}"),);
          }

          return Center(child: Text("Something went wrong - ${snapshot.error.toString()}"),);
        },
    );
  }
}
