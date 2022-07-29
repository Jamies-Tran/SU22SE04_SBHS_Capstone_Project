import 'package:capstoneproject2/constants.dart';
import 'package:flutter/material.dart';

class HomestayTopComponent extends StatelessWidget {
  const HomestayTopComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Theme.of(context).primaryColor, spreadRadius: 3)
        ]
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text("Welcome, ", style: TextStyle(
                fontSize: 20,
                fontFamily: 'OpenSans',
                letterSpacing: 2.0,
                color: Colors.black54
            )),
          ),


          const Padding(
            padding: EdgeInsets.all(10),
            child: Text("Where do you want to go?", style: TextStyle(
                fontSize: 25,
                fontFamily: 'OpenSans',
                letterSpacing: 3.5,
                fontWeight: FontWeight.bold,
                color: Colors.black87
            ),),
          ),

          Container(
            margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: TextField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            fillColor: Colors.white54,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none
                            ),
                            hintText: 'Search',
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18
                            ),
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(15),
                              width: 18,
                              child: const Icon(Icons.search),
                            )
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
