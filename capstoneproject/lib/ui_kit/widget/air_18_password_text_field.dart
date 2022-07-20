import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

class Air18PasswordTextField extends StatefulWidget {
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final String? labelText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final bool isRepeat;
  final ValueNotifier<bool>? validNotifier;
  final String image;

   const Air18PasswordTextField({Key? key,
    this.focusNode,
    this.nextFocusNode,
    this.labelText,
    this.controller,
    this.validator,
    this.validNotifier,
    this.isRepeat = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    required this.image,
  }) : super(key: key);

  @override
  _Air18PasswordTextFieldState createState() => _Air18PasswordTextFieldState();
}

class _Air18PasswordTextFieldState extends State<Air18PasswordTextField> {
  bool isValid = false;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(() {
      if (widget.validator != null && mounted) {
        setState(() {
          isValid =
          !(widget.validator!(widget.controller?.text)?.isNotEmpty == true);
          if (widget.validNotifier != null) {
            widget.validNotifier!.value = isValid;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: (v) {
        widget.focusNode?.unfocus();
        widget.nextFocusNode?.requestFocus();
      },
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: !showPassword,
      decoration: InputDecoration(
        hintText: widget.labelText,
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 21),
            SvgPicture.asset(
              widget.image,
            ),
            const SizedBox(width: 12),
            Container(
              height: 32,
              width: 1,
              color: lightTextColor,
            ),
            const SizedBox(width: 16),
          ],
        ),
        suffixIcon: /*isValid
            ?*/
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: IconButton(
            icon: showPassword
                ? SvgPicture.asset(
              'assets/images/eye-off-line.svg',
              color: lightPurpleColor,
            )
                : SvgPicture.asset(
              'assets/images/eye-line.svg',
              width: 24,
              color: lightPurpleColor,
            ),
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
          ),
        ) /*: SizedBox()*/,
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
        errorMaxLines: 3,
      ),
    );
  }
}