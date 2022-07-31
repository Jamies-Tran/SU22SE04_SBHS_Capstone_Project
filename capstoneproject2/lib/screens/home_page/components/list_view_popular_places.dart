import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/screens/home_page/views/homestay_city_screen.dart';
import 'package:flutter/material.dart';

class PopularPlacesListView extends StatelessWidget {
  const PopularPlacesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10),
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomestayFromCityScreen(location: cityName["hcm"]),));
          },
          child: Column(
            children: [
              Container(
                height: 75,
                width: 150,
                padding: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
                  shape: BoxShape.circle
                ),
              ),
              const Center(
                child: Text("Ho Chi Minh", style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'OpenSans',
                    letterSpacing: 1.5,
                    color: Colors.black87
                )),
              )
            ],
          ),
        ),



        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomestayFromCityScreen(location: cityName["hn"]),));
          },
          child: Column(
            children: [
              Container(
                height: 75,
                width: 150,
                padding: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
                    shape: BoxShape.circle
                ),
              ),
              const Center(
                child: Text("Ha Noi", style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'OpenSans',
                    letterSpacing: 1.5,
                    color: Colors.black87
                )),
              )
            ],
          ),
        ),



        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomestayFromCityScreen(location: cityName["dl"]),));
          },
          child: Column(
            children: [
              Container(
                height: 75,
                width: 150,
                padding: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
                    shape: BoxShape.circle
                ),
              ),
              const Center(
                child: Text("Da Lat", style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'OpenSans',
                    letterSpacing: 1.5,
                    color: Colors.black87
                )),
              )
            ],
          ),
        ),



        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomestayFromCityScreen(location: cityName["qn"]),));
          },
          child: Column(
            children: [
              Container(
                height: 75,
                width: 150,
                padding: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
                    shape: BoxShape.circle
                ),
              ),
              const Center(
                child: Text("Quang Nam", style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'OpenSans',
                    letterSpacing: 1.5,
                    color: Colors.black87
                )),
              )
            ],
          ),
        ),

        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomestayFromCityScreen(location: cityName["dn"]),));
          },
          child: Column(
            children: [
              Container(
                height: 75,
                width: 150,
                padding: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
                    shape: BoxShape.circle
                ),
              ),
              const Center(
                child: Text("Da Nang", style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'OpenSans',
                    letterSpacing: 1.5,
                    color: Colors.black87
                )),
              )
            ],
          ),
        ),



        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomestayFromCityScreen(location: cityName["vt"]),));
          },
          child: Column(
            children: [
              Container(
                height: 75,
                width: 150,
                padding: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
                    shape: BoxShape.circle
                ),
              ),
              const Center(
                child: Text("Vung Tau", style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'OpenSans',
                    letterSpacing: 1.5,
                    color: Colors.black87
                )),
              )
            ],
          ),
        ),
      ],
    );
  }
}
