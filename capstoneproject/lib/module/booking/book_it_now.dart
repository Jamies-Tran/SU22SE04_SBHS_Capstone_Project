import 'package:capstoneproject/base/base_event.dart';
import 'package:capstoneproject/base/base_widget.dart';
import 'package:capstoneproject/data/repository/booking_repository.dart';
import 'package:capstoneproject/data/service/booking_service.dart';
import 'package:capstoneproject/module/booking/booking_bloc.dart';
import 'package:capstoneproject/module/booking/event/booking_event.dart';
import 'package:capstoneproject/module/profile/credit_card.dart';
import 'package:capstoneproject/shared_code/model/room_detail.dart';
import 'package:capstoneproject/ui_kit/widget/base_widget/bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final formatCurrency = NumberFormat.simpleCurrency();

class BookingRoomPage extends StatefulWidget {
  const BookingRoomPage({Key? key, required this.roomDetail}) : super(key: key);
  final RoomDetail roomDetail;

  @override
  State<BookingRoomPage> createState() => _BookingRoomPageState();
}

class _BookingRoomPageState extends State<BookingRoomPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: BookingRoom(roomDetail: widget.roomDetail),
      bloc: const [],
      di: [
        Provider.value(value: BookingService()),
        ProxyProvider<BookingService, BookingRepository>(
          update: (context, service, previous) =>
              BookingRepository(bookingService: service),
        ),
      ],
    );
  }
}

class BookingRoom extends StatefulWidget {
  final RoomDetail roomDetail;

  const BookingRoom({Key? key, required this.roomDetail}) : super(key: key);

  @override
  _BookingRoomState createState() => _BookingRoomState();
}

class _BookingRoomState extends State<BookingRoom> {
  String _book = "Book Now";

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  bool isDatePopupOpen = false;

  final List _listOccassion = [
    "1 Adults",
    "2 Adults",
    "3 Adults",
    "4 Adults",
    "5 Adults",
    "6 Adults",
    "7 Adults"
  ];

  bool booked = false;

  _checkFirst() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    if (!booked) {
      setState(() {
        _book = "Book Now";
      });
    } else {
      setState(() {
        _book = "Booked";
      });
    }
  }

  @override
  void initState() {
    _checkFirst();
    super.initState();
  }

  handleEvent(BaseEvent event) {}

  DateTime selectedDate = DateTime.now();

  TextEditingController locationController = TextEditingController();
  TextEditingController countController = TextEditingController();
  TextEditingController roomsController = TextEditingController();
  TextEditingController checkInController = TextEditingController();
  TextEditingController checkOutController = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String location;
    return ChangeNotifierProvider<BookingBloc>.value(
      value: BookingBloc(bookingRepository: Provider.of(context)),
      child: Consumer<BookingBloc>(builder: (context, bloc, child) {
        return BlocListener<BookingBloc>(
          listener: handleEvent,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text(
                'Book Now',
                style: TextStyle(fontFamily: "Sofia", color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: form,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        // const Text(
                        //   "Name",
                        //   style: TextStyle(
                        //       color: Colors.black,
                        //       fontFamily: "Sofia",
                        //       fontWeight: FontWeight.w700,
                        //       fontSize: 20.0),
                        // ),
                        // const Text(
                        //   "Email",
                        //   style: TextStyle(
                        //       color: Colors.black38,
                        //       fontFamily: "Sofia",
                        //       fontWeight: FontWeight.w300,
                        //       fontSize: 16.0),
                        // ),
                        // Container(
                        //   height: 90.0,
                        //   width: 90.0,
                        //   decoration: BoxDecoration(
                        //       image: const DecorationImage(
                        //           image: NetworkImage(
                        //               "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                        //           fit: BoxFit.cover),
                        //       color: Colors.white,
                        //       borderRadius: const BorderRadius.all(
                        //         Radius.circular(50.0),
                        //       ),
                        //       boxShadow: [
                        //         BoxShadow(
                        //             color: Colors.black12.withOpacity(0.1),
                        //             blurRadius: 10.0,
                        //             spreadRadius: 2.0)
                        //       ]),
                        // ),
                        getTimeDateUI(),
                        Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              rowItem('Name Room', widget.roomDetail.name!),

                              rowItem(
                                  "Price",
                                  formatCurrency
                                      .format(widget.roomDetail.price!)),

                              rowItem("Location", widget.roomDetail.location!),

                              const SizedBox(
                                height: 50.0,
                              ),

                              /// Button
                              GestureDetector(
                                onTap: () {
                                  print('tap');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 20.0),
                                  child: InkWell(
                                    onTap: () async {
                                      print(
                                          "${widget.roomDetail.id.toString()}  ${DateFormat("dd-MM-yyyy").format(startDate)} ${DateFormat("dd-MM-yyyy").format(endDate)} ${endDate.difference(startDate).inDays}");
                                      // bloc.event.add(
                                      //   BookingEvent(
                                      //     idRoom:
                                      //         widget.roomDetail.id.toString(),
                                      //     checkIn: DateFormat("dd-MM-yyyy")
                                      //         .format(startDate),
                                      //     checkOut: DateFormat("dd-MM-yyyy")
                                      //         .format(endDate),
                                      //     numberOfDays: endDate
                                      //         .difference(startDate)
                                      //         .inDays,
                                      //   ),
                                      // );
                                      Navigator.push(
                                        context,
                                        AddCreditCard.route(
                                          roomId: widget.roomDetail.id.toString(),
                                          checkIn: DateFormat("yyyy-MM-dd").format(startDate),
                                          checkOut: DateFormat("yyyy-MM-dd").format(endDate),
                                          clientMessage: "clientMessage",
                                        ),
                                      );
                                      print("object");
                                    },
                                    child: Container(
                                      height: 55.0,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          gradient: LinearGradient(
                                              colors: [
                                                Color(0xFF09314F),
                                                Color(0xFF09314F),
                                              ],
                                              begin: FractionalOffset(0.0, 0.0),
                                              end: FractionalOffset(1.0, 0.0),
                                              stops: [0.0, 1.0],
                                              tileMode: TileMode.clamp)),
                                      child: Center(
                                        child: Text(
                                          _book,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 19.0,
                                              fontFamily: "Sofia",
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget getTimeDateUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        isDatePopupOpen = true;
                      });
                      showDemoDialog(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Choose date',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Number of Rooms',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            '1 Room - 2 Adults',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget rowItem(String title, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 20.0, bottom: 2.0),
          child: Text(
            title,
            style: const TextStyle(
                fontFamily: "Sofia",
                fontWeight: FontWeight.w700,
                fontSize: 17.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10.0, color: Colors.black12.withOpacity(0.1)),
                ],
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Theme(
                  data: ThemeData(
                    highlightColor: Colors.white,
                    hintColor: Colors.white,
                  ),
                  child: TextFormField(
                      controller: locationController,
                      decoration: InputDecoration(
                        hintText: value,
                        hintStyle: const TextStyle(
                            fontFamily: "Sofia", color: Colors.black),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                              style: BorderStyle.none),
                        ),
                      )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showDemoDialog({BuildContext? context}) async {
    List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
      context: context!,
      primaryColor: Colors.cyan,
      backgroundColor: Colors.white,
      calendarTextColor: Colors.black,
      tabTextColor: Colors.black,
      unselectedTabBackgroundColor: Colors.grey,
      buttonTextColor: Colors.black,
      timeSpinnerTextStyle:
          const TextStyle(color: Colors.black54, fontSize: 18),
      timeSpinnerHighlightedTextStyle:
          const TextStyle(color: Colors.black, fontSize: 24),
      is24HourMode: false,
      isShowSeconds: false,
      startInitialDate: DateTime.now(),
      startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      startLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      endInitialDate: DateTime.now(),
      endFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      endLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      borderRadius: const Radius.circular(16),
    );

    setState(() {
      startDate = dateTimeList![0];
      endDate = dateTimeList[1];
    });
    // showDialog<dynamic>(
    //   context: context!,
    //   builder: (BuildContext context) => CalendarPopupView(
    //     barrierDismissible: true,
    //     minimumDate: DateTime.now(),
    //     //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
    //     initialEndDate: endDate,
    //     initialStartDate: startDate,
    //     onApplyClick: (DateTime startData, DateTime endData) {
    //       setState(() {
    //         startDate = startData;
    //         endDate = endData;
    //       });
    //     },
    //     onCancelClick: () {},
    //   ),
    // );
  }
}
