import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Coming soon", style: TextStyle(
          fontSize: 15,
          fontFamily: 'OpenSans',
          letterSpacing: 3.0,
          color: Colors.black87,
          fontWeight: FontWeight.bold
      )),
    );
  }
}
