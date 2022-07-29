import 'package:capstoneproject2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinKitComponent extends StatelessWidget {
  const SpinKitComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryLightColor,
      child: const SpinKitThreeInOut(
        color: Colors.grey,
      ),
    );
  }
}
