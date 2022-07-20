library dialog_ui;

import 'dart:io';

import 'package:capstoneproject/ui_kit/widget/air_18_notification_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class DialogUtil {
  void showAlertDialog({
    required BuildContext context,
    required String alertTitle,
    required String alertMessage,
    String yesButtonText = "Đồng ý",
    String cancelButtonText = "Huỷ",
    required VoidCallback onYesPress,
    bool canDismiss = true}) {
    showDialog(
      context: context,
      builder: (context) => Air18NotificationDialog(
        title: alertTitle,
        content: alertMessage,
        onPositiveTap: onYesPress,
        onNegativeTap: () {
          Navigator.pop(context);
        },
        positive: yesButtonText,
        negative: cancelButtonText,
      ),
    );
  }

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
          context: context,
          builder: (context) {
            popupContext = context;
            return dialog;
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            popupContext = context;
            return dialog;
          });
    }
    try {
      return await future;
    } catch (e) {
      rethrow;
    } finally {
      Navigator.of(popupContext ?? context, rootNavigator: true).pop();
    }
  }

  Widget _buildLoadingDialog(BuildContext context, String? loadingText) {
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
              child: LoadingIndicator(
                indicatorType: Indicator.ballSpinFadeLoader,
                backgroundColor: Colors.transparent,
                colors: [
                  Colors.blue,
                  Colors.green,
                  Colors.greenAccent,
                  Colors.yellow,
                  Colors.orange,
                  Colors.red,
                  Colors.pink,
                  Colors.purple,
                  Colors.indigo
                ],
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
}
