// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:capstoneproject/hive/hive_service.dart';
import 'package:capstoneproject/injection/injection.dart';
import 'package:capstoneproject/module/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:capstoneproject/ui_kit/SupportingLibrary/Animation/fade_animation.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_button.dart';
import 'package:flutter/material.dart';

class MainSelection extends StatefulWidget {
  final String userID;

  const MainSelection({Key? key, required this.userID}) : super(key: key);

  @override
  _MainSelectionState createState() => _MainSelectionState();
}

class _MainSelectionState extends State<MainSelection> {
  ValueNotifier<bool> button1Notifier = ValueNotifier(true);
  ValueNotifier<bool> button2Notifier = ValueNotifier(true);
  ValueNotifier<bool> button3Notifier = ValueNotifier(true);
  ValueNotifier<bool> button4Notifier = ValueNotifier(true);
  ValueNotifier<bool> button5Notifier = ValueNotifier(true);
  ValueNotifier<bool> button6Notifier = ValueNotifier(true);
  ValueNotifier<bool> submitNotifier = ValueNotifier(false);
  HiveService hive = getIt<HiveService>();

  @override
  void initState() {
    button1Notifier.addListener(() {
      _enableNotifier();
    });
    button2Notifier.addListener(() {
      _enableNotifier();
    });
    button3Notifier.addListener(() {
      _enableNotifier();
    });
    button4Notifier.addListener(() {
      _enableNotifier();
    });
    button5Notifier.addListener(() {
      _enableNotifier();
    });
    button6Notifier.addListener(() {
      _enableNotifier();
    });
  }

  Widget _buildItem(
      {required ValueNotifier<bool> notifier,
      required String imagePath,
      required String title,
      required double delay}) {
    return FadeAnimation(
      delay,
      ValueListenableBuilder<bool>(
        valueListenable: notifier,
        builder: (context, value, _) {
          if (value) {
            return ItemCard(
              image: imagePath,
              title: title,
            );
          }
          return ItemCardSelected(
            image: imagePath,
            title: title,
            sizeFont: 25.0,
          );
        },
      ),
    );
  }

  void _enableNotifier() {
    var isUnSelectedAll = button1Notifier.value == button2Notifier.value &&
        button1Notifier.value == button3Notifier.value &&
        button1Notifier.value == button4Notifier.value &&
        button1Notifier.value == button5Notifier.value &&
        button1Notifier.value == button6Notifier.value &&
        button1Notifier.value == true;

    var isSelectedAll = button1Notifier.value == button2Notifier.value &&
        button1Notifier.value == button3Notifier.value &&
        button1Notifier.value == button4Notifier.value &&
        button1Notifier.value == button5Notifier.value &&
        button1Notifier.value == button6Notifier.value &&
        button1Notifier.value == false;

    if (isUnSelectedAll) {
      submitNotifier.value = false;
    } else if (isSelectedAll) {
      submitNotifier.value = true;
    } else {
      submitNotifier.value = button1Notifier.value ||
          button2Notifier.value ||
          button3Notifier.value ||
          button4Notifier.value ||
          button5Notifier.value ||
          button6Notifier.value;
    }
  }

  void _updateState({required ValueNotifier<bool> notifier}) =>
      notifier.value = !notifier.value;

  void _onPress() {
    getIt<HiveService>().updateShowSelection(true);
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BottomNavBar(
          userID: widget.userID,
        ),
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return Opacity(
            opacity: animation.value,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10.0,
            ),
            const FadeAnimation(
              0.1,
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Where you want to go?',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Sofia",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: ()=> _updateState(notifier: button1Notifier),
                  child: _buildItem(
                    title: 'museum',
                    imagePath:
                        "assets/image/destinationPopuler/destination1.png",
                    notifier: button1Notifier,
                    delay: 0.9,
                  ),
                ),
                InkWell(
                  onTap: ()=> _updateState(notifier: button2Notifier),
                  child: _buildItem(
                      title: 'park',
                      imagePath:
                          "assets/image/destinationPopuler/destination5.jpg",
                      notifier: button2Notifier,
                      delay: 1.7),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: ()=> _updateState(notifier: button3Notifier),
                  child: _buildItem(
                    notifier: button3Notifier,
                    imagePath: "assets/image/destinationPopuler/populer2.png",
                    title: "beach",
                    delay: 2.4,
                  ),
                ),
                InkWell(
                  onTap: ()=> _updateState(notifier: button4Notifier),
                  child: _buildItem(
                    notifier: button4Notifier,
                    imagePath:
                        "assets/image/destinationPopuler/destination4.jpg",
                    title: "mountain",
                    delay: 3.2,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: ()=> _updateState(notifier: button5Notifier),
                  child: _buildItem(
                    notifier: button5Notifier,
                    imagePath: "assets/image/homeImage/hotel.png",
                    title: "hotel",
                    delay: 4.0,
                  ),
                ),
                InkWell(
                  onTap: ()=> _updateState(notifier: button6Notifier),
                  child: _buildItem(
                    notifier: button6Notifier,
                    imagePath: "assets/image/homeImage/experience.png",
                    title: "experience",
                    delay: 4.8,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 70.0,
            ),
            FadeAnimation(
              5.5,
              ValueListenableBuilder<bool>(
                valueListenable: submitNotifier,
                builder: (context, value, _) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: makeAir18ButtonGradient(
                      "Next",
                      onTap: _onPress,
                      isEnable: value,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30.0,
            )
          ],
        ),
      ),
    );
  }
}

///
/// Create item card
///
class ItemCard extends StatelessWidget {
  final String image, title;

  ItemCard({Key? key, required this.image, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 10.0),
      child: Container(
        height: 85.0,
        width: 165.0,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Material(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFABABAB).withOpacity(0.7),
                  blurRadius: 4.0,
                  spreadRadius: 3.0,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                color: Colors.black12.withOpacity(0.1),
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    shadows: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                    color: Colors.white,
                    fontFamily: "Sofia",
                    fontWeight: FontWeight.w800,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///
/// Create item card
///
class ItemCardSelected extends StatelessWidget {
  final String image, title;
  final double sizeFont;

  ItemCardSelected(
      {Key? key,
      required this.image,
      required this.title,
      required this.sizeFont})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 10.0),
      child: Container(
        height: 85.0,
        width: 165.0,
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFF09314F), Color(0xFF7F53AC)]),
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Material(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(const Radius.circular(15.0)),
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFABABAB).withOpacity(0.7),
                  blurRadius: 4.0,
                  spreadRadius: 3.0,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                gradient: LinearGradient(colors: [
                  const Color(0xFF09314F).withOpacity(0.5),
                  const Color(0xFF7F53AC).withOpacity(0.5),
                ]),
              ),
              child: Center(
                child: Text(
                  'selected',
                  style: TextStyle(
                    shadows: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          blurRadius: 10.0,
                          spreadRadius: 2.0)
                    ],
                    color: Colors.white,
                    fontFamily: "Sofia",
                    fontWeight: FontWeight.w800,
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
