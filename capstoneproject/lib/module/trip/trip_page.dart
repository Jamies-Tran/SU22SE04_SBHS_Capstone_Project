import 'package:flutter/material.dart';

class TripPage extends StatefulWidget {
  const TripPage({Key? key}) : super(key: key);

  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/image/destinationPopuler/tripBackground.png",
            height: _height,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Where to?',
                    style: TextStyle(
                        fontFamily: "Sofia",
                        fontWeight: FontWeight.w700,
                        fontSize: 28.0),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Start planning your first adventure',
                    style: TextStyle(
                        fontFamily: "Sofia",
                        fontWeight: FontWeight.w300,
                        fontSize: 18.0,
                        color: Colors.black45),
                  ),
                  const SizedBox(
                    height: 11.0,
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(PageRouteBuilder(
                      //     pageBuilder: (_, __, ___) => exploreTrip(
                      //           userId: widget.userID,
                      //         )));
                    },
                    child: Container(
                      height: 45.0,
                      width: 140.0,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(
                              color: const Color(0xFF8DA2BF), width: 1.0)),
                      child: const Center(
                        child: Text(
                          'Explore Trips',
                          style: TextStyle(
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color: Color(0xFF8DA2BF)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
