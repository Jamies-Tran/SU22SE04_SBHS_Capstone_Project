import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class RatingComponent extends StatefulWidget {
  const RatingComponent({Key? key, this.point, this.size}) : super(key: key);
  final point;
  final size;

  @override
  State<RatingComponent> createState() => _RatingComponentState();
}

class _RatingComponentState extends State<RatingComponent> {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        itemBuilder: (BuildContext context, int index) => const Icon(Icons.star, color: Colors.yellow),
        onRatingUpdate: (value) { },
        unratedColor: Colors.blueGrey,
        minRating: 1,
        maxRating: 5,
        itemSize: widget.size ?? 25,
        itemPadding: const EdgeInsets.only(right: 5),
        initialRating: widget.point,
        ignoreGestures: true,
        allowHalfRating: true,
        itemCount: 5,
        direction: Axis.horizontal,
        updateOnDrag: false,
        tapOnlyMode: false,
    );
  }
}
