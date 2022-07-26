import 'package:flutter/material.dart';

enum SingingCharacter { Female, Male }
class RadioButtonOnlyOne extends StatefulWidget {
  const RadioButtonOnlyOne({Key? key}) : super(key: key);

  @override
  State<RadioButtonOnlyOne> createState() => _RadioButtonOnlyOneState();
}

class _RadioButtonOnlyOneState extends State<RadioButtonOnlyOne> {
  SingingCharacter? _character = SingingCharacter.Male;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Female'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.Female,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Male'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.Male,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
