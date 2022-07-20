import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

class Air18TextField extends StatefulWidget {
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final String? labelText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final int maxLines;
  final ValueNotifier<bool>? validNotifier;
  final int? maxLength;
  final ValueNotifier<String>? stringNotifier;
  final bool isEnable;
  final bool isBlueColor;
  Air18TextField({
    this.focusNode,
    this.nextFocusNode,
    this.labelText,
    this.controller,
    this.validator,
    this.maxLines = 1,
    this.validNotifier,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLength,
    this.stringNotifier,
    this.isEnable = true,
    this.isBlueColor = false,
  });

  @override
  _Air18TextFieldState createState() => _Air18TextFieldState();
}

class _Air18TextFieldState extends State<Air18TextField> {
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(() {
      if (widget.validator != null && mounted)
        setState(() {
          isValid =
              !(widget.validator!(widget.controller?.text)?.isNotEmpty == true);
          if (widget.validNotifier != null)
            widget.validNotifier!.value = isValid;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      maxLines: widget.maxLines,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: (v) {
        widget.focusNode?.unfocus();
        widget.nextFocusNode?.requestFocus();
      },
      onChanged: (value) {
        if (widget.stringNotifier != null) widget.stringNotifier!.value = value;
      },
      style:
          GoogleFonts.poppins(color: widget.isEnable ? null : Colors.black38),
      maxLength: widget.maxLength,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: widget.isEnable,
      decoration: InputDecoration(
        hintText: widget.labelText,
        fillColor: Colors.white,
        filled: true,
        counterText: "",
        suffixIcon: (isValid && widget.isEnable)
            ? Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.check,
                  color: orangeColor,
                ),
              )
            : SizedBox(),
        hintStyle: GoogleFonts.poppins(fontSize: 15),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: blueColor, width: 2)),
        contentPadding: const EdgeInsets.only(top: 12, bottom: 12, left: 24),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: lightPurpleColor, width: 2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: widget.isBlueColor ? blueColor : lightPurpleColor,
                width: 2)),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: blueColor.withOpacity(0.4), width: 1),
        ),
        errorMaxLines: 3,
      ),
    );
  }
}
