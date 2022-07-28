// dang fix
import 'package:capstoneproject2/Screens/HomePage/components/profile_form_page.dart';
import 'package:capstoneproject2/Screens/HomePage/components/swapper_screen.dart';
import 'package:capstoneproject2/Screens/HomePage/components/view_homestay_screen.dart';
import 'package:capstoneproject2/Screens/Profile/screen_profile.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 5);
  static const List<Widget> _widgetOptions = <Widget>[
    ViewHomestayScreen(),

    ProfileInforScreen(),

    Wrapper(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Stay With Me'),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin_rounded),
            label: 'Profile',


          ),

          // BottomNavigationBarItem(
          //   icon: Icon(Icons.bookmark_add),
          //   label: 'Wishlist',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person_pin_rounded),
          //   label: 'Profile',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
