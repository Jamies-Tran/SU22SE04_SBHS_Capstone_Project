import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/components/dialog_component.dart';
import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/screens/home_page/components/rating_component.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_cloud_storage_service.dart';
import 'package:capstoneproject2/services/homestay_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/homestay_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomestayFromCityScreen extends StatefulWidget {
  const HomestayFromCityScreen({Key? key, this.location}) : super(key: key);
  final location;

  @override
  State<HomestayFromCityScreen> createState() => _HomestayFromCityScreenState();
}

class _HomestayFromCityScreenState extends State<HomestayFromCityScreen> {
  final homestayService = locator.get<IHomestayService>();
  final firebaseStorage = locator.get<IFirebaseCloudStorage>();
  final currencyFormat = NumberFormat("#,##0");
  var showSearchBar = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: showSearchBar ? const SearchBar() : null,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  showSearchBar = !showSearchBar;
                });
              },
              icon: const Icon(Icons.search, color: Colors.white,)
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 10))
              .asyncMap((event) => homestayService.getAvailableHomestayByLocation(widget.location)),
          builder: (context, snapshot) {
            print("${widget.location}");
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const SpinKitComponent();
            }  else if(snapshot.hasData) {
              var snapshotData = snapshot.data;
              if(snapshotData is List<HomestayModel> && snapshotData.isNotEmpty) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshotData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            GestureDetector(
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
                                          width: double.infinity,
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
                                      fontSize:20,
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
                                      RatingComponent(point: snapshotData[index].averagePoint, size: 30.0,)
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.attach_money, color: Colors.green),
                                      Text("${currencyFormat.format(snapshotData[index].homestayPriceLists!.first)} ~ ${currencyFormat.format(snapshotData[index].homestayPriceLists!.last)}/day", style: const TextStyle(
                                          fontSize: 20,
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
                                      Text("${snapshotData[index].totalBookingTime}", style: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'OpenSans',
                                          letterSpacing: 3.0,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold
                                      )),
                                      const SizedBox(width: 50),
                                      const Icon(Icons.location_city, color: kPrimaryLightColor),
                                      Text("${snapshotData[index].city}", style: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'OpenSans',
                                          letterSpacing: 3.0,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold
                                      ))
                                    ],
                                  ),

                                ],
                              ),
                            )
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
              return const DialogComponent(message: "Connection time out");
            }

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
          },
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: kPrimaryColor, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: TextField(
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  /* Clear the search field */
                },
              ),
              hintText: 'Search...',
             enabledBorder: const OutlineInputBorder(
               borderRadius: BorderRadius.all(Radius.circular(20))
             ),
            border: InputBorder.none
          ),
        ),
      ),
    );
  }
}
