import 'package:flutter/material.dart';

class ProfileOption extends StatelessWidget {
  const ProfileOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.all(20),
      children: [
        ListTile(
          title: const Text("Manage wallet"),
          focusColor: Colors.purpleAccent,
          onTap: () {

          },
        ),

        const SizedBox(height: 10),

        ListTile(
          title: const Text("Manage information"),
          focusColor: Colors.purpleAccent,
          onTap: () {

          },
        ),

        const SizedBox(height: 10),

        ListTile(
          title: const Text("Your booking"),
          focusColor: Colors.purpleAccent,
          onTap: () {

          },
        ),
      ],
    );
  }
}
