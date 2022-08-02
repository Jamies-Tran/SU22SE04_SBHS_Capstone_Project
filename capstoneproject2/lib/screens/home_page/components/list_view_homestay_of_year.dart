import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/components/dialog_component.dart';
import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/screens/home_page/components/rating_component.dart';
import 'package:capstoneproject2/screens/home_page/home_page_screen.dart';
import 'package:capstoneproject2/screens/home_page/views/view_homestay_screen.dart';
import 'package:capstoneproject2/screens/homestay_detail/view_homestay_detail.dart';
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
    return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 20)).asyncMap((event) => homestayService.getAvailableHomestay()),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitComponent();
          } else if(snapshot.hasData) {
            var snapshotData = snapshot.data;
            if(snapshotData is List<HomestayModel> && snapshotData.isNotEmpty) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: snapshotData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomestayDetailsScreen(homestayName: snapshotData[index].name)));
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
            } else {
              return const Padding(
                  padding: EdgeInsets.all(20),
                  child:Text("There is nothing here", style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'OpenSans',
                      letterSpacing: 3.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold
                  )) ,
              );
            }
          } else if(snapshot.hasError) {
            return DialogComponent(message: "Connection time out", eventHandler: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePageScreen(),)),);
          }

          return const HomePageScreen();
        },
    );
  }
}
