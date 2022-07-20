import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

import '../colors.dart';
import '../styles.dart';

Widget makeFowButtonNew(
  String title, {
  required VoidCallback? onTap,
  double height = 38,
  double? width,
  bool isEnable = true,
}) =>
    Opacity(
      opacity: isEnable ? 1 : 0.5,
      child: Container(
        height: height,
        width: width ?? double.infinity,
        child: TextButton(
          onPressed: isEnable ? onTap : null,
          child: Text(
            title,
            style: textFowButtonStyleNew,
            textAlign: TextAlign.center,
          ),
          style: solidFowButtonStyle,
        ),
      ),
    );

Widget makeAir18Button(
  String title, {
  required VoidCallback? onTap,
  double height = 50,
  double? width,
  bool isEnable = true,
}) =>
    Opacity(
      opacity: isEnable ? 1 : 0.5,
      child: Container(
        height: height,
        width: width ?? double.infinity,
        child: TextButton(
          onPressed: isEnable ? onTap : null,
          child: Text(
            title.toUpperCase(),
            style: textFowButtonStyle,
            textAlign: TextAlign.center,
          ),
          style: solidFowButtonStyle,
        ),
      ),
    );

Widget makeAir18BorderButton(String title,
        {required VoidCallback onPressed, double height = 50}) =>
    ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: height,
        color: Colors.white,
        width: double.infinity,
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            title.toUpperCase(),
            style: textFowButtonStyle.copyWith(color: blueColor),
            textAlign: TextAlign.center,
          ),
          style: fowButtonStyle,
        ),
      ),
    );

Widget makeDashedButton(String title,
    {required VoidCallback onPressed,
    double height = 50,
    bool show = false,
    bool isEnable = true}) {
  return Container(
    width: double.infinity,
    constraints: BoxConstraints(minHeight: height),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: RDottedLineBorder.all(
        color: isEnable ? blueColor : blueColor.withOpacity(0.4),
        width: 1,
        dottedLength: 10,
        dottedSpace: 4,
      ),
    ),
    child: TextButton(
      onPressed: isEnable ? onPressed : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (show)
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isEnable
                      ? Colors.green.shade500
                      : Colors.green.shade500.withOpacity(0.4)),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 20,
              ),
            ),
          // Flexible(
          //   child: Align(
          //     alignment: Alignment.center,
          //     child: RichText(text: TextSpan(
          //       text: title,
          //       style: textFowButtonStyle.copyWith(
          //         color: isEnable ? blueColor : blueColor.withOpacity(0.4),
          //       ),
          //     ),),
          //   ),
          // ),
          Flexible(
            child: Text(
              title,
              style: textFowButtonStyle.copyWith(
                color: isEnable ? blueColor : blueColor.withOpacity(0.4),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      style: fowButtonNoBorderStyle,
    ),
  );
}

Widget makeRoundButton(String title,
    {required VoidCallback onPressed, double height = 50, bool show = false}) {
  return Container(
    width: double.infinity,
    constraints: BoxConstraints(minHeight: height),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: blueColor,
        width: 1,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (show)
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.green.shade500),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 20,
            ),
          ),
        TextButton(
          onPressed: onPressed,
          child: Text(title,
              style: textFowButtonStyle.copyWith(
                  color: blueColor, fontWeight: FontWeight.normal)),
          style: fowButtonNoBorderStyle,
        ),
      ],
    ),
  );
}

Widget makeDeleteButton(String title,
        {required VoidCallback? onTap,
        double height = 50,
        double? width,
        bool isEnable = true}) =>
    Opacity(
      opacity: isEnable ? 1 : 0.5,
      child: Container(
        height: height,
        width: width ?? double.infinity,
        child: TextButton(
            onPressed: onTap,
            child: Text(title.toUpperCase(),
                style: textFowButtonStyle.copyWith(color: Color(0xffa7bbe1))),
            style: deleteFowButtonStyle),
      ),
    );

Widget miniButton(String title,
        {required VoidCallback? onTap, bool isEnable = true}) =>
    TextButton(
        onPressed: isEnable ? onTap : null,
        child: Text(title.toUpperCase(),
            style: GoogleFonts.poppins(color: Colors.white)),
        style: miniButtonStyle);

Widget miniBorderButton(String title,
        {required VoidCallback? onTap, bool isEnable = true}) =>
    TextButton(
        onPressed: isEnable ? onTap : null,
        child: Text(title.toUpperCase(),
            style: GoogleFonts.poppins(color: blueColor)),
        style: miniBorderButtonStyle);

Widget makeFowButtonOops(
  String title, {
  required VoidCallback? onTap,
}) =>
    Container(
      width: double.infinity,
      child: TextButton(
        onPressed: onTap,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              title.toUpperCase(),
              style: textFowButtonStyle,
              textAlign: TextAlign.center,
            )),
        style: solidFowButtonStyle,
      ),
    );

Widget makeFowBorderButtonOops(String title,
        {required VoidCallback onPressed}) =>
    Container(
      color: Colors.white,
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Text(
            title.toUpperCase(),
            style: textFowButtonStyle.copyWith(color: blueColor),
            textAlign: TextAlign.center,
          ),
        ),
        style: fowButtonStyle,
      ),
    );

Widget makeAir18ButtonGradient(
  String title, {
  required VoidCallback? onTap,
  double height = 50,
  double? width,
  bool isEnable = true,
}) =>
    Opacity(
      opacity: isEnable ? 1 : 0.5,
      child: GestureDetector(
        onTap: isEnable ? onTap : null,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: height,
            width: width ?? double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF09314F),
                  Color(0xFF7F53AC),
                ],
              ),
            ),
            child: Center(
              child: Text(
                title.toUpperCase(),
                style: textFowButtonStyle.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
