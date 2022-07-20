import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Air18Radio extends StatefulWidget {
  final bool isCheck;
  final VoidCallback onCheckChange;
  final bool isEnable;
  final double marginRight;
  const Air18Radio({
    required this.isCheck,
    required this.onCheckChange,
    this.isEnable = true,
    this.marginRight = 4.0,
    Key? key,
  }) : super(key: key);

  @override
  _Air18RadioState createState() => _Air18RadioState();
}

class _Air18RadioState extends State<Air18Radio> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final icon = !widget.isEnable
        ? SvgPicture.asset('assets/images/radio_blur.svg')
        : widget.isCheck
            ? SvgPicture.asset('assets/images/icon.svg')
            : SvgPicture.asset('assets/images/icon-uncheck.svg');
    return GestureDetector(
        onTap: () {
          setState(() {
            widget.onCheckChange();
          });
        },
        child: Container(
          margin: EdgeInsets.only(right: this.widget.marginRight),
          child: icon,
        ));
  }
}
