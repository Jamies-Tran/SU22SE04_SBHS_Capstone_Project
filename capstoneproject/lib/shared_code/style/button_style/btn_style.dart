import 'package:capstoneproject/utils/materials/app_color.dart';
import 'package:flutter/material.dart';

class BtnStyle {
  static TextStyle textButtonBold() {
    return TextStyle(
      fontSize: 14,
      color: AppColor.textSecondColor,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle textButtonNormal() {
    return TextStyle(
      fontSize: 14,
      color: AppColor.textSecondColor,
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle textSmallButtonBold() {
    return TextStyle(
      fontSize: 12,
      color: AppColor.textSecondColor,
      fontWeight: FontWeight.bold,
    );
  }
}
