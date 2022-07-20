import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../colors.dart';

class Air18DateTime extends StatefulWidget {
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final String? labelText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final int maxLines;
  final DateTime currentDateTime;
  final bool isBirthDate;
  final ValueNotifier<bool>? validNotifier;
  final bool isEnable;
  final bool isBlueColor;
  final Function? handleSubmit;
  Air18DateTime({
    this.focusNode,
    this.nextFocusNode,
    this.labelText,
    this.validNotifier,
    this.controller,
    required this.currentDateTime,
    this.maxLines = 1,
    this.isBirthDate = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.isEnable = true,
    this.isBlueColor = false,
    this.handleSubmit,
  });

  @override
  _Air18DateTimeState createState() => _Air18DateTimeState();
}

class _Air18DateTimeState extends State<Air18DateTime> {
  bool isValid = false;
  late DateTime currentDateTime;
  String validate = '';

  Future<void> _selectDate(BuildContext context) async {
    var picked = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: currentDateTime,
      firstDate: DateTime(DateTime.now().year-60),
      lastDate: DateTime.now(),
      dateFormat: "dd-MMMM-yyyy",
      locale: DateTimePickerLocale.en_us,
      titleText: 'Choose BirthDate',
      confirmText: 'Ok',
      cancelText: 'Cancel',
      looping: true,
    );
    debugPrint('PICKED: '+picked.toString());
    bool isNow = picked?.day == DateTime.now().day && picked?.month == DateTime.now().month && picked?.year == DateTime.now().year ;
    if (picked != currentDateTime && picked != null) {
      setState(() {
        // print('PICKED: '+picked.toString());
        currentDateTime = picked;
      });
    }
    if(isNow){
      setState(() {
        // print('PICKED: '+picked.toString());
        validate = "Birthday must be more than 18 years old";
      });
    }
    if(picked!=null){
      final DateFormat _monthFormat = DateFormat("dd/MM/yyyy");
      widget.controller!.text = _monthFormat.format(currentDateTime);
      validate = validatorAge(_monthFormat.format(currentDateTime)) ?? '';
      if (widget.handleSubmit != null) {
        widget.handleSubmit!();
      }
    }
  }

  String? validatorAge(String? value) {
    if (value != null) {
      int y2 = DateTime.now().year;
      int y1 = int.parse(value.substring(6, 10));

      y2 = y2 - y1;

      if(y2>=18) {
        return null;
      } else {
        return "Birthday must be more than 18 years old";
      }
    }
    return "Birthday is required";
  }

  @override
  void initState() {
    super.initState();
    currentDateTime = widget.currentDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            print("TAXP");
            if (widget.isEnable) {
              FocusScope.of(context).unfocus();
              _selectDate(context);
              if(validate.isNotEmpty){
                setState(() {});
              }
            }
          },
          child: TextFormField(
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            maxLines: widget.maxLines,
            focusNode: widget.focusNode,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: (v) {
              widget.focusNode?.unfocus();
              widget.nextFocusNode?.requestFocus();
            },
            enabled: false,
            style: !widget.isEnable
                ? GoogleFonts.poppins(color: Colors.black38)
                : null,
            decoration: InputDecoration(
              hintText: widget.labelText,
              fillColor: Colors.white,
              filled: true,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
                child: SvgPicture.asset(
                  'assets/images/calender_icon.svg',
                  color:
                      widget.isEnable ? blueColor : blueColor.withOpacity(0.4),
                ),
              ),
              hintStyle: GoogleFonts.poppins(fontSize: 15),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: blueColor, width: 2)),
              contentPadding: EdgeInsets.only(top: 12, bottom: 12, left: 24),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: lightPurpleColor, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: lightPurpleColor, width: 2)),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: validate.isEmpty
                      ? (widget.isBlueColor
                          ? (widget.isEnable
                              ? blueColor
                              : blueColor.withOpacity(0.4))
                          : lightPurpleColor)
                      : Colors.red.shade700,
                  width: widget.isEnable ? 2 : 1,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              validate,
              style: TextStyle(color: Colors.red.shade700, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
