

import 'package:capstoneproject2/screens/home_page/components/homestay_body_component.dart';
import 'package:capstoneproject2/screens/home_page/components/homestay_top_component.dart';
import 'package:flutter/material.dart';

class ViewHomestayScreen extends StatefulWidget {
  const ViewHomestayScreen({Key? key}) : super(key: key);

  @override
  State<ViewHomestayScreen> createState() => _ViewHomestayScreenState();
}

class _ViewHomestayScreenState extends State<ViewHomestayScreen> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        children: const [
          HomestayTopComponent(),
          HomestayBodyComponent()
        ],
      ),
    );
  }
}
