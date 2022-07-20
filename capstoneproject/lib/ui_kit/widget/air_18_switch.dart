import 'package:flutter/material.dart';

import '../styles.dart';
import 'air_18_radio.dart';

class Air18Switch extends StatefulWidget {
  final bool isPositive;
  final String firstText;
  final String secondText;
  Air18Switch(
      {required this.isPositive,
      required this.firstText,
      required this.secondText});

  @override
  _Air18SwitchState createState() => _Air18SwitchState();
}

class _Air18SwitchState extends State<Air18Switch> {
  bool isPositive = true;

  @override
  void initState() {
    isPositive = widget.isPositive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Air18Radio(
            isCheck: isPositive,
            onCheckChange: () {
              setState(() {
                isPositive = true;
              });
            },
          ),
          Text(
            widget.firstText,
            style: textContentStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 16),
          Air18Radio(
            isCheck: !isPositive,
            onCheckChange: () {
              setState(() {
                isPositive = false;
              });
            },
          ),
          Text(
            widget.secondText,
            style: textContentStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
