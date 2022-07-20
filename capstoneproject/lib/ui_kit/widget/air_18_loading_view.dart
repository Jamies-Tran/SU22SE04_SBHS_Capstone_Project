import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Air18LoadingView extends StatefulWidget {
  final double ratio;
  const Air18LoadingView({this.ratio = 2.0 / 3.0, Key? key}) : super(key: key);

  @override
  _Air18LoadingViewState createState() => _Air18LoadingViewState();
}

class _Air18LoadingViewState extends State<Air18LoadingView> {

  @override
  Widget build(BuildContext context) {
    return buildLoading();
  }

  Widget buildLoading() {
    Widget child = Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      width: 115,
      height: 115,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          backgroundColor: Colors.transparent,
          colors: [
            Colors.blue,
            Colors.green,
            Colors.greenAccent,
            Colors.yellow,
            Colors.orange,
            Colors.red,
            Colors.pink,
            Colors.purple,
            Colors.indigo
          ],
        ),
      )
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height * widget.ratio,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [child],
        ),
      ),
    );
  }
}
