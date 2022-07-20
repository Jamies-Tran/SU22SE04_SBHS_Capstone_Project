import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';
import 'air_18_button.dart';

class Air18NotificationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String? positive;
  final String? negative;
  final VoidCallback onNegativeTap;
  final VoidCallback onPositiveTap;
  final bool? isShowNegative;

  const Air18NotificationDialog(
      {Key? key,
      required this.title,
      required this.content,
      this.positive,
      this.negative,
      required this.onNegativeTap,
      required this.onPositiveTap,
      this.isShowNegative})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: Container(
        height: 240,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                        color: orangeColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RichText(
                  text: TextSpan(
                    text: content,
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isShowNegative == true)
                      Expanded(
                        child: makeAir18BorderButton(
                          (negative??"").toUpperCase(),
                            onPressed: onNegativeTap,
                        ),
                      ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: makeAir18Button(
                          (positive ?? "").toUpperCase(),
                          onTap: onPositiveTap,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
