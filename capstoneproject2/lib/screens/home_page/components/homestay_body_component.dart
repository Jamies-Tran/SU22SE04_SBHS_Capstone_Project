import 'package:capstoneproject2/screens/home_page/components/list_view_homestay_of_year.dart';
import 'package:flutter/material.dart';

import 'list_view_popular_places.dart';

class HomestayBodyComponent extends StatefulWidget {
  const HomestayBodyComponent({Key? key}) : super(key: key);

  @override
  State<HomestayBodyComponent> createState() => _HomestayBodyComponentState();
}

class _HomestayBodyComponentState extends State<HomestayBodyComponent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        height: 400,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Expanded(
                child: SizedBox(
                  height: 50,
                  child: PopularPlacesListView(),
                )
            ),

            Padding(
                padding: const EdgeInsets.all(15),
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
                        "Homestay of the year",
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

            const Expanded(
                child: SizedBox(
                  height: 200,
                  child: HomestayOfTheYearListView(),
                )
            )
          ],
        ),
      ),
    );
  }
}
