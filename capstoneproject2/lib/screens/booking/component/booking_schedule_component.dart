import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/screens/booking/booking_screen.dart';
import 'package:capstoneproject2/services/booking_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/booking_model.dart';
import 'package:capstoneproject2/services/model/homestay_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class BookingScheduleComponent extends StatefulWidget {
  const BookingScheduleComponent({
    Key? key,
    this.homestayModel,
    this.chosenCheckInDate,
    this.chooseCheckInDate,
    this.chooseCheckOutDate,
    this.isUpdateCheckInDate,
    this.isUpdateCheckOutDate,
    this.balance
  }) : super(key: key);
  final HomestayModel? homestayModel;
  final String? chosenCheckInDate;
  final bool? chooseCheckInDate;
  final bool? chooseCheckOutDate;
  final int? balance;
  final isUpdateCheckInDate;
  final isUpdateCheckOutDate;


  @override
  State<BookingScheduleComponent> createState() => _BookingScheduleComponentState();
}

class _BookingScheduleComponentState extends State<BookingScheduleComponent> {
  final formatDate = DateFormat("yyyy-MM-dd");
  final currencyFormat = NumberFormat("#,##0");
  bool isSelectedCheckInDate = false;
  var checkInDate;
  var checkOutDate;
  var firstPickUpCheckInDate;
  var showAlert = false;
  var alertMessage;
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var currentDate = widget.chosenCheckInDate != null && widget.chosenCheckInDate != "" ? formatDate.parse(widget!.chosenCheckInDate!) : DateTime.now();
    final bookingService = locator.get<IBookingService>();

    Future<List<Appointment>> homestayBookingListConfiguration() async {
      List<Appointment> sources = <Appointment>[];
      List<BookingModel> bookingList = await bookingService.getHomestayBookingList(widget.homestayModel!.name, bookingStatus["all"]!);
      bookingList = bookingList.where((element) =>
                      !(element.status.compareTo(bookingStatus["pending"]) == 0) &&
                      !(element.status.compareTo(bookingStatus["rejected"]) == 0) &&
                      !(element.status.compareTo(bookingStatus["canceled"]) == 0) &&
                      !(element.status.compareTo(bookingStatus["check_out"]) == 0) &&
                      !(element.status.compareTo(bookingStatus["finish"]) == 0)
      ).toList();

      if(widget.chosenCheckInDate != null && widget.chosenCheckInDate != "") {
        sources.add(Appointment(
            startTime: formatDate.parse(widget!.chosenCheckInDate!),
            endTime: formatDate.parse(widget!.chosenCheckInDate!),
            color: Colors.green,
            isAllDay: true,
            notes: "picked"
        ));
      }

      for(int i = 0; i < now.add(const Duration(days: 365)).difference(now).inDays; i++) {

        now = now.add(const Duration(days: 1));

        // if(now.month == 4 && now.day == 30) {
        //   sources.add(Appointment(startTime: formatDate.parse(now.toString()), endTime: formatDate.parse(now.toString()), color: Colors.amber, isAllDay: true,notes: "special"));
        // }
        for (var element in widget.homestayModel!.homestayPriceLists) {
          if(element.type.compareTo("special") == 0) {
            if(now.day == element.specialDayPriceList!.startDay && now.month == element.specialDayPriceList!.startMonth) {
              DateTime specialStartTime = DateTime(now.year, element.specialDayPriceList!.startMonth, element.specialDayPriceList!.startDay, 0 ,0 ,0, 0, 0);
              DateTime specialEndTime = DateTime(now.year, element.specialDayPriceList!.endMonth, element.specialDayPriceList!.endDay, 0 ,0 ,0, 0, 0);
              sources.add(Appointment(
                  startTime: specialStartTime,
                  endTime: specialEndTime,
                  color: Colors.amber,
                  notes: "special_${element.specialDayPriceList!.specialDayCode}"
              ));
            }
          }
        }
      }
      for (var bElement in bookingList) {
        sources.add(Appointment(
          startTime: formatDate.parse(bElement.checkIn),
          endTime: formatDate.parse(bElement.checkOut),
          color: Colors.red,
          notes: "busy"
        ));
      }
      return sources;
    }

    bool isThroughBusyDay(DateTime checkIn, DateTime checkOut, List<Appointment> source) {
      bool result = false;
      source.forEach((element) {
        if(element.notes!.compareTo("busy") == 0) {
          if(element.startTime.isAfter(checkIn) && element.endTime.isBefore(checkOut)) {
            result = true;
          }
        }
      });

      return result;
    }

    TotalPriceOfBookingDays totalPricesOfBookingDays(DateTime checkIn, DateTime checkOut, List<Appointment> src) {
      int total = 0;
      List<DateTime> normalDayList = [];
      List<DateTime> specialDayList = [];
      List<DateTime> weekendList = [];
      DateTime observeCurrentDate = checkIn;
      while(checkOut.difference(observeCurrentDate).inDays >= 0) {
        if(src.where((element) => observeCurrentDate.difference(element.startTime).inDays >= 0 && observeCurrentDate.difference(element.endTime).inDays <= 0).isEmpty) {
          if(widget.homestayModel!.homestayPriceLists.where((element) => element.type.compareTo("weekend") == 0).isNotEmpty
              && (observeCurrentDate.weekday == DateTime.saturday || observeCurrentDate.weekday == DateTime.sunday)) {

            total = total + widget.homestayModel!.homestayPriceLists
                .where((priceListElement) => priceListElement.type.compareTo("weekend") == 0).single.price as int;

            weekendList.add(observeCurrentDate);
          } else {
            total = total + widget.homestayModel!.homestayPriceLists.where((element) => element.type.compareTo("normal") == 0).single.price as int;
            normalDayList.add(observeCurrentDate);
          }
        } else {
          src.where((element) => observeCurrentDate.difference(element.startTime).inDays >= 0 && observeCurrentDate.difference(element.endTime).inDays <= 0)
              .forEach((element) {
                total = total + widget.homestayModel!.homestayPriceLists
                    .where((priceListElement) => priceListElement.type.compareTo("special") == 0 && priceListElement.specialDayPriceList!.specialDayCode.compareTo(element.notes!.split("_").last) == 0).single.price as int;
          });
          specialDayList.add(observeCurrentDate);
        }

        observeCurrentDate = observeCurrentDate.add(const Duration(days: 1));
      }
      TotalPriceOfBookingDays totalPriceOfBookingDays = TotalPriceOfBookingDays(totalPrice: total, normalDayList: normalDayList, specialDayList: specialDayList, weekendList: weekendList);
      
      return totalPriceOfBookingDays;
    }


    return FutureBuilder(
      future: homestayBookingListConfiguration(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitComponent();
        } else if(snapshot.hasData) {
          var snapshotData = snapshot.data as List<Appointment>;
          return Scaffold(
            // appBar: AppBar(
            //   title: Text(
            //       widget.isUpdateCheckInDate ? "update check-in date" : widget.isUpdateCheckOutDate ? "update check-out date"
            //           : isSelectedCheckInDate ? "choose checkout date" : "choose checkin date"
            //   ),
            // ),
            body: Stack(
              children: [
                SfCalendar(
                  view: CalendarView.month,
                  backgroundColor: Colors.white12,
                  cellBorderColor: Colors.white,
                  minDate: currentDate,
                  maxDate: DateTime.now().add(const Duration(days: 365)),
                  onTap:(calendarTapDetails) {

                    if(widget.isUpdateCheckInDate || widget.isUpdateCheckOutDate) {
                      var date = formatDate.format( calendarTapDetails!.date!);
                      Navigator.pop(context, date);
                    }
                    // check out
                    if(widget!.chooseCheckOutDate! == true && widget!.chooseCheckInDate! == false && widget!.chosenCheckInDate != null) {
                      List<Appointment> specialDayList = snapshotData.where((element) => element.notes!.contains("special")).toList();
                      //widget!.chosenCheckInDate != null  ? print("Total: ${totalPricesOfBookingDays(formatDate.parse(widget!.chosenCheckInDate!), formatDate.parse(calendarTapDetails!.date!.toString()), specialDayList).totalPrice}") : print("not thing here");
                      TotalPriceOfBookingDays totalPriceBookingDays = totalPricesOfBookingDays(formatDate.parse(widget!.chosenCheckInDate!), formatDate.parse(calendarTapDetails!.date!.toString()), specialDayList);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Center(child: Text("Overview"),),
                          content: Container(
                            height: 400,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Your chosen days:", style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'OpenSans',
                                    letterSpacing: 3.0,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold
                                )),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        formatDate.format(formatDate.parse(widget!.chosenCheckInDate!)), style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'OpenSans',
                                      letterSpacing: 1.0,
                                      color: Colors.black87,
                                    )),
                                    const SizedBox(width: 5,),
                                    const Icon(Icons.forward, color: kPrimaryLightColor, size: 13,),
                                    const SizedBox(width: 5,),
                                    Text(
                                        formatDate.format(calendarTapDetails!.date!), style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'OpenSans',
                                      letterSpacing: 1.0,
                                      color: Colors.black87,
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  width: 100,
                                  child: Divider(color: Colors.black, indent: 1.0, endIndent: 1.0, thickness: 1.0, height: 30,),
                                ),
                                // const Text("Overview", style: TextStyle(
                                //     fontSize: 15,
                                //     fontFamily: 'OpenSans',
                                //     letterSpacing: 3.0,
                                //     color: Colors.black87,
                                //     fontWeight: FontWeight.bold
                                // )),
                                const SizedBox(height: 5),
                                // special day
                                // totalPriceBookingDays.specialDayList!.isNotEmpty ? Text("${ totalPriceBookingDays.specialDayList!.length} special day:") : SizedBox(),
                                // const SizedBox(height: 5,),
                                // totalPriceBookingDays.specialDayList!.isNotEmpty ? SizedBox(
                                //   height: 120,
                                //   width: 200,
                                //   child: SingleChildScrollView(
                                //       scrollDirection: Axis.vertical,
                                //       physics: const AlwaysScrollableScrollPhysics(),
                                //       child: Column(
                                //         mainAxisAlignment: MainAxisAlignment.start,
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         children: [
                                //           SizedBox(
                                //             child: ListView.builder(
                                //               itemCount: totalPriceBookingDays.specialDayList!.length,
                                //               shrinkWrap: true,
                                //               scrollDirection: Axis.vertical,
                                //               physics: const NeverScrollableScrollPhysics(),
                                //               itemBuilder: (context, index) {
                                //                 return Container(
                                //                   margin: const EdgeInsets.only(bottom: 20),
                                //                   height: 50,
                                //                   child: ListTile(
                                //                     title: Text(formatDate.format(totalPriceBookingDays.specialDayList![index])),
                                //                     subtitle: Text("${widget.homestayModel!.homestayPriceLists.where((element) => element.type.compareTo("special") == 0 && formatDate.parse(DateTime(now.year, element.specialDayPriceList!.startMonth, element.specialDayPriceList!.startDay, 0, 0, 0, 0, 0).toString()).difference(formatDate.parse(totalPriceBookingDays.specialDayList![index].toString())).inDays <= 0
                                //                         && formatDate.parse(DateTime(now.year, element.specialDayPriceList!.endMonth, element.specialDayPriceList!.endDay, 0, 0, 0, 0, 0).toString()).difference(formatDate.parse(totalPriceBookingDays.specialDayList![index].toString())).inDays >=0).single.specialDayPriceList!.description} - ${currencyFormat.format(widget.homestayModel!.homestayPriceLists.where((element) => element.type.compareTo("special") == 0 && formatDate.parse(DateTime(now.year, element.specialDayPriceList!.startMonth, element.specialDayPriceList!.startDay, 0, 0, 0, 0, 0).toString()).difference(formatDate.parse(totalPriceBookingDays.specialDayList![index].toString())).inDays <= 0
                                //                         && formatDate.parse(DateTime(now.year, element.specialDayPriceList!.endMonth, element.specialDayPriceList!.endDay, 0, 0, 0, 0, 0).toString()).difference(formatDate.parse(totalPriceBookingDays.specialDayList![index].toString())).inDays >=0).single.price)}", style: const TextStyle(
                                //
                                //                       fontFamily: 'OpenSans',
                                //                       letterSpacing: 1.0,
                                //                       color: Colors.green,
                                //                     )),
                                //                   ),
                                //                 );
                                //               },
                                //             ),
                                //           )
                                //         ],
                                //       )
                                //   ),
                                // ) : const SizedBox(),
                                // const SizedBox(height: 20,),
                                // // weekend
                                // totalPriceBookingDays.weekendList!.isNotEmpty ? Text("${ totalPriceBookingDays.weekendList!.length} Weekend:") : SizedBox(),
                                // const SizedBox(height: 5,),
                                // totalPriceBookingDays.weekendList!.isNotEmpty ? SizedBox(
                                //   height: 120,
                                //   width: 200,
                                //   child: SingleChildScrollView(
                                //       scrollDirection: Axis.vertical,
                                //       physics: const AlwaysScrollableScrollPhysics(),
                                //       child: Column(
                                //         mainAxisAlignment: MainAxisAlignment.start,
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         children: [
                                //           SizedBox(
                                //             child: ListView.builder(
                                //               itemCount: totalPriceBookingDays.weekendList!.length,
                                //               shrinkWrap: true,
                                //               scrollDirection: Axis.vertical,
                                //               physics: const NeverScrollableScrollPhysics(),
                                //               itemBuilder: (context, index) {
                                //                 return Container(
                                //                   margin: const EdgeInsets.only(bottom: 5),
                                //                   height: 50,
                                //                   child: ListTile(
                                //                     title: Text(formatDate.format(totalPriceBookingDays.weekendList![index])),
                                //                     subtitle: Text("Weekend - ${widget.homestayModel!.homestayPriceLists.where((element) => element.type.compareTo("weekend") == 0).single.price}", style: const TextStyle(
                                //                       fontFamily: 'OpenSans',
                                //                       letterSpacing: 1.0,
                                //                       color: Colors.green,
                                //                     )),
                                //                   ),
                                //                 );
                                //               },
                                //             ),
                                //           )
                                //         ],
                                //       )
                                //   ),
                                // ) : const SizedBox(),
                                // const SizedBox(height: 20,),
                                // // normal day
                                // totalPriceBookingDays.normalDayList!.isNotEmpty ? Text("${totalPriceBookingDays.normalDayList!.length} normal day: ") : const SizedBox(),
                                // const SizedBox(height: 5,),
                                // totalPriceBookingDays.normalDayList!.isNotEmpty ? SizedBox(
                                //   height: 120,
                                //   width: 200,
                                //   child: Scrollbar(
                                //     thickness: 2.0,
                                //     child: SingleChildScrollView(
                                //         scrollDirection: Axis.vertical,
                                //         physics: const AlwaysScrollableScrollPhysics(),
                                //         child: Column(
                                //           mainAxisAlignment: MainAxisAlignment.center,
                                //           children: [
                                //             SizedBox(
                                //               child: ListView.builder(
                                //                 itemCount: totalPriceBookingDays.normalDayList!.length,
                                //                 shrinkWrap: true,
                                //                 scrollDirection: Axis.vertical,
                                //                 physics: const NeverScrollableScrollPhysics(),
                                //                 itemBuilder: (context, index) {
                                //                   return Container(
                                //                     margin: const EdgeInsets.only(bottom: 5),
                                //                     height: 50,
                                //                     child: ListTile(
                                //                       title: Text(formatDate.format(totalPriceBookingDays.normalDayList![index])),
                                //                       subtitle: Text("Normal day - ${currencyFormat.format(widget.homestayModel!.homestayPriceLists
                                //                           .where((element) => element.type.compareTo("normal") == 0).single.price)}", style: const TextStyle(
                                //                         fontSize: 13,
                                //                         fontFamily: 'OpenSans',
                                //                         letterSpacing: 1.0,
                                //                         color: Colors.green,
                                //                       )),
                                //                     ),
                                //                   );
                                //                 },
                                //               ),
                                //             )
                                //           ],
                                //         )
                                //     ),
                                //   ),
                                // ) : const SizedBox(),
                                ListTile(
                                  title: const Text("Special day"),
                                  subtitle: totalPriceBookingDays.specialDayList!.isNotEmpty ? Text(totalPriceBookingDays.specialDayList!.length == 1 ? "${totalPriceBookingDays.specialDayList!.length} day selected" : "${totalPriceBookingDays.specialDayList!.length} days selected",
                                  style: const TextStyle(color: Colors.green),) : const Text("No special day selected", style: TextStyle(color: Colors.orangeAccent)),
                                ),
                                const SizedBox(height: 20),
                                ListTile(
                                  title: const Text("Weekend"),
                                  subtitle: totalPriceBookingDays.weekendList!.isNotEmpty ? Text(totalPriceBookingDays.weekendList!.length == 1 ? "${totalPriceBookingDays.weekendList!.length} day selected" : "${totalPriceBookingDays.weekendList!.length} days selected",
                                      style: const TextStyle(color: Colors.green)) : const Text("No weekend selected", style: TextStyle(color: Colors.orangeAccent)),
                                ),
                                const SizedBox(height: 20),
                                ListTile(
                                  title: const Text("Normal day"),
                                  subtitle: totalPriceBookingDays.normalDayList!.isNotEmpty ? Text(totalPriceBookingDays.normalDayList!.length == 1 ? "${totalPriceBookingDays.normalDayList!.length} day selected" : "${totalPriceBookingDays.normalDayList!.length} days selected",
                                      style: const TextStyle(color: Colors.green)) : const Text("No normal day selected", style: TextStyle(color: Colors.orangeAccent)),
                                ),

                                const SizedBox(
                                  width: 200,
                                  child: Divider(color: Colors.black, indent: 1.0, endIndent: 1.0, thickness: 1.0, height: 30,),
                                ),

                                Text("Total: ${currencyFormat.format(totalPriceBookingDays.totalPrice)} VND", style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.0,
                                  color: widget!.balance! < totalPriceBookingDays!.totalPrice! ? Colors.redAccent : Colors.green,
                                ))
                              ],
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                  maximumSize: const Size(100, 56),
                                  minimumSize: const Size(100, 56)
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel".toUpperCase()),
                            ),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: isThroughBusyDay(formatDate.parse(widget!.chosenCheckInDate!), calendarTapDetails!.date!, snapshotData) ? Colors.grey : widget!.balance! < totalPriceBookingDays!.totalPrice! ? Colors.red : Colors.green,
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                  maximumSize: const Size(150, 56),
                                  minimumSize: const Size(150, 56)
                              ),
                              onPressed: () {
                                if(!isThroughBusyDay(formatDate.parse(widget!.chosenCheckInDate!), calendarTapDetails!.date!, snapshotData)) {
                                  if(widget!.balance! >= totalPriceBookingDays!.totalPrice!) {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BookingScreen(
                                      homestayModel: widget.homestayModel,
                                      chooseCheckInPhase: false,
                                      chooseCheckOutPhase: false,
                                      chooseServicesPhase: true,
                                      checkInDate: widget.chosenCheckInDate,
                                      checkOutDate: formatDate.format(calendarTapDetails!.date!),
                                      totalPriceOfBookingDays: totalPriceBookingDays,
                                    ),));
                                  }
                                }
                              },
                              child: Text(isThroughBusyDay(formatDate.parse(widget!.chosenCheckInDate!),
                                  calendarTapDetails!.date!, snapshotData) ? "Homestay busy".toUpperCase() : widget!.balance! < totalPriceBookingDays!.totalPrice! ? "Not enough balance".toUpperCase() : "Choose services".toUpperCase()),
                            )

                          ],
                        ),
                      );
                      // var checkIn = formatDate.parse(checkInDate);
                      // if(isThroughBusyDay(checkIn, calendarTapDetails!.date!, snapshotData)) {
                      //   setState(() {
                      //     showAlert = true;
                      //     alertMessage = "Through homestay busy date";
                      //   });
                      // } else {
                      //   setState(() {
                      //
                      //     if(calendarTapDetails!.date!.isBefore(formatDate.parse(checkInDate))) {
                      //       checkOutDate = checkInDate;
                      //     }else {
                      //       checkOutDate = formatDate.format(calendarTapDetails!.date!);
                      //     }
                      //
                      //   });
                      //
                      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BookingScreen(homestayModel: widget.homestayModel),));
                      // }

                    } else {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Center(child: Text("Overview"),),
                            content: Container(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Check-in: ", style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      letterSpacing: 1.5,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                    )),
                                    Text(
                                        formatDate.format(calendarTapDetails!.date!), style: const TextStyle(
                                        fontFamily: 'OpenSans',
                                        letterSpacing: 1.5,
                                        color: Colors.black,
                                    ))
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
                                      maximumSize: const Size(100, 56),
                                      minimumSize: const Size(100, 56)
                                  ),
                                  child: const Text("Cancel")
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BookingScreen(
                                      homestayModel: widget.homestayModel,
                                      checkInDate: formatDate.format(calendarTapDetails!.date!),
                                      chooseCheckOutPhase: true,
                                      chooseCheckInPhase: false,
                                    ),
                                    ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                      maximumSize: const Size(150, 56),
                                      minimumSize: const Size(150, 56)
                                  ),
                                  child: const Text("Choose check-out")
                              ),
                            ],
                          ),
                        );
                      });
                    }
                  },
                  dataSource: BookingScheduleSource(snapshotData),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: showAlert ? Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Text(alertMessage),
                      ) : Container()
                    )
                  ],
                )
              ],
            ),
          );
        } else {
          return const Scaffold();
        }
      },
    );
  }
}


class BookingScheduleSource extends CalendarDataSource {
  BookingScheduleSource(List<Appointment> source) {
    appointments = source;
  }
}

class TotalPriceOfBookingDays {
  final int? totalPrice;
  final List<DateTime>? normalDayList;
  final List<DateTime>? specialDayList;
  final List<DateTime>? weekendList;
  
  TotalPriceOfBookingDays({this.totalPrice, this.normalDayList, this.specialDayList, this.weekendList});
}
