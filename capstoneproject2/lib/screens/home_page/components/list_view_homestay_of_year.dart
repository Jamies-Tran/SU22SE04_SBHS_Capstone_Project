import 'package:flutter/material.dart';

class HomestayOfTheYearListView extends StatelessWidget {
  const HomestayOfTheYearListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,

      children: [
        GestureDetector(
          onTap: () {

          },
          child: Column(
            children: [
              Container(
                height: 100,
                width: 200,
                padding: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
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

        const SizedBox(width: 10),

        GestureDetector(
          onTap: () {

          },
          child: Column(
            children: [
              Container(
                height: 100,
                width: 200,
                padding: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
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

        const SizedBox(width: 10),

        GestureDetector(
          onTap: () {

          },
          child: Column(
            children: [
              Container(
                height: 100,
                width: 200,
                padding: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
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

        const SizedBox(width: 10),

        GestureDetector(
          onTap: () {

          },
          child: Column(
            children: [
              Container(
                height: 100,
                width: 200,
                padding: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
                ),
              ),
              const Center(
                child: Text("Bao Loc", style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'OpenSans',
                    letterSpacing: 1.5,
                    color: Colors.black87
                )),
              )
            ],
          ),
        ),

        const SizedBox(width: 10),

        GestureDetector(
          onTap: () {

          },
          child: Column(
            children: [
              Container(
                height: 100,
                width: 200,
                padding: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
                ),
              ),
              const Center(
                child: Text("Bao Lam", style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'OpenSans',
                    letterSpacing: 1.5,
                    color: Colors.black87
                )),
              )
            ],
          ),
        ),

        const SizedBox(width: 10),

        GestureDetector(
          onTap: () {

          },
          child: Column(
            children: [
              Container(
                height: 100,
                width: 200,
                padding: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/sg_example_1.jpg"), fit: BoxFit.fitWidth),
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
