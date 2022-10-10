

import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/screens/home_page/components/homestay_body_component.dart';
import 'package:capstoneproject2/screens/home_page/components/homestay_top_component.dart';
import 'package:capstoneproject2/services/geometry_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ViewHomestayScreen extends StatefulWidget {
  const ViewHomestayScreen({Key? key}) : super(key: key);

  @override
  State<ViewHomestayScreen> createState() => _ViewHomestayScreenState();
}

class _ViewHomestayScreenState extends State<ViewHomestayScreen> {
  final coordinateService = locator.get<IGeometryService>();
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: coordinateService.getCurrentLocation(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitComponent();
        } else if(snapshot.hasData) {
          final snapshotData = snapshot.data;
          if(snapshotData is Position) {
            return Column(
              children: [
                HomestayTopComponent(pos: snapshotData,),
                HomestayBodyComponent(pos: snapshotData,)
              ],
            );
          }
        } else if(snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"),);
        }

        return Container();
      },
    );
  }
}
