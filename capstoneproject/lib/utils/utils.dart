import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final DialogUtil dialogUtil = DialogUtil._internal();
int maximumSize = 2000000;

class DialogUtil {
  DialogUtil._internal();

  // showAlertDialog({
  //   required BuildContext context,
  //   required String alertTitle,
  //   required String alertMessage,
  //   String yesButtonText = "Đồng ý",
  //   String cancelButtonText = "Huỷ",
  //   required VoidCallback onYesPress,
  //   bool canDismiss = true
  // }) {
  //   showDialog(
  //       context: context,
  //       builder: (context) => NotificationDialog(
  //         title: alertTitle,
  //         content: alertMessage,
  //         onPositiveTap: onYesPress,
  //         onNegativeTap: () {
  //           Navigator.pop(context);
  //         },
  //         positive: yesButtonText,
  //         negative: cancelButtonText,
  //       ));
  // }

  Future<T> showLoadingPopup<T>(
    BuildContext context,
    Future<T> future, {
    String? loadingText,
    Widget? dialogState,
  }) async {
    BuildContext? popupContext;
    final dialog = dialogState ?? _buildLoadingDialog(context, loadingText);
    if (Platform.isIOS) {
      showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          popupContext = context;
          return dialog;
        },
      );
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          popupContext = context;
          return dialog;
        },
      );
    }
    try {
      return await future;
    } catch (e) {
      rethrow;
    } finally {
      Navigator.of(popupContext ?? context, rootNavigator: true).pop();
    }
  }

  Widget _buildLoadingDialog(
    BuildContext context,
    String? loadingText,
  ) {
    Widget child = IntrinsicWidth(
      stepWidth: 56.0,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 200.0,
          minWidth: 100.0,
          minHeight: 100.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16),
              child: CupertinoActivityIndicator(
                radius: 32,
              ),
            ),
            if (loadingText != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  loadingText,
                ),
              ),
          ],
        ),
      ),
    );

    final DialogTheme dialogTheme = DialogTheme.of(context);
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 105.0,
              maxHeight: 105,
            ),
            child: Material(
              color: dialogTheme.backgroundColor?.withOpacity(1.0) ??
                  Theme.of(context).dialogBackgroundColor.withOpacity(1.0),
              elevation: dialogTheme.elevation ?? 24,
              shape: dialogTheme.shape,
              type: MaterialType.card,
              child: child,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }

  void showToast(String message) {
    // Fluttertoast.showToast(
    //     msg: message,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 3,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
  }

  // void showOkToast(String message) {
  //   Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 3,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }

  void showToastLong(String message) {
    // Fluttertoast.showToast(
    //     msg: message,
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 3,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
  }
}

void bookHotelLog(dynamic data) {
  debugPrint("///////////////////////////////////////");
  debugPrint(data);
  debugPrint("///////////////////////////////////////");
}

String trimStart(String? value) {
  final String phone = value ?? '';
  final nineNumberPhone = phone.replaceFirst(RegExp(r"^0+(?!$)"), "");
  return '+84$nineNumberPhone';
}
// String? validatorPassword(String? password) {
//   return (password != null && password.length >= 9) == true ?
//   null : 'Password must at least 9 characters';
// }

String? validatorPassword(String? password) {
  RegExp regex =
      RegExp(r'^((?=.*[A-Z])|(?=.*[@$!%*#?&]))[A-Za-z\d@$!%*#?&]{8,20}$');
  if (password != null && regex.hasMatch(password)) {
    return null;
  } else {
    return 'Between 8-20 characters, contain at least one uppercase or one special character';
  }
}

String? validatorEmail(String? email) {
  RegExp regex = RegExp(
      r'^[^_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ]*$');
  return (email != null &&
              EmailValidator.validate(email) &&
              regex.hasMatch(email)) ==
          true
      ? null
      : 'Email incorrect';
}

String? validatorFirstName(String? name) {
  return (name != null && name.isNotEmpty) == true
      ? null
      : 'First Name isn\'t empty';
}

String? validatorLastName(String? name) {
  return (name != null && name.isNotEmpty) == true
      ? null
      : 'Last Name isn\'t empty';
}

String digitFormat(int? number) {
  if (number == null) return '00';
  var f = NumberFormat("00");
  return f.format(number);
}

String formatDate(String date) {
  if (date.contains('-')) {
    return date.substring(8) +
        "/" +
        date.substring(5, 7) +
        "/" +
        date.substring(0, 4);
  }
  return date.substring(6) +
      "-" +
      date.substring(3, 5) +
      "-" +
      date.substring(0, 2);
}
