import 'package:capstoneproject2/navigator/rating_homestay_navigator.dart';
import 'package:capstoneproject2/screens/home_page/home_page_screen.dart';
import 'package:capstoneproject2/services/model/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingHomestayScreen extends StatefulWidget {
  const RatingHomestayScreen({
    Key? key,
    this.email,
    this.homestayName,
    this.bookingId
  }) : super(key: key);
  final String? email;
  final String? homestayName;
  final int? bookingId;

  @override
  State<RatingHomestayScreen> createState() => _RatingHomestayScreenState();
}

class _RatingHomestayScreenState extends State<RatingHomestayScreen> {
  double convenientPoint = 0.0;
  double securityPoint = 0.0;
  double positionPoint = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 320,
          height: 600,
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0,3)
                )
              ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  children: [
                    const Text("How many point will you give for the convenient? (1)", style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    )),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        RatingBar.builder(
                          itemBuilder: (BuildContext context, int index) => const Icon(Icons.star, color: Colors.yellow),
                          onRatingUpdate: (value) {
                            setState(() {
                              convenientPoint = value;
                            });
                          },
                          unratedColor: Colors.blueGrey,
                          minRating: 1,
                          maxRating: 5,
                          itemSize: 25,
                          itemPadding: const EdgeInsets.only(right: 5),
                          initialRating: convenientPoint,
                          ignoreGestures: false,
                          allowHalfRating: true,
                          itemCount: 5,
                          direction: Axis.horizontal,
                          updateOnDrag: false,
                          tapOnlyMode: false,
                        ),
                        Text("$convenientPoint", style: const TextStyle(
                          fontSize: 17,
                          fontFamily: 'OpenSans',
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  children: [
                    const Text("How many point will you give for the security? (2)", style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    )),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        RatingBar.builder(
                          itemBuilder: (BuildContext context, int index) => const Icon(Icons.star, color: Colors.yellow),
                          onRatingUpdate: (value) {
                            setState(() {
                              securityPoint = value;
                            });
                          },
                          unratedColor: Colors.blueGrey,
                          minRating: 1,
                          maxRating: 5,
                          itemSize: 25,
                          itemPadding: const EdgeInsets.only(right: 5),
                          initialRating: securityPoint,
                          ignoreGestures: false,
                          allowHalfRating: true,
                          itemCount: 5,
                          direction: Axis.horizontal,
                          updateOnDrag: false,
                          tapOnlyMode: false,
                        ),
                        Text("$securityPoint", style: const TextStyle(
                          fontSize: 17,
                          fontFamily: 'OpenSans',
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  children: [
                    const Text("How many point will you give for the position? (3)", style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    )),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        RatingBar.builder(
                          itemBuilder: (BuildContext context, int index) => const Icon(Icons.star, color: Colors.yellow),
                          onRatingUpdate: (value) {
                            setState(() {
                              positionPoint = value;
                            });
                          },
                          unratedColor: Colors.blueGrey,
                          minRating: 1,
                          maxRating: 5,
                          itemSize: 25,
                          itemPadding: const EdgeInsets.only(right: 5),
                          initialRating: positionPoint,
                          ignoreGestures: false,
                          allowHalfRating: true,
                          itemCount: 5,
                          direction: Axis.horizontal,
                          updateOnDrag: false,
                          tapOnlyMode: false,
                        ),
                        Text("$positionPoint", style: const TextStyle(
                          fontSize: 17,
                          fontFamily: 'OpenSans',
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              const Text("(1) Does homestay make you feel comfortable during your rent?", style: TextStyle(
                fontSize: 15,
                fontFamily: 'OpenSans',
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              )),
              const SizedBox(height: 5,),
              const Text("(2) Does the security of homestay make you feel safe?", style: TextStyle(
                fontSize: 15,
                fontFamily: 'OpenSans',
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              )),
              const SizedBox(height: 5,),
              const Text("(3) Is the location of the homestay convenient for you to travel?", style: TextStyle(
                fontSize: 15,
                fontFamily: 'OpenSans',
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              )),
              const SizedBox(height: 50,),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      RatingModel ratingModel = RatingModel(
                        homestayName: widget.homestayName,
                        convenientPoint: convenientPoint,
                        securityPoint: securityPoint,
                        positionPoint: positionPoint,
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RatingHomestayNavigator(email: widget.email, ratingModel: ratingModel, bookingId: widget.bookingId,)));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Rate homestay".toUpperCase()),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    )
                ),
              ),
              const SizedBox(height: 5,),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePageScreen(),));
                  },
                  child: Text(
                    "Home page".toUpperCase(),
                    style: const TextStyle(),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
