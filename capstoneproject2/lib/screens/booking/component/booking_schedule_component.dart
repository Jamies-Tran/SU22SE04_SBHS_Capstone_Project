import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/screens/booking/booking_screen.dart';
import 'package:capstoneproject2/services/booking_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/booking_model.dart';
import 'package:capstoneproject2/services/model/homestay_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class BookingScheduleComponent extends StatefulWidget {
  const BookingScheduleComponent({Key? key, this.homestayModel, this.chosenDate, this.isUpdateCheckInDate, this.isUpdateCheckOutDate}) : super(key: key);
  final HomestayModel? homestayModel;
  final String? chosenDate;
  final isUpdateCheckInDate;
  final isUpdateCheckOutDate;


  @override
  State<BookingScheduleComponent> createState() => _BookingScheduleComponentState();
}

class _BookingScheduleComponentState extends State<BookingScheduleComponent> {
  final formatDate = DateFormat("yyyy-MM-dd");
  bool isSelectedCheckInDate = false;
  var checkInDate;
  var checkOutDate;
  var firstPickUpCheckInDate;
  var showAlert = false;
  var alertMessage;
  var currentDate;

  @override
  Widget build(BuildContext context) {
    final bookingService = locator.get<IBookingService>();
    currentDate = widget.isUpdateCheckInDate ? formatDate.parse(widget!.chosenDate!) : isSelectedCheckInDate ? formatDate.parse(checkInDate) : DateTime.now();
    Future<List<Appointment>> getBookingList() async {
      List<Appointment> sources = <Appointment>[];
      List<BookingModel> bookingList = await bookingService.getHomestayBookingList(widget.homestayModel!.name, bookingStatus["all"]!);
      bookingList = bookingList.where((element) =>
                      !(element.status.compareTo(bookingStatus["pending"]) == 0) &&
                      !(element.status.compareTo(bookingStatus["rejected"]) == 0) &&
                      !(element.status.compareTo(bookingStatus["canceled"]) == 0) &&
                      !(element.status.compareTo(bookingStatus["check_out"]) == 0) &&
                      !(element.status.compareTo(bookingStatus["finish"]) == 0)
      ).toList();

      if(widget.chosenDate != null && widget.chosenDate != "") {
        sources.add(Appointment(
            startTime: formatDate.parse(widget!.chosenDate!),
            endTime: formatDate.parse(widget!.chosenDate!),
            color: kPrimaryColor,
            isAllDay: true,
            notes: "picked"
        ));
      }
      if(firstPickUpCheckInDate != null && firstPickUpCheckInDate != "") {
        sources.add(Appointment(
            startTime: formatDate.parse(firstPickUpCheckInDate),
            endTime: formatDate.parse(firstPickUpCheckInDate),
            color: Colors.amber,
            notes: "picked"
        ));
      }
      bookingList.forEach((bElement) {
        sources.add(Appointment(
          startTime: formatDate.parse(bElement.checkIn),
          endTime: formatDate.parse(bElement.checkOut),
          color: Colors.red,
          notes: "busy"
        ));
      });
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

    return FutureBuilder(
      future: getBookingList(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitComponent();
        } else if(snapshot.hasData) {
          var snapshotData = snapshot.data as List<Appointment>;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  widget.isUpdateCheckInDate ? "update check-in date" : widget.isUpdateCheckOutDate ? "update check-out date"
                      : isSelectedCheckInDate ? "choose checkout date" : "choose checkin date"
              ),
            ),
            body: Stack(
              children: [
                SfCalendar(
                  view: CalendarView.month,
                  backgroundColor: Colors.white12,
                  cellBorderColor: Colors.white,
                  minDate: DateTime.now(),
                  onTap:(calendarTapDetails) {
                    if(calendarTapDetails.appointments!.isEmpty
                        || calendarTapDetails.appointments!.any((element) => element.notes.compareTo("picked") == 0)) {
                      if(widget.isUpdateCheckInDate || widget.isUpdateCheckOutDate) {
                        var date = formatDate.format( calendarTapDetails!.date!);
                        Navigator.pop(context, date);
                      }
                      // check out
                      if(isSelectedCheckInDate && checkInDate != null) {
                        var checkIn = formatDate.parse(checkInDate);
                        if(isThroughBusyDay(checkIn, calendarTapDetails!.date!, snapshotData)) {
                          setState(() {
                            showAlert = true;
                            alertMessage = "Through homestay busy date";
                          });
                        } else {
                          setState(() {

                            if(calendarTapDetails!.date!.isBefore(formatDate.parse(checkInDate))) {
                              checkOutDate = checkInDate;
                            }else {
                              checkOutDate = formatDate.format(calendarTapDetails!.date!);
                            }

                          });

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BookingScreen(homestayModel: widget.homestayModel, CheckInDate: checkInDate, CheckOutDate: checkOutDate),));
                        }

                      } else {
                        setState(() {
                          checkInDate = formatDate.format(calendarTapDetails!.date!);
                          firstPickUpCheckInDate = formatDate.format(calendarTapDetails!.date!);
                          isSelectedCheckInDate = true;
                          showAlert = true;
                          alertMessage = "check in chosen";
                        });
                      }
                    } else {
                      setState(() {
                        showAlert = true;
                        alertMessage = "Homestay busy!";
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
