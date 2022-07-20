import 'package:capstoneproject/shared_code/style/text_style/txt_style.dart';
import 'package:capstoneproject/utils/materials/app_color.dart';
import 'package:flutter/material.dart';

class AppBarStyle {
  static TextStyle titleAppBar() {
    return AppBarTitleTextStyle.titleBoldAppBar();
  }

  static Color backgroundAppBar() {
    return AppColor.primaryColor;
  }

  static Color backgroundCustomAppBar() {
    return AppColor.primaryColor;
  }

  static Icon iconAppBar() {
    return Icon(
      Icons.arrow_back,
      color: AppColor.textSecondColor,
    );
  }
}
