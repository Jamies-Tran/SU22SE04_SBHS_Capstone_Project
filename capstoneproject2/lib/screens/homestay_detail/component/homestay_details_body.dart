import 'package:capstoneproject2/Screens/Welcome/welcome_screen.dart';
import 'package:capstoneproject2/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../services/model/homestay_model.dart';

class HomestayDetailsBody extends StatelessWidget {
  const HomestayDetailsBody({Key? key, this.homestayModel}) : super(key: key);
  final HomestayModel? homestayModel;


  @override
  Widget build(BuildContext context) {
    final firebaseAuth = FirebaseAuth.instance;
    final currencyFormat = NumberFormat("#,##0");
    var rows = <TableRow>[];
    homestayModel?.homestayServices.forEach((element) {
      rows.add(TableRow(

        children: [
          TableCell(
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: Text("${element.name}", style: const TextStyle(
                    fontSize: 17,
                    fontFamily: 'OpenSans',
                    letterSpacing: 3.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),),
          )),
          TableCell(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text("${currencyFormat.format(element.price)} / vnd", style: const TextStyle(
                    fontSize: 17,
                    fontFamily: 'OpenSans',
                    letterSpacing: 3.0,
                    color: Colors.black,
                ),),
              )
          )
        ]
      ));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              const Icon(Icons.attach_money, color: Colors.green),
              Text  ("${currencyFormat.format(homestayModel?.price)}/day", style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'OpenSans',
                  letterSpacing: 2.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold
              )),
              const SizedBox(width: 40,),
              const Icon(Icons.bedroom_parent_sharp, color: Colors.red,),
              Text("${homestayModel?.numberOfRoom}/rooms", style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'OpenSans',
                  letterSpacing: 2.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold
              )),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if(firebaseAuth.currentUser == null) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomeScreen(),));
            }
          },
          style: ElevatedButton.styleFrom(
              primary: firebaseAuth.currentUser == null ? Colors.red : kPrimaryColor, elevation: 0),
          child: Text(
            firebaseAuth.currentUser == null ? "Sign Up".toUpperCase() : "Book".toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 10,),
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: const Text(
            "Description: ",
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'OpenSans',
                letterSpacing: 3.0,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Row(
          children: [
            Flexible(
                child: Text(
                  "${homestayModel?.description!}",
                  maxLines: 10,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'OpenSans',
                      letterSpacing: 2.0,
                      color: Colors.black,
                  ),
                )
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10, top: 5),
          child: const Text(
            "Service list: ",
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'OpenSans',
                letterSpacing: 3.0,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Table(
          border: TableBorder.all(color: Colors.black54.withOpacity(0.2)),
          columnWidths: const {
            0 : IntrinsicColumnWidth(),
            2 : IntrinsicColumnWidth()
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: rows
        )
      ],
    );
  }
}
