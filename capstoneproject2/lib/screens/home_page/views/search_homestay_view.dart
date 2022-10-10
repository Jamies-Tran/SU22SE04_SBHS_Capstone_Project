import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/screens/home_page/components/list_view_new_posting_homestay.dart';
import 'package:capstoneproject2/services/geometry_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:search_map_location/utils/google_search/place.dart';
import 'package:search_map_location/widget/search_widget.dart';

class FilterSearchingHomestay extends StatefulWidget {
  const FilterSearchingHomestay({
    Key? key,
    this.pos
  }) : super(key: key);
  final Position? pos;

  @override
  State<FilterSearchingHomestay> createState() => _FilterSearchingHomestayState();
}

class _FilterSearchingHomestayState extends State<FilterSearchingHomestay> {
  String? filterByStr;
  String? highestPrice = "0";
  String? lowestPrice = "0";
  bool? filterByHighestAveragePoint;
  bool? filterByNewestPublishedDate;
  bool? filterByNearestPlace;
  bool? filterByTrending;
  bool? filterByPrices = false;
  String filterTitle = "choose filter";
  TextEditingController txtSearch = TextEditingController();

  @override
  void dispose() {
    txtSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    String? currentLocation = "${widget.pos!.latitude},${widget.pos!.longitude}";
    String? searchText = "";
    bool onSearchLocation = false;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.only(bottom: 5, top: 5),
          height: 60,
          child: Column(
            children: [
              Row(
                children: [
                   Flexible(
                    flex: 1,
                    child: TextField(
                      cursorColor: Colors.black,
                      controller: txtSearch,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none
                          ),
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 18
                          )
                      ),
                      onChanged: (value) {
                        if(filterByNearestPlace == false) {
                          setState(() {
                            filterByStr = value;
                          });
                        }
                      },
                      onSubmitted: (value) {
                        setState(() {
                          filterByStr = value;
                        });
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),

      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),

        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 105,
                  width: 500,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Row(
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
                                    filterByNearestPlace = false;
                                    filterByHighestAveragePoint = false;
                                    filterByNewestPublishedDate = true;
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
                                    filterByNearestPlace = false;
                                    filterByHighestAveragePoint = true;
                                    filterByNewestPublishedDate = false;
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
                                leading: const Icon(Icons.trending_up, size: 20,),
                                title: const Text(
                                  "Top trending",
                                  style: TextStyle(
                                      fontSize: 15
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    filterByTrending = true;
                                    filterByNearestPlace = false;
                                    filterByHighestAveragePoint = false;
                                    filterByNewestPublishedDate = false;
                                    //filterByPrices = false;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 190,
                              child: ListTile(
                                leading: const Icon(Icons.near_me, size: 20,),
                                title: const Text(
                                  "Location",
                                  style: TextStyle(
                                      fontSize: 15
                                  ),
                                ),
                                onTap: () {
                                  txtSearch.clear();
                                  setState(()  {
                                    filterByTrending = false;
                                    filterByHighestAveragePoint = false;
                                    filterByNewestPublishedDate = false;
                                    //filterByPrices = false;
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: SizedBox(
                                            height: onSearchLocation ? 500 : 100,
                                            child: SearchLocation(
                                              apiKey: googleApiKey,
                                              country: "VN",
                                              language: "vi",
                                              hasClearButton: true,
                                              icon: Icons.location_on,
                                              clearIcon: Icons.highlight_remove,
                                              onSearch: (place) {
                                                setState(() {
                                                  print("hello");
                                                  onSearchLocation = true;
                                                });
                                              },
                                              onSelected: (place) {
                                                setState(() {
                                                  filterByNearestPlace = true;
                                                  filterByStr = place.description;
                                                  txtSearch.text = filterByStr!;
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          )
                                        );
                                      },
                                  );
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
                              leading: const Icon(Icons.monetization_on, size: 20,),
                              title: const Text(
                                "Prices",
                                style: TextStyle(
                                    fontSize: 15
                                ),
                              ),
                              onTap: () {
                                txtSearch.clear();
                                highestPrice = "0";
                                lowestPrice = "0";
                                filterByStr = null;
                                setState(() {
                                  filterByTrending = false;
                                  filterByNearestPlace = false;
                                  filterByHighestAveragePoint = false;
                                  filterByNewestPublishedDate = false;
                                  filterByPrices = !filterByPrices!;
                                });
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Container(
                                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                                          height: 120,
                                          child: Column(
                                            children: [
                                              TextField(
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(borderSide: BorderSide(width: 2.0, style: BorderStyle.solid), borderRadius: BorderRadius.zero),
                                                  hintText: "Lowest price"
                                                ),
                                                onChanged: (value) {
                                                  lowestPrice = value;
                                                },
                                              ),
                                              const SizedBox(height: 10,),
                                              TextField(
                                                decoration: const InputDecoration(
                                                    border: OutlineInputBorder(borderSide: BorderSide(width: 2.0, style: BorderStyle.solid), borderRadius: BorderRadius.zero),
                                                    hintText: "Highest price"
                                                ),
                                                onChanged: (value) {
                                                  highestPrice = value;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          Center(
                                            child: ElevatedButton(
                                                onPressed: () {

                                                  if(lowestPrice != "0" && highestPrice == "0") {
                                                    searchText = lowestPrice;
                                                    setState(() {
                                                      lowestPrice = lowestPrice;
                                                    });
                                                  } else if(lowestPrice == "0" && highestPrice != "0") {
                                                    searchText = highestPrice;
                                                    setState(() {
                                                      highestPrice = highestPrice;
                                                    });
                                                  } else if(lowestPrice != "0" && highestPrice != "0") {
                                                    searchText = "$lowestPrice ~ $highestPrice";
                                                    setState(() {
                                                      lowestPrice = lowestPrice;
                                                      highestPrice = highestPrice;
                                                    });
                                                  }
                                                  txtSearch.text = searchText!;

                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.green,
                                                    maximumSize: const Size(250, 50),
                                                    minimumSize: const Size(250, 50),
                                                    shape: const RoundedRectangleBorder()
                                                ),
                                                child: const Text("Search")
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                );
                              },
                            ),
                          ),
                          ],
                        )

                      ],
                    ),
                  ),
                )
              ],
            ),

            SizedBox(
              height: 650,
              width: double.infinity,
              child: HomestayFilterListView(
                isScrollDirectionVertical: true,
                filterByNearestPlace: filterByNearestPlace,
                filterByTrending: filterByTrending,
                filterByStr: filterByStr,
                userCurrentLocation: currentLocation,
                filterByHighestAveragePoint: filterByHighestAveragePoint,
                filterByNewestPublishedDate: filterByNewestPublishedDate,
                highestPrice: highestPrice != "0" ? int.parse(highestPrice!) : null,
                lowestPrice: lowestPrice != "0" ? int.parse(lowestPrice!) : null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
