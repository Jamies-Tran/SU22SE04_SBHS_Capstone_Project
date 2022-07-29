//dang fix
import 'package:capstoneproject2/constants.dart';
import 'package:flutter/material.dart';
import 'package:capstoneproject2/components/iconssrc.dart';
class ProfileFormPage extends StatefulWidget {
  const ProfileFormPage({Key? key}) : super(key: key);

  @override
  State<ProfileFormPage> createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends State<ProfileFormPage> {


  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A', 'B', 'C'];
    final List<int> colorCodes = <int>[600, 500, 100];
    final ButtonStyle style =
    TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
              style: style,
              onPressed: (){},
              child: const Text('Log out'),
          ),
          Text("Hello, Anh Tuan"),
        ],
      ),
      body: Column(
        children: [
          Text("My Account"),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconsButton(
                  iconSrc: "assets/icons/user.svg",
                press: () async {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) =>));
                },
              ),
              TextButton(
                  onPressed: () async {
                  },
                child: const Text('Profile'),
              ),
              SizedBox(height: defaultPadding / 2),
              IconsButton(
                iconSrc: "assets/icons/user.svg",
                press: () async {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) =>));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
