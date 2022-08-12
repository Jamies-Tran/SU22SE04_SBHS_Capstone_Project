import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/screens/home_page/home_page_screen.dart';
import 'package:capstoneproject2/screens/homestay_detail/component/homestay_details_body.dart';
import 'package:capstoneproject2/screens/homestay_detail/component/homestay_details_top.dart';
import 'package:capstoneproject2/services/homestay_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/homestay_model.dart';
import 'package:flutter/material.dart';

class HomestayDetailsScreen extends StatelessWidget {
  const HomestayDetailsScreen({Key? key, required this.homestayName}) : super(key: key);
  final homestayName;

  @override
  Widget build(BuildContext context) {
    final homestayService = locator.get<IHomestayService>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePageScreen(),))),
        title: const Text("Details", style: TextStyle(
            fontSize: 15,
            fontFamily: 'OpenSans',
            letterSpacing: 3.0,
            color: Colors.black87,
            fontWeight: FontWeight.bold
        )),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: FutureBuilder(
          future: homestayService.findHomestayByName(homestayName),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("Just a minute...", style: TextStyle(
              fontSize: 15,
              fontFamily: 'OpenSans',
              letterSpacing: 3.0,
              color: Colors.black87,
                  fontWeight: FontWeight.bold
              )));
            } else if(snapshot.hasData) {
              final snapshotData = snapshot.data;
              if(snapshotData is HomestayModel) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: 2000,
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 340,
                          width: double.infinity,
                          child: HomestayDetailsTop(homestayImages: snapshotData.homestayImages),
                        ),
                        HomestayDetailsBody(homestayModel: snapshotData,)
                      ],
                    ),
                  ),
                );
              }
            }

            return HomePageScreen();
          },
      ),
    );
  }
}
