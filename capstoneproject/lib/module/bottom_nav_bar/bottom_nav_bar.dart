import 'package:capstoneproject/module/booking/booking_page.dart';
import 'package:capstoneproject/module/home/ui/home_page.dart';
import 'package:capstoneproject/module/message/message_page.dart';
import 'package:capstoneproject/module/profile/profile_page.dart';
import 'package:capstoneproject/module/trip/trip_page.dart';
import 'package:flutter/material.dart';
import 'custom_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  final String userID;
  const BottomNavBar({Key? key, required this.userID}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  Widget? callPage(int current) {
    switch (current) {
      case 0:
        return const HomePage();
      case 1:
        return const MessagePage();
      case 2:
        return const TripPage();
      case 3:
        return const BookingHistoryPage();
      case 4:
        return ProfilePage(
          userID: widget.userID,
        );
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: callPage(currentIndex),
      bottomNavigationBar: BottomNavigationDotBar(
        color: Colors.black26,
        items: <BottomNavigationDotBarItem>[
          BottomNavigationDotBarItem(
              icon: const IconData(0xe900, fontFamily: 'home'),
              onTap: () {
                setState(() {
                  currentIndex = 0;
                });
              }),
          BottomNavigationDotBarItem(
              icon: const IconData(0xe900, fontFamily: 'message'),
              onTap: () {
                setState(() {
                  currentIndex = 1;
                });
              }),
          BottomNavigationDotBarItem(
              icon: const IconData(
                0xe900,
                fontFamily: 'trip',
              ),
              onTap: () {
                setState(
                  () {
                    currentIndex = 2;
                  },
                );
              }),
          BottomNavigationDotBarItem(
              icon: const IconData(
                0xe900,
                fontFamily: 'hearth',
              ),
              onTap: () {
                setState(() {
                  currentIndex = 3;
                });
              }),
          BottomNavigationDotBarItem(
              icon: const IconData(0xe900, fontFamily: 'profile'),
              onTap: () {
                setState(() {
                  currentIndex = 4;
                });
              }),
        ],
      ),
    );
  }
}
