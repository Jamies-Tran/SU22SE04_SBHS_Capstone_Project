import 'package:capstoneproject2/screens/home_page/components/list_view_new_posting_homestay.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';


class HomestayBodyComponent extends StatefulWidget {
  const HomestayBodyComponent({Key? key}) : super(key: key);

  @override
  State<HomestayBodyComponent> createState() => _HomestayBodyComponentState();
}

class _HomestayBodyComponentState extends State<HomestayBodyComponent> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      child: SizedBox(
        height: 1000,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: getCurrentLocation(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else if(snapshot.hasData) {
                  final snapshotData = snapshot.data;
                  if(snapshotData is Position) {
                    String geo = "${snapshotData.latitude},${snapshotData.longitude}";
                    print(geo);
                    return Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: const [
                                Text(
                                    "--",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'OpenSans',
                                        letterSpacing: 2.0,
                                        color: Colors.black87
                                    )
                                ),
                                SizedBox(width: 10),
                                Text(
                                    "Near you",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'OpenSans',
                                        letterSpacing: 2.0,
                                        color: Colors.black87
                                    )
                                ),
                              ],
                            )
                        ),
                        HomestayFilterListView(isScrollDirectionVertical: false, filterByStr: geo, filterByNearestPlace: true,)
                      ],
                    );
                  }
                }

                return Container();
              },
            ),

            Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: const [
                    Text(
                        "--",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'OpenSans',
                            letterSpacing: 2.0,
                            color: Colors.black87
                        )
                    ),
                    SizedBox(width: 10),
                    Text(
                        "New homestays",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'OpenSans',
                            letterSpacing: 2.0,
                            color: Colors.black87
                        )
                    )

                  ],
                )
            ),
            const HomestayFilterListView(isScrollDirectionVertical: false, filterByNewestPublishedDate: true),
          ],
        ),
      ),
    );
  }
}

Future<Position> getCurrentLocation() async {
  final isServiceEnabled= await Geolocator.isLocationServiceEnabled();
  dynamic permission;
  if(!isServiceEnabled) {
    Future.error("Service not enable");
  }
  permission = await Geolocator.checkPermission();
  if(permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied) {
      Future.error("no permission granted");
    }
  }
  if(permission == LocationPermission.deniedForever) {
    Future.error("no permission granted");
  }
  final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print(pos.latitude);
  return pos;
}
