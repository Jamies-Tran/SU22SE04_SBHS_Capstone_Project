import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/navigator/component/spinkit_component.dart';
import 'package:capstoneproject2/screens/home_page/components/rating_component.dart';
import 'package:capstoneproject2/screens/home_page/home_page_screen.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_cloud_storage_service.dart';
import 'package:capstoneproject2/services/homestay_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/homestay_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:intl/intl.dart';

class HomestayOfTheYearListView extends StatelessWidget {
  const HomestayOfTheYearListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseStorage = locator.get<IFirebaseCloudStorage>();
    final homestayService = locator.get<IHomestayService>();
    final currencyFormat = NumberFormat("#,##0");
    return FutureBuilder(
        future: homestayService.getAvailableHomestay(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitComponent();
          } else if(snapshot.hasData) {
            var snapshotData = snapshot.data;
            if(snapshotData is List<HomestayModel>) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: snapshotData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                          onTap: () {
                            print(snapshotData[index].name);
                            print(snapshotData[index].averagePoint);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FutureBuilder(
                                  future: firebaseStorage.getImageDownloadUrl(
                                    snapshotData[index].homestayImages[0].url
                                  ),
                                  builder: (context, coverSnapshot) {
                                    if(coverSnapshot.connectionState == ConnectionState.waiting) {
                                      return SpinKitComponent();
                                    } else if(coverSnapshot.hasData) {
                                      String url = coverSnapshot.data as String;
                                      return Container(
                                        height: 150,
                                        width: 250,
                                        padding: const EdgeInsets.only(right: 10),
                                        margin: const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.fitWidth),
                                        ),
                                      );
                                    }

                                    return Container(
                                      height: 150,
                                      width: 250,
                                      padding: const EdgeInsets.only(right: 10),
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(image: AssetImage("assets/images/passenger-default.png"), fit: BoxFit.fitWidth),
                                      ),
                                    );
                                  },
                              ),
                              Text("${snapshotData[index].name}", style: const TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.5,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold
                              )),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                      width: 90,
                                      padding: const EdgeInsets.only(left: 10, right: 10),
                                      decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      child: Text("${snapshotData[index].averagePoint} / 5.0", style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'OpenSans',
                                          letterSpacing: 1.5,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold
                                      ))
                                  ),
                                  RatingComponent(point: snapshotData[index].averagePoint,)
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.attach_money, color: Colors.green),
                                  Text("${currencyFormat.format(snapshotData[index].price)}/day", style: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'OpenSans',
                                      letterSpacing: 3.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold
                                  )),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.people, color: kPrimaryColor),
                                  Text("${snapshotData[index].numberOfFinishedBooking}", style: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'OpenSans',
                                      letterSpacing: 3.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold
                                  )),
                                  const SizedBox(width: 50),
                                  const Icon(Icons.location_city, color: kPrimaryLightColor),
                                  Text("${snapshotData[index].city}", style: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'OpenSans',
                                      letterSpacing: 3.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold
                                  ))
                                ],
                              ),

                            ],
                          ),
                        );
                  },
              );
            }
          }

          return HomePageScreen();
        },
    );
    // return ListView(
    //   scrollDirection: Axis.horizontal,
    //   shrinkWrap: true,
    //
    //   children: [
    //     GestureDetector(
    //       onTap: () {
    //
    //       },
    //       child: Column(
    //         children: [
    //
    //           FutureBuilder(
    //               future: firebaseStorage.getImageDownloadUrl("5.png"),
    //               builder: (context, snapshot) {
    //                 if(snapshot.connectionState == ConnectionState.waiting) {
    //                   return SpinKitComponent();
    //                 } else if(snapshot.hasData) {
    //                   String data = snapshot.data as String;
    //                   return Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Container(
    //                         height: 100,
    //                         width: 200,
    //                         padding: const EdgeInsets.only(right: 10),
    //                         decoration: BoxDecoration(
    //                           image: DecorationImage(image: NetworkImage(data), fit: BoxFit.fitWidth),
    //                         ),
    //
    //                       ),
    //                       Container(
    //                         child: Column(
    //                           children: const [
    //                             Text("Homestay 1", style: TextStyle(
    //                                 fontSize: 13,
    //                                 fontFamily: 'OpenSans',
    //                                 letterSpacing: 1.5,
    //                                 color: Colors.black87,
    //                                 fontWeight: FontWeight.bold
    //                             )),
    //
    //                           ],
    //                         ),
    //                       )
    //                     ],
    //                   );
    //                 }
    //
    //                 return Container(
    //                   height: 100,
    //                   width: 200,
    //                   padding: const EdgeInsets.only(right: 10),
    //                   decoration: const BoxDecoration(
    //                     image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
    //                   ),
    //                 );
    //               },
    //           ),
    //
    //
    //         ],
    //       ),
    //     ),
    //
    //     const SizedBox(width: 10),
    //
    //     GestureDetector(
    //       onTap: () {
    //
    //       },
    //       child: Column(
    //         children: [
    //           Container(
    //             height: 100,
    //             width: 200,
    //             padding: const EdgeInsets.only(right: 10),
    //             decoration: const BoxDecoration(
    //               image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
    //             ),
    //           ),
    //           const Center(
    //             child: Text("Ha Noi", style: TextStyle(
    //                 fontSize: 17,
    //                 fontFamily: 'OpenSans',
    //                 letterSpacing: 1.5,
    //                 color: Colors.black87
    //             )),
    //           )
    //         ],
    //       ),
    //     ),
    //
    //     const SizedBox(width: 10),
    //
    //     GestureDetector(
    //       onTap: () {
    //
    //       },
    //       child: Column(
    //         children: [
    //           Container(
    //             height: 100,
    //             width: 200,
    //             padding: const EdgeInsets.only(right: 10),
    //             decoration: const BoxDecoration(
    //               image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
    //             ),
    //           ),
    //           const Center(
    //             child: Text("Da Lat", style: TextStyle(
    //                 fontSize: 17,
    //                 fontFamily: 'OpenSans',
    //                 letterSpacing: 1.5,
    //                 color: Colors.black87
    //             )),
    //           )
    //         ],
    //       ),
    //     ),
    //
    //     const SizedBox(width: 10),
    //
    //     GestureDetector(
    //       onTap: () {
    //
    //       },
    //       child: Column(
    //         children: [
    //           Container(
    //             height: 100,
    //             width: 200,
    //             padding: const EdgeInsets.only(right: 10),
    //             decoration: const BoxDecoration(
    //               image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
    //             ),
    //           ),
    //           const Center(
    //             child: Text("Bao Loc", style: TextStyle(
    //                 fontSize: 17,
    //                 fontFamily: 'OpenSans',
    //                 letterSpacing: 1.5,
    //                 color: Colors.black87
    //             )),
    //           )
    //         ],
    //       ),
    //     ),
    //
    //     const SizedBox(width: 10),
    //
    //     GestureDetector(
    //       onTap: () {
    //
    //       },
    //       child: Column(
    //         children: [
    //           Container(
    //             height: 100,
    //             width: 200,
    //             padding: const EdgeInsets.only(right: 10),
    //             decoration: const BoxDecoration(
    //               image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
    //             ),
    //           ),
    //           const Center(
    //             child: Text("Bao Lam", style: TextStyle(
    //                 fontSize: 17,
    //                 fontFamily: 'OpenSans',
    //                 letterSpacing: 1.5,
    //                 color: Colors.black87
    //             )),
    //           )
    //         ],
    //       ),
    //     ),
    //
    //     const SizedBox(width: 10),
    //
    //     GestureDetector(
    //       onTap: () {
    //
    //       },
    //       child: Column(
    //         children: [
    //           Container(
    //             height: 100,
    //             width: 200,
    //             padding: const EdgeInsets.only(right: 10),
    //             decoration: const BoxDecoration(
    //               image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
    //             ),
    //           ),
    //           const Center(
    //             child: Text("Vung Tau", style: TextStyle(
    //                 fontSize: 17,
    //                 fontFamily: 'OpenSans',
    //                 letterSpacing: 1.5,
    //                 color: Colors.black87
    //             )),
    //           )
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}
