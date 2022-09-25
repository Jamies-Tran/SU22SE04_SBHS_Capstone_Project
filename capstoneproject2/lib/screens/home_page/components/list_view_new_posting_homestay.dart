import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/components/dialog_component.dart';
import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/screens/home_page/components/rating_component.dart';
import 'package:capstoneproject2/screens/home_page/home_page_screen.dart';
import 'package:capstoneproject2/screens/homestay_detail/view_homestay_detail.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_cloud_storage_service.dart';
import 'package:capstoneproject2/services/homestay_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/homestay_model.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

class HomestayFilterListView extends StatefulWidget {
  const HomestayFilterListView({
    Key? key,
    this.isScrollDirectionVertical,
    this.filterByStr,
    this.filterByNewestPublishedDate,
    this.filterByHighestAveragePoint,
    this.filterByTrending,
    this.filterByNearestPlace,
    this.highestPrice,
    this.lowestPrice
  }) : super(key: key);
  final bool? isScrollDirectionVertical;
  final String? filterByStr;
  final int? highestPrice;
  final int? lowestPrice;
  final bool? filterByHighestAveragePoint;
  final bool? filterByNewestPublishedDate;
  final bool? filterByNearestPlace;
  final bool? filterByTrending;

  @override
  State<HomestayFilterListView> createState() => _HomestayFilterListViewState();
}

class _HomestayFilterListViewState extends State<HomestayFilterListView> {

  int page = 0;
  int size = 5;


  @override
  Widget build(BuildContext context) {
    final firebaseStorage = locator.get<IFirebaseCloudStorage>();
    //final fireAuth = FirebaseAuth.instance;
    final homestayService = locator.get<IHomestayService>();
    //final currencyFormat = NumberFormat("#,##0");
    HomestayFilterRequestModel homestayFilterRequestModel = HomestayFilterRequestModel(
        filterByStr: widget.filterByStr,
        filterByHighestAveragePoint: widget.filterByHighestAveragePoint,
        filterByNewestPublishedDate: widget.filterByNewestPublishedDate,
        filterByTrending: widget.filterByTrending,
        filterByNearestPlace: widget.filterByNearestPlace,
        highestPrice: widget.highestPrice,
        lowestPrice: widget.lowestPrice
    );
    return FutureBuilder(
      future: homestayService.searchHomestayByFilter(homestayFilterRequestModel, page, size),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if(snapshot.hasData) {
          var snapshotData = snapshot.data;
          if(snapshotData is HomestayFilterResponseModel && snapshotData.homestayResultList!.isNotEmpty) {

            return Column(

              children: [
                RefreshIndicator(
                  onRefresh: () => Future.delayed(const Duration(seconds: 0)).then((value) {
                    setState(() {
                      setState(() {
                        page = page == snapshotData.totalPages ? page : page + 1;
                      });
                    });
                  }),
                  child: SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: widget.isScrollDirectionVertical! ? Axis.vertical : Axis.horizontal,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: snapshotData.homestayResultList!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomestayDetailsScreen(homestayName: snapshotData.homestayResultList![index].name)));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FutureBuilder(
                                future: firebaseStorage.getImageDownloadUrl(
                                    snapshotData.homestayResultList![index].homestayImages[0].url
                                ),
                                builder: (context, coverSnapshot) {
                                  if(coverSnapshot.connectionState == ConnectionState.waiting) {
                                    return const SpinKitComponent();
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
                              Text("${snapshotData.homestayResultList![index].name}", style: const TextStyle(
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
                                      child: Text("${snapshotData.homestayResultList![index].averagePoint.toStringAsFixed(1)} / 5.0", style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'OpenSans',
                                          letterSpacing: 1.5,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold
                                      ))
                                  ),
                                  RatingComponent(point: double.parse(snapshotData.homestayResultList![index].averagePoint.toStringAsFixed(1)),)
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.attach_money, color: Colors.green),
                                  Text("~ ${snapshotData.homestayResultList![index].averagePrice}/day", style: const TextStyle(
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
                                  Text("${snapshotData.homestayResultList![index].totalBookingTime}", style: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'OpenSans',
                                      letterSpacing: 3.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold
                                  )),
                                  const SizedBox(width: 50),
                                  const Icon(Icons.location_city, color: kPrimaryLightColor),
                                  Text("${snapshotData.homestayResultList![index].city}", style: const TextStyle(
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
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if(page >= 1) {
                          setState(() {
                            page = page - 1;
                          });
                        }
                      },
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.green,),
                    ),
                    Text(
                        "${page + 1}/${snapshotData.totalPages}"
                    ),
                    IconButton(
                      onPressed: () {
                        if(page < (snapshotData.totalPages!-1)) {
                          setState(() {
                            page = page + 1;
                          });
                        }
                      },
                      icon: const Icon(Icons.arrow_forward_ios, color: Colors.green),
                    ),
                  ],
                )
              ],
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
          return DialogComponent(message: "Can't receive data from server - ${snapshot.error}", eventHandler: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePageScreen(),)),);
        }

        return const HomePageScreen();
      },
    );
  }
}