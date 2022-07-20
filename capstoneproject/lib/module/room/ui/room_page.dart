import 'dart:convert';

import 'package:capstoneproject/base/base_event.dart';
import 'package:capstoneproject/base/base_widget.dart';
import 'package:capstoneproject/data/repository/room_repository.dart';
import 'package:capstoneproject/data/service/room_service.dart';
import 'package:capstoneproject/event/base_event/expired_token_event.dart';
import 'package:capstoneproject/event/base_event/no_data_show_event.dart';
import 'package:capstoneproject/event/base_event/unknown_error_event.dart';
import 'package:capstoneproject/main.dart';
import 'package:capstoneproject/module/booking/book_it_now.dart';
import 'package:capstoneproject/module/map/directions_handler.dart';
import 'package:capstoneproject/module/map/map_screen.dart';
import 'package:capstoneproject/module/room/event/room_event.dart';
import 'package:capstoneproject/module/room/room_bloc.dart';
import 'package:capstoneproject/module/room/ui/hotel_info_tab.dart';
import 'package:capstoneproject/module/room/ui/hotel_review_tab.dart';
import 'package:capstoneproject/module/room/ui/hotel_room_tab.dart';
import 'package:capstoneproject/shared_code/model/room_detail.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_loading_view.dart';
import 'package:capstoneproject/ui_kit/widget/base_widget/bloc_listener.dart';
import 'package:capstoneproject/ui_kit/widget/loading_widget/loading_task.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';

class RoomPage extends StatefulWidget {
  final String id;

  const RoomPage({Key? key, required this.id}) : super(key: key);

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      bloc: const [],
      di: [
        Provider.value(value: RoomService()),
        ProxyProvider<RoomService, RoomRepository>(
          update: (context, service, previous) =>
              RoomRepository(roomService: service),
        ),
      ],
      child: RoomPageWidget(id: widget.id),
    );
  }
}

class RoomPageWidget extends StatefulWidget {
  final String id;
  const RoomPageWidget({Key? key, required this.id}) : super(key: key);

  @override
  State<RoomPageWidget> createState() => _RoomPageWidgetState();
}

class _RoomPageWidgetState extends State<RoomPageWidget> {
  bool isLoadingMore = false;

  handleEvent(BaseEvent event) {
    if (event is ExpiredTokenEvent) {
      print("ExpiredTokenEvent");
      return;
    }
    if (event is NoDataShowEvent) {
      print("NoDataShowEvent");
      return;
    }
    if (event is UnknownErrorEvent) {
      print("UnknownErrorEvent ${event.message}");
      return;
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<RoomBloc>.value(
        value: RoomBloc(repository: Provider.of(context)),
        child: Consumer<RoomBloc>(builder: (context, bloc, child) {
          return BlocListener<RoomBloc>(
            listener: handleEvent,
            child: LoadingTask(
              bloc: bloc,
              child: StreamProvider<Object?>.value(
                initialData: null,
                value: bloc.loadRoomDetail(widget.id),
                catchError: (context, err) {
                  print('Error List');
                  return Container();
                },
                child: Consumer<Object?>(builder: (context, data, child) {
                  if (data is GetRoomDetail) {
                    RoomDetail room = data.roomDetail;
                    return buildRoomDetail(context, room);
                  } else {
                    return const Center(
                      child: Air18LoadingView(),
                    );
                  }
                }),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildRoomDetail(BuildContext context, RoomDetail roomDetail) {
    return Stack(
      children: [
        HotelFeedBodyBackground(roomDetail: roomDetail),
        Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.white,
              size: 32,
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: HotelFeedBody(roomDetail: roomDetail),
        ),
        Positioned(
          left: 20,
          bottom: MediaQuery.of(context).size.height * .62,
          child: GestureDetector(
            onTap: () async {
              initializeLocationAndSave([roomDetail]);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MapScreen(room: roomDetail)));
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.withOpacity(0.6),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Color(0xfffd8c00), shape: BoxShape.circle),
                    child: Transform.rotate(
                      angle: 25 * 3.1416 / 180,
                      child: const Icon(
                        Icons.navigation,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Mở bản đồ",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void initializeLocationAndSave(List<RoomDetail> rooms) async {
    // Ensure all permissions are collected for Locations
    Location _location = Location();
    bool? _serviceEnabled;
    PermissionStatus? _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }

    // _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }

    // // Get capture the current user location
    LocationData _locationData = await _location.getLocation();
    LatLng currentLatLng =
        LatLng(_locationData.latitude!, _locationData.longitude!);

    // // Store the user location in sharedPreferences
    sharedPreferences.setDouble('latitude', _locationData.latitude!);
    sharedPreferences.setDouble('longitude', _locationData.longitude!);

    // // Get and store the directions API response in sharedPreferences
    for (int i = 0; i < rooms.length; i++) {
      Map modifiedResponse =
          await getDirectionsAPIResponse(currentLatLng, i, rooms[i]);
      saveDirectionsAPIResponse(i, json.encode(modifiedResponse));
    }
  }
}

class HotelFeedBodyBackground extends StatelessWidget {
  const HotelFeedBodyBackground({
    Key? key,
    required this.roomDetail,
  }) : super(key: key);

  final RoomDetail roomDetail;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: MediaQuery.of(context).size.height * .60,
      child: Hero(
        tag: Key("https://airj18.skqist225.xyz" + roomDetail.images![0]),
        child: Container(
          height: MediaQuery.of(context).size.height * .25,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://airj18.skqist225.xyz" + roomDetail.images![0]),
                fit: BoxFit.cover),
          ),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .25,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0, .8),
                end: Alignment.center,
                colors: [
                  Color(0xEE000000),
                  Color(0x33000000),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HotelFeedBody extends StatelessWidget {
  const HotelFeedBody({Key? key, required this.roomDetail}) : super(key: key);
  final RoomDetail roomDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 20, top: 220),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 8),
          Expanded(
            child: Material(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              elevation: 8,
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: TabBarView(
                          children: [
                            HotelInformationTab(roomDetail: roomDetail),
                            HotelRoomTab(images: roomDetail.images),
                            HotelReviewTab(reviews: roomDetail.reviews),
                          ],
                        ),
                      ),
                    ),
                    const TabBar(
                      indicator: UnderlineTabIndicator(
                        borderSide:
                            BorderSide(color: Color(0xDD613896), width: 4),
                        insets: EdgeInsets.fromLTRB(20, 0, 20, 40),
                      ),
                      tabs: [
                        Tab(
                          child: Text(
                            'INFO',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'ROOMS',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'REVIEW',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, bottom: 0, top: 20.0),
            child: InkWell(
              onTap: () async {
                // Navigator.of(context).push(PageRouteBuilder(
                //     pageBuilder: (_, __, ___) => BookingRoom(
                //           roomDetail: roomDetail,
                //         )));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BookingRoomPage(roomDetail: roomDetail)));
              },
              child: Container(
                height: 55.0,
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF09314F),
                          Color(0xFF09314F),
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp)),
                child: const Center(
                  child: Text(
                    "Book Now",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19.0,
                        fontFamily: "Sofia",
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
