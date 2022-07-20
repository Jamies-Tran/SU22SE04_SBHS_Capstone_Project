
import 'package:capstoneproject/module/room/ui/review_item.dart';
import 'package:capstoneproject/shared_code/model/review_model.dart';
import 'package:flutter/material.dart';

class HotelReviewTab extends StatelessWidget {
  const HotelReviewTab({
    Key? key,
    this.reviews,
  }) : super(key: key);

  final List<Reviews>? reviews;

  @override
  Widget build(BuildContext context) {
    if (reviews!.isEmpty) {
      return const Center(
        child: Text(
          "No review 😶",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: reviews!.length,
          itemBuilder: (context, index) => ReviewItem(review: reviews![index]),
        ),
      );
    }
  }
}
