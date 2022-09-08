import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/navigator/homestay_booking_navigator.dart';
import 'package:capstoneproject2/navigator/pay_deposit_navigator.dart';
import 'package:capstoneproject2/screens/booking/booking_screen.dart';
import 'package:capstoneproject2/screens/booking/component/booking_schedule_component.dart';
import 'package:capstoneproject2/services/model/booking_model.dart';
import 'package:capstoneproject2/services/model/homestay_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingSummaryComponent extends StatefulWidget {
  const BookingSummaryComponent({
    Key? key,
    this.homestayModel,
    this.checkIn,
    this.checkOut,
    this.balance,
    this.futurePay,
    this.chooseCheckInPhase,
    this.chooseCheckOutPhase,
    this.chooseServicePhase,
    this.chosenCheckInDate,
    this.finishingPhase,
    this.totalPriceOfBookingDays,
    this.homestayServiceList
  }) : super(key: key);
  final HomestayModel? homestayModel;
  final String? checkIn;
  final String? checkOut;
  final int? balance;
  final int? futurePay;
  final String? chosenCheckInDate;
  final bool? chooseCheckInPhase;
  final bool? chooseCheckOutPhase;
  final bool? chooseServicePhase;
  final bool? finishingPhase;
  final TotalPriceOfBookingDays? totalPriceOfBookingDays;
  final List<HomestayServiceModel>? homestayServiceList;

  @override
  State<BookingSummaryComponent> createState() => _BookingSummaryComponentState();
}

class _BookingSummaryComponentState extends State<BookingSummaryComponent> {
  final currencyFormat = NumberFormat("#,##0");
  final formatDate = DateFormat("yyyy-MM-dd");
  final depositTextFieldController = TextEditingController();


  HomestayPriceListModel? getHomestayPriceListBySpecialDay(DateTime observeCurrentDay) {
    //DateTime observeCurrentDay = formatDate.parse(formatDate.format(DateTime(DateTime.now().year, day, month, 0, 0, 0, 0, 0)));
    HomestayPriceListModel? homestayPriceListModel;
    for (var element in widget.homestayModel!.homestayPriceLists!) {
      // so sánh những ngày đặc trong cùng năm $observeCurrentDay.year
      if(element.type.compareTo("special") == 0) {
        DateTime startTime = formatDate.parse(formatDate.format(DateTime(observeCurrentDay.year, element.specialDayPriceList!.startMonth, element.specialDayPriceList!.startDay, 0, 0, 0, 0, 0)));
        DateTime endTime = formatDate.parse(formatDate.format(DateTime(observeCurrentDay.year, element.specialDayPriceList!.endMonth, element.specialDayPriceList!.endDay, 0, 0, 0, 0, 0)));
        if(startTime.difference(observeCurrentDay).inDays <= 0 && observeCurrentDay.difference(endTime).inDays <= 0) {
          homestayPriceListModel = element;
        }
      }
    }
    return homestayPriceListModel;
  }


  int totalServicePrice() {
    int totalServicePrice = 0;
    if(widget.homestayServiceList != null) {
      for(var homestayService in widget!.homestayServiceList!) {
        totalServicePrice = totalServicePrice + homestayService.price!;
      }
    }
    return totalServicePrice;
  }

  int totalBookingDay() {
    int totalDay = 0;
    if(widget.totalPriceOfBookingDays!.specialDayList!.isNotEmpty) {
      totalDay = totalDay + widget.totalPriceOfBookingDays!.specialDayList!.length;
    }

    if(widget.totalPriceOfBookingDays!.weekendList!.isNotEmpty) {
      totalDay = totalDay + widget.totalPriceOfBookingDays!.weekendList!.length;
    }

    if(widget.totalPriceOfBookingDays!.normalDayList!.isNotEmpty) {
      totalDay = totalDay + widget.totalPriceOfBookingDays!.normalDayList!.length;
    }

    return totalDay;
  }

  bool isThroughSpecialDay(DateTime observeDateTime) {
    bool isThrough = false;
    for (var homestayPriceListElement in widget.homestayModel!.homestayPriceLists!) {
      if(homestayPriceListElement.specialDayPriceList != null) {
        DateTime eventStartTime = DateTime(observeDateTime.year, homestayPriceListElement.specialDayPriceList!.startMonth, homestayPriceListElement.specialDayPriceList!.startDay, 0, 0, 0, 0, 0);
        DateTime eventEndTime = DateTime(observeDateTime.year, homestayPriceListElement.specialDayPriceList!.endMonth, homestayPriceListElement.specialDayPriceList!.endDay, 0, 0, 0, 0, 0);
        if(eventStartTime.difference(observeDateTime).inDays <= 0 && observeDateTime.difference(eventEndTime).inDays <= 0) {
          isThrough = true;
        }
      }
    }

    return isThrough;
  }

  int totalPriceOfSingleBookingDayType(List<DateTime> bookingTimeList) {
    int total = 0;
    for (var bookingTimeElement in bookingTimeList) {
      if(isThroughSpecialDay(bookingTimeElement)) {
        for (var homestayPriceListElement in widget.homestayModel!.homestayPriceLists!) {
          if(homestayPriceListElement.specialDayPriceList != null) {
            DateTime eventStartTime = DateTime(bookingTimeElement.year, homestayPriceListElement.specialDayPriceList!.startMonth, homestayPriceListElement.specialDayPriceList!.startDay, 0, 0, 0, 0, 0);
            DateTime eventEndTime = DateTime(bookingTimeElement.year, homestayPriceListElement.specialDayPriceList!.endMonth, homestayPriceListElement.specialDayPriceList!.endDay, 0, 0, 0, 0, 0);
            if(eventStartTime.difference(bookingTimeElement).inDays <= 0 && bookingTimeElement.difference(eventEndTime).inDays <= 0) {
              total = total + homestayPriceListElement.price as int;
            }
          }
        }
      } else {
        if(bookingTimeElement.weekday == DateTime.sunday || bookingTimeElement.weekday == DateTime.saturday) {
          total = total + widget.homestayModel!.homestayPriceLists!.where((element) => element.type.compareTo("weekend") == 0).single.price as int;
        } else {
          total = total + widget.homestayModel!.homestayPriceLists!.where((element) => element.type.compareTo("normal") == 0).single.price as int;
        }
      }
    }
    return total;
  }
  @override
  void dispose() {
    depositTextFieldController.dispose();
    super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
    int totalBookingPrice = totalServicePrice() + widget.totalPriceOfBookingDays!.totalPrice!;
    int deposit = totalBookingPrice ~/ 2;
    final firebaseAuth = FirebaseAuth.instance;
    depositTextFieldController.text = deposit.toString();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(

        children: [

          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("From", style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'OpenSans',
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                )),
                const SizedBox(width: 10,),
                Text(widget!.checkIn!, style: const TextStyle(
                  fontSize: 17,
                  fontFamily: 'OpenSans',
                  letterSpacing: 2.0,
                  color: Colors.black,
                )),
                const SizedBox(width: 10,),
                const Text("To", style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'OpenSans',
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                )),
                const SizedBox(width: 10,),
                Text(widget!.checkOut!, style: const TextStyle(
                  fontSize: 17,
                  fontFamily: 'OpenSans',
                  letterSpacing: 2.0,
                  color: Colors.black,
                ))
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("${totalBookingDay()} booking days which include:", style: const TextStyle(
                  fontSize: 17,
                  fontFamily: 'OpenSans',
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ))
              ],
            ),
          ),

          widget.totalPriceOfBookingDays!.specialDayList!.isNotEmpty ? Container(
            margin: const EdgeInsets.only(left: 10, bottom: 20),
            child: Column(

              children: [
                Row(

                  children: [
                    const Icon(Icons.date_range, color: kPrimaryColor,size: 17,),
                    const SizedBox(width: 10,),
                    Text("${widget.totalPriceOfBookingDays!.specialDayList!.length}", style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    )),
                    const SizedBox(width: 5,),
                    const Text("special days", style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    )),

                    SizedBox(
                      width: 160,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(context: context, builder: (context) => AlertDialog(
                            title: const Center(
                              child: Text("Special day"),
                            ),
                            content: SizedBox(
                              height:widget.totalPriceOfBookingDays!.specialDayList!.length == 1 ? 70 : widget.totalPriceOfBookingDays!.specialDayList!.length < 3 ? 140 : 400,
                              width: 100,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: SizedBox(
                                  height:widget.totalPriceOfBookingDays!.specialDayList!.length == 1 ? 70 :  widget.totalPriceOfBookingDays!.specialDayList!.length < 3 ? 140 : 400,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: widget.totalPriceOfBookingDays!.specialDayList!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 0),
                                        child: ListTile(
                                          title: Text(formatDate.format(widget.totalPriceOfBookingDays!.specialDayList![index])),
                                          subtitle: Text("${getHomestayPriceListBySpecialDay(widget.totalPriceOfBookingDays!.specialDayList![index])!.specialDayPriceList!.description} - ${currencyFormat.format(getHomestayPriceListBySpecialDay(widget.totalPriceOfBookingDays!.specialDayList![index])!.price)}", style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'OpenSans',
                                            letterSpacing: 1.0,
                                            color: Colors.green,
                                          )),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: const RoundedRectangleBorder()
                                ),
                                child: const Text("Back", style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.0,
                                  color: Colors.lightBlueAccent,
                                ),),
                              )
                            ],
                          ),);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: const RoundedRectangleBorder(),
                        ),
                        icon: const Icon(Icons.remove_red_eye, color: Colors.green),
                        label: const Text("View details", style: TextStyle(color: Colors.green),),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.monetization_on, color: Colors.yellow, size: 17,),
                    const SizedBox(width: 10,),
                    const Text("Total special price:", style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    )),
                    const SizedBox(width: 5,),
                    Text("${currencyFormat.format(totalPriceOfSingleBookingDayType(widget.totalPriceOfBookingDays!.specialDayList!))} VND", style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ))
                  ],
                )
              ],
            ),
          ) : const SizedBox(),
          widget.totalPriceOfBookingDays!.weekendList!.isNotEmpty ? Container(
            margin: const EdgeInsets.only(left: 10, bottom: 20),
            child: Column(

              children: [
                Row(

                  children: [
                    const Icon(Icons.date_range, color: kPrimaryColor,size: 17,),
                    const SizedBox(width: 10,),
                    Text("${widget.totalPriceOfBookingDays!.weekendList!.length}", style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    )),
                    const SizedBox(width: 5,),
                    const Text("weekends", style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    )),
                    SizedBox(
                      width: 160,
                      child: ElevatedButton.icon (
                        onPressed: () {
                          showDialog(context: context, builder: (context) => AlertDialog(
                            title: const Center(
                              child: Text("Weekend"),
                            ),
                            content: SizedBox(
                              height:widget.totalPriceOfBookingDays!.weekendList!.length == 1 ? 70 : widget.totalPriceOfBookingDays!.weekendList!.length < 3 ? 140 : 400,
                              width: 100,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: SizedBox(
                                  height: widget.totalPriceOfBookingDays!.weekendList!.length == 1 ? 70 :  widget.totalPriceOfBookingDays!.weekendList!.length < 3 ? 140 : 400,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: SizedBox(
                                      height: widget.totalPriceOfBookingDays!.weekendList!.length == 1 ? 70 : widget.totalPriceOfBookingDays!.weekendList!.length < 3 ? 140 : 400,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: widget.totalPriceOfBookingDays!.weekendList!.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.only(bottom: 0),
                                            child: ListTile(
                                              title: Text(formatDate.format(widget.totalPriceOfBookingDays!.weekendList![index])),
                                              subtitle: Text("weekend - ${currencyFormat.format(widget.homestayModel!.homestayPriceLists!
                                                  .where((element) => element.type.compareTo("weekend") == 0).single.price)}", style: const TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'OpenSans',
                                                letterSpacing: 1.0,
                                                color: Colors.green,
                                              )),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: const RoundedRectangleBorder()
                                ),
                                child: const Text("Back", style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.0,
                                  color: Colors.lightBlueAccent,
                                ),),
                              )
                            ],
                          ),);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: const RoundedRectangleBorder(),
                        ),
                        icon: const Icon(Icons.remove_red_eye, color: Colors.green),
                        label: const Text("View details", style: TextStyle(color: Colors.green),),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.monetization_on, color: Colors.yellow, size: 17,),
                    const SizedBox(width: 10,),
                    const Text("Total weekend price:", style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    )),
                    const SizedBox(width: 5,),
                    Text("${currencyFormat.format(totalPriceOfSingleBookingDayType(widget.totalPriceOfBookingDays!.weekendList!))} VND", style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ))
                  ],
                )

              ],
            ),
          ) : const SizedBox(),
          widget.totalPriceOfBookingDays!.normalDayList!.isNotEmpty ? Container(
            margin: const EdgeInsets.only(left: 10, bottom: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.date_range, color: kPrimaryColor,size: 17,),
                    const SizedBox(width: 10,),
                    Text("${widget.totalPriceOfBookingDays!.normalDayList!.length}", style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    )),
                    const SizedBox(width: 5,),
                    const Text("normal days", style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    )),
                    SizedBox(
                      width: 160,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(context: context, builder: (context) => AlertDialog(
                            title: const Center(
                              child: Text("Normal day"),
                            ),
                            content: SizedBox(
                              height: widget.totalPriceOfBookingDays!.normalDayList!.length == 1 ? 70 : widget.totalPriceOfBookingDays!.normalDayList!.length < 3 ? 140 : 400,
                              width: 100,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: SizedBox(
                                  height: widget.totalPriceOfBookingDays!.normalDayList!.length == 1 ? 70 : widget.totalPriceOfBookingDays!.normalDayList!.length < 3 ? 140 : 400,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: widget.totalPriceOfBookingDays!.normalDayList!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 0),
                                        child: ListTile(
                                          title: Text(formatDate.format(widget.totalPriceOfBookingDays!.normalDayList![index])),
                                          subtitle: Text("Normal day - ${currencyFormat.format(widget.homestayModel!.homestayPriceLists!
                                              .where((element) => element.type.compareTo("normal") == 0).single.price)}", style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'OpenSans',
                                            letterSpacing: 1.0,
                                            color: Colors.green,
                                          )),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: const RoundedRectangleBorder()
                                ),
                                child: const Text("Back", style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.0,
                                  color: Colors.lightBlueAccent,
                                ),),
                              )
                            ],
                          ),);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: const RoundedRectangleBorder(),
                        ),
                        icon: const Icon(Icons.remove_red_eye, color: Colors.green),
                        label: const Text("View details", style: TextStyle(color: Colors.green),),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.monetization_on, color: Colors.yellow, size: 17,),
                    const SizedBox(width: 10,),
                    const Text("Total normal price:", style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    )),
                    const SizedBox(width: 5,),
                    Text("${currencyFormat.format(totalPriceOfSingleBookingDayType(widget.totalPriceOfBookingDays!.normalDayList!))} VND", style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ))
                  ],
                )
              ],

            ),
          ) : const SizedBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10,),
              Container(
                width: 300,
                margin: const EdgeInsets.only(bottom: 10),
                child: const Divider(color: Colors.black54, thickness: 1.0, indent: 0.5, endIndent: 0.5,),
              ),
              Container(
                width: 250,
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const Text("Total rent", style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                    const SizedBox(width: 20,),
                    Text("${currencyFormat.format(widget.totalPriceOfBookingDays!.totalPrice)} vnd", style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.5,
                      color: Colors.black,
                    ))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text("Your services: ", style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    )),
                  ],
                ),
                const SizedBox(height: 10,),
                widget.homestayServiceList!.isNotEmpty ? Column(
                  children: [
                    SizedBox(
                      height: widget.homestayServiceList!.length == 1 ? 26 : widget.homestayServiceList!.length == 2 ? 52 : widget.homestayServiceList!.length == 3 ? 75 : 100,
                      child: ListView.builder(
                        itemCount: widget.homestayServiceList!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.room_service, color: kPrimaryLightColor, size: 17,),
                                Text(widget.homestayServiceList![index].name, style: const TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 2.0,
                                  color: Colors.black,
                                )),
                                const SizedBox(width: 10,),
                                const Text("-"),
                                const SizedBox(width: 10,),
                                const Icon(Icons.monetization_on, color: Colors.yellow, size: 17,),
                                Text("${currencyFormat.format(widget.homestayServiceList![index].price!)} vnd", style: const TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 2.0,
                                  color: Colors.black,
                                )),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      width: 300,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Divider(color: Colors.black54, thickness: 1.0, indent: 0.5, endIndent: 0.5,),
                    ),
                    Container(
                      width: 250,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          const Text("Total service: ", style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'OpenSans',
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                          const SizedBox(width: 20,),
                          Text("${currencyFormat.format(totalServicePrice())} vnd", style: const TextStyle(
                            fontSize: 17,
                            fontFamily: 'OpenSans',
                            letterSpacing: 1.0,
                            color: Colors.black,
                          ))
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Update service", style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'OpenSans',
                          letterSpacing: 1.5,
                          color: kPrimaryLightColor,
                        ))
                    )
                  ],
                ) : Column(
                  children: [
                    const Text("You didn't choose any services.", style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      color: Colors.black,
                    )),
                    const SizedBox(height: 15,),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BookingScreen(
                            homestayModel: widget.homestayModel,
                            chooseCheckInPhase: false,
                            chooseCheckOutPhase: false,
                            chooseServicesPhase: true,
                            checkInDate: widget.checkIn,
                            checkOutDate: widget!.checkOut!,
                            totalPriceOfBookingDays: widget.totalPriceOfBookingDays,
                          ),));
                        },
                        style: ElevatedButton.styleFrom(
                          maximumSize: const Size(150,50),
                          minimumSize: const Size(150, 50),
                          primary: kPrimaryColor
                        ),
                        child: const Text("Choose service")
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Column(
                  children: [
                    const Text("Your total booking price", style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    )),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text("(total rent + total service)", style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'OpenSans',
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      )),
                    ),
                    const SizedBox(height: 15,),
                    Text("${currencyFormat.format(totalBookingPrice)} VND", style: const TextStyle(
                      fontSize: 25,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ))
                  ],
                ),
                const SizedBox(height: 10,),
                Column(
                  children: [
                    const Text("Your total deposit", style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    )),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text("(50% of total booking price)", style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'OpenSans',
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      )),
                    ),
                    const SizedBox(height: 15,),
                    Text("${currencyFormat.format(deposit)} VND", style: const TextStyle(
                      fontSize: 25,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ))
                  ],
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: () {
                      showDialog(context: context, builder: (context) => AlertDialog(
                        title: const Center(child: Text("Inform your balance change"),),
                        content: SizedBox(
                          height: 200,
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
                                  Text(currencyFormat.format(widget.balance! - deposit), style: const TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'OpenSans',
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  )),
                                  const SizedBox(width: 20,),
                                  Text("-${currencyFormat.format(deposit)}", style: const TextStyle(
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
                                  Text(currencyFormat.format(widget.futurePay! + (totalBookingPrice - deposit)), style: const TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'OpenSans',
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  )),
                                  const SizedBox(width: 20,),
                                  Text("+${currencyFormat.format(totalBookingPrice - deposit)}", style: const TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'OpenSans',
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  )),
                                ],
                              )
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
                              child: const Text("Cancel")
                          ),
                          ElevatedButton(
                              onPressed: () {
                                BookingModel bookingModel = BookingModel(
                                    homestayName: widget.homestayModel!.name!,
                                    homestayServiceList: widget.homestayServiceList!,
                                    totalPrice: totalBookingPrice,
                                    deposit: deposit,
                                    checkIn: widget.checkIn,
                                    checkOut: widget.checkOut
                                );
                                Navigator.push(context, MaterialPageRoute(builder: (context) => HomestayBookingNavigator(bookingModel: bookingModel, username: firebaseAuth.currentUser!.displayName, amount: int.parse(depositTextFieldController.text)),));
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                  maximumSize: const Size(150, 56),
                                  minimumSize: const Size(150, 56)
                              ),
                              child: const Text("Pay deposit")
                          ),
                        ],
                      ),);



                    },
                    child: Text("Confirm booking".toUpperCase())
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
