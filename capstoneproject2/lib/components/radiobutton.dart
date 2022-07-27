import 'package:flutter/material.dart';

enum SingingCharacter { Female, Male }
SingingCharacter? character;

class RadioButtonOnlyOne extends StatefulWidget {
  const RadioButtonOnlyOne({Key? key}) : super(key: key);

  @override
  State<RadioButtonOnlyOne> createState() => _RadioButtonOnlyOneState();
}

class _RadioButtonOnlyOneState extends State<RadioButtonOnlyOne> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Female'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.Female,
            groupValue: character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Male'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.Male,
            groupValue: character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                character = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
