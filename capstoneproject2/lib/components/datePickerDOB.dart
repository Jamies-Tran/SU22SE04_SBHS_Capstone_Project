import 'package:capstoneproject2/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../utils.dart';

String dateValue = "";
class CupertinoDateDOB extends StatelessWidget {

  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      // Text('Day of birth (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
        onChanged: (value) {
          dateValue = value.toString();
        },
      ),
    ]);
  }
}

