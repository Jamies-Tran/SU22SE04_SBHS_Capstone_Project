import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/screens/home_page/components/list_view_new_posting_homestay.dart';
import 'package:capstoneproject2/screens/home_page/views/homestay_city_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class PopularPlacesListView extends StatefulWidget {
  const PopularPlacesListView({
    Key? key,
    this.cityString,
    this.pos
  }) : super(key: key);
  final String? cityString;
  final Position? pos;

  @override
  State<PopularPlacesListView> createState() => _PopularPlacesListViewState();
}

class _PopularPlacesListViewState extends State<PopularPlacesListView> {
  bool? filterByTrending;
  bool? filterByNearest = true;
  bool? filterByNewPublish;
  bool? filterByHighestRating;


  @override
  Widget build(BuildContext context) {
    String currentLocation = "${widget.pos!.latitude},${widget.pos!.longitude}";

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cityString!),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 190,
                      child: ListTile(
                        leading: const Icon(Icons.new_releases, size: 20,),
                        title: const Text(
                          "New publish",
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            filterByTrending = false;
                            filterByNearest = false;
                            filterByHighestRating = false;
                            filterByNewPublish = true;
                            //filterByPrices = false;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 190,
                      child: ListTile(
                        leading: const Icon(Icons.star_rate, size: 20,),
                        title: const Text(
                          "Highest rating",
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            filterByTrending = false;
                            filterByNearest = false;
                            filterByHighestRating = true;
                            filterByNewPublish = false;
                            //filterByPrices = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 190,
                      child: ListTile(
                        leading: const Icon(Icons.new_releases, size: 20,),
                        title: const Text(
                          "Trending",
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            filterByTrending = true;
                            filterByNearest = false;
                            filterByHighestRating = false;
                            filterByNewPublish = false;
                            //filterByPrices = false;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 190,
                      child: ListTile(
                        leading: const Icon(Icons.star_rate, size: 20,),
                        title: const Text(
                          "Near you",
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            filterByTrending = false;
                            filterByNearest = true;
                            filterByHighestRating = false;
                            filterByNewPublish = false;
                            //filterByPrices = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),

            HomestayFilterListView(
              filterByStr: widget.cityString,
              userCurrentLocation: currentLocation,
              isScrollDirectionVertical: true,
              filterByNearestCurrentLocation: filterByNearest,
              filterByTrending: filterByTrending,
              filterByNewestPublishedDate: filterByNewPublish,
              filterByHighestAveragePoint: filterByHighestRating,
            )
          ],
        ),
      ),
    );
  }
}


// class PopularPlacesListView extends StatelessWidget {
//   const PopularPlacesListView({
//     Key? key
//
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       scrollDirection: Axis.horizontal,
//       shrinkWrap: true,
//       padding: const EdgeInsets.only(top: 10),
//       children: [
//         GestureDetector(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) => HomestayFromCityScreen(location: cityName["hcm"]),));
//           },
//           child: Column(
//             children: [
//               Container(
//                 height: 75,
//                 width: 150,
//                 padding: const EdgeInsets.only(right: 10),
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
//                   shape: BoxShape.circle
//                 ),
//               ),
//               const Center(
//                 child: Text("Ho Chi Minh", style: TextStyle(
//                     fontSize: 17,
//                     fontFamily: 'OpenSans',
//                     letterSpacing: 1.5,
//                     color: Colors.black87
//                 )),
//               )
//             ],
//           ),
//         ),
//
//
//
//         GestureDetector(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) => HomestayFromCityScreen(location: cityName["hn"]),));
//           },
//           child: Column(
//             children: [
//               Container(
//                 height: 75,
//                 width: 150,
//                 padding: const EdgeInsets.only(right: 10),
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
//                     shape: BoxShape.circle
//                 ),
//               ),
//               const Center(
//                 child: Text("Ha Noi", style: TextStyle(
//                     fontSize: 17,
//                     fontFamily: 'OpenSans',
//                     letterSpacing: 1.5,
//                     color: Colors.black87
//                 )),
//               )
//             ],
//           ),
//         ),
//
//
//
//         GestureDetector(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) => HomestayFromCityScreen(location: cityName["dl"]),));
//           },
//           child: Column(
//             children: [
//               Container(
//                 height: 75,
//                 width: 150,
//                 padding: const EdgeInsets.only(right: 10),
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
//                     shape: BoxShape.circle
//                 ),
//               ),
//               const Center(
//                 child: Text("Da Lat", style: TextStyle(
//                     fontSize: 17,
//                     fontFamily: 'OpenSans',
//                     letterSpacing: 1.5,
//                     color: Colors.black87
//                 )),
//               )
//             ],
//           ),
//         ),
//
//
//
//         GestureDetector(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) => HomestayFromCityScreen(location: cityName["qn"]),));
//           },
//           child: Column(
//             children: [
//               Container(
//                 height: 75,
//                 width: 150,
//                 padding: const EdgeInsets.only(right: 10),
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
//                     shape: BoxShape.circle
//                 ),
//               ),
//               const Center(
//                 child: Text("Quang Nam", style: TextStyle(
//                     fontSize: 17,
//                     fontFamily: 'OpenSans',
//                     letterSpacing: 1.5,
//                     color: Colors.black87
//                 )),
//               )
//             ],
//           ),
//         ),
//
//         GestureDetector(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) => HomestayFromCityScreen(location: cityName["dn"]),));
//           },
//           child: Column(
//             children: [
//               Container(
//                 height: 75,
//                 width: 150,
//                 padding: const EdgeInsets.only(right: 10),
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
//                     shape: BoxShape.circle
//                 ),
//               ),
//               const Center(
//                 child: Text("Da Nang", style: TextStyle(
//                     fontSize: 17,
//                     fontFamily: 'OpenSans',
//                     letterSpacing: 1.5,
//                     color: Colors.black87
//                 )),
//               )
//             ],
//           ),
//         ),
//
//
//
//         GestureDetector(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) => HomestayFromCityScreen(location: cityName["vt"]),));
//           },
//           child: Column(
//             children: [
//               Container(
//                 height: 75,
//                 width: 150,
//                 padding: const EdgeInsets.only(right: 10),
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
//                     shape: BoxShape.circle
//                 ),
//               ),
//               const Center(
//                 child: Text("Vung Tau", style: TextStyle(
//                     fontSize: 17,
//                     fontFamily: 'OpenSans',
//                     letterSpacing: 1.5,
//                     color: Colors.black87
//                 )),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
