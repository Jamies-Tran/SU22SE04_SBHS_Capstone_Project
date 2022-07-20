import 'package:capstoneproject/ui_kit/widget/air_18_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles.dart';

class OneStateSwitch extends StatefulWidget {
  ///only work with length is 4
  final Map<String, String> data;

  // final Map<int, String> images;
  final String selected;
  final ValueChanged<String> onChanged;
  final bool isEnable;

  const OneStateSwitch({
    required this.data,
    required this.selected,
    this.isEnable = true,
    required this.onChanged,
  });

  @override
  _OneStateSwitchState createState() => _OneStateSwitchState();
}

class _OneStateSwitchState extends State<OneStateSwitch> {
  late String selected;
  late Map<String, String> data;
  late Map<String, GlobalKey> labelKey;
  double? iconWidth = 0.0;
  double? iconHeight = 0.0;
  var widgetWidth = 0.0;

  @override
  void initState() {
    data = widget.data;
    selected = widget.selected;
    super.initState();
    labelKey = data.map((key, value) => MapEntry(key, GlobalKey()));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var width = widgetWidth -
          (labelKey.values.first.currentContext!.size!.width + 24);
      var height = labelKey.values.first.currentContext!.size!.height;
      setState(() {
        iconWidth = data.length > 1 ? width : null;
        iconHeight = data.length > 1 ? height : null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    widgetWidth = (MediaQuery.of(context).size.width - 28) / 4;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ...data
            .map(
              (key, value) => MapEntry(
                key,
                InkWell(
                  onTap: () {
                    setState(() {
                      selected = key;
                      widget.onChanged(selected);
                    });
                  },
                  child: Container(
                    width: data.values.last == value ? null : widgetWidth,
                    height: 25,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IgnorePointer(
                          child: Air18Radio(
                            marginRight: 0,
                            isCheck: key == selected,
                            isEnable: widget.isEnable,
                            onCheckChange: () {},
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 25,
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    key,
                                    style: textContentStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        height: 1.4,
                                        color: widget.isEnable
                                            ? Colors.black
                                            : Colors.black45),
                                  ),
                                ],
                              ),
                              Text(
                                'Female',
                                key: labelKey[key],
                                style: textContentStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    height: 1.4,
                                    color: Colors.transparent),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ).values.toList()
      ],
    );
  }
}
