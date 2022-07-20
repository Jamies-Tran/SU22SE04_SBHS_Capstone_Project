import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Air18CheckBox extends StatefulWidget {
  final bool isCheck;
  final ValueNotifier<bool>? checkNotifier;
  final ValueChanged<bool> valueChanged;
  const Air18CheckBox(
      {this.isCheck = false,
      this.checkNotifier,
      required this.valueChanged,
      Key? key})
      : super(key: key);

  @override
  _Air18CheckBoxState createState() => _Air18CheckBoxState();
}

class _Air18CheckBoxState extends State<Air18CheckBox> {
  late bool isCheck;

  @override
  void initState() {
    isCheck = widget.isCheck;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Air18CheckBox oldWidget) {
    isCheck = widget.isCheck;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: isCheck
            ? SvgPicture.asset('assets/images/fow-checkbox.svg')
            : SvgPicture.asset('assets/images/fow-uncheckbox.svg'),
        onTap: () {
          setState(() {
            isCheck = !isCheck;
            if (widget.checkNotifier != null) {
              widget.checkNotifier!.value = isCheck;
            }
            widget.valueChanged(isCheck);
          });
        },
    );
  }
}
