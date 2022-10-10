import 'package:capstoneproject2/screens/home_page/components/list_view_new_posting_homestay.dart';
import 'package:capstoneproject2/screens/home_page/components/list_view_popular_places.dart';
import 'package:capstoneproject2/services/geometry_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';


class HomestayBodyComponent extends StatefulWidget {
  const HomestayBodyComponent({
    Key? key,
    this.pos
  }) : super(key: key);
  final Position? pos;

  @override
  State<HomestayBodyComponent> createState() => _HomestayBodyComponentState();
}

class _HomestayBodyComponentState extends State<HomestayBodyComponent> {

  IGeometryService geometryService = locator.get<IGeometryService>();


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
    String currentLocation = "${widget.pos!.latitude},${widget.pos!.longitude}";
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      child: SizedBox(
        height: 1500,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PopularPlacesListView(pos: widget.pos, cityString: "Hồ Chí Minh"),));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              padding: const EdgeInsets.only(bottom: 10),
                              margin: const EdgeInsets.only(bottom: 10, top: 10, left: 5),
                              decoration: const BoxDecoration(
                                image: DecorationImage(image:  AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fill),
                              ),
                            ),
                            Text("TP Hồ Chí Minh")
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PopularPlacesListView(pos: widget.pos, cityString: "Hà Nội"),));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              padding: const EdgeInsets.only(bottom: 10),
                              margin: const EdgeInsets.only(bottom: 10, top: 10, left: 10),
                              decoration: const BoxDecoration(
                                image: DecorationImage(image:  AssetImage("assets/images/ha-noi.jpg"), fit: BoxFit.fill),
                              ),
                            ),
                            Text("Hà Nội")
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PopularPlacesListView(pos: widget.pos, cityString: "Đà Lạt"),));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              padding: const EdgeInsets.only(bottom: 10),
                              margin: const EdgeInsets.only(bottom: 10, top: 10, left: 10),
                              decoration: const BoxDecoration(
                                image: DecorationImage(image:  AssetImage("assets/images/dalat.jpg"), fit: BoxFit.fill),
                              ),
                            ),
                            Text("Đà Lạt")
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PopularPlacesListView(pos: widget.pos, cityString: "Vũng Tàu"),));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              padding: const EdgeInsets.only(bottom: 10),
                              margin: const EdgeInsets.only(bottom: 10, top: 10, left: 10),
                              decoration: const BoxDecoration(
                                image: DecorationImage(image:  AssetImage("assets/images/vungtau.jpg"), fit: BoxFit.fill),
                              ),
                            ),
                            Text("Vũng Tàu")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                  width: 300,
                  child: Divider(color: Colors.black87, thickness: 0.5,),
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
                HomestayFilterListView(isScrollDirectionVertical: false, userCurrentLocation: currentLocation, filterByNearestPlace: true,)
              ],
            ),

            const SizedBox(height: 10,),

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
                        "Trending",
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
            HomestayFilterListView(isScrollDirectionVertical: false, filterByTrending: true, userCurrentLocation: currentLocation),

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
            HomestayFilterListView(isScrollDirectionVertical: false, filterByNewestPublishedDate: true, userCurrentLocation: currentLocation),


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
