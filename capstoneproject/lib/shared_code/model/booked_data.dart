import 'package:capstoneproject/shared_code/model/booked_rooms.dart';

class BookedData {
   List<RatingLabels>? ratingLabels;
  List<BookedRooms>? bookedRooms;

  BookedData({this.ratingLabels, this.bookedRooms});

  BookedData.fromJson(Map<String, dynamic> json) {
    if (json['ratingLabels'] != null) {
      ratingLabels = <RatingLabels>[];
      json['ratingLabels'].forEach((v) {
        ratingLabels!.add(RatingLabels.fromJson(v));
      });
    }
    if (json['bookedRooms'] != null) {
      bookedRooms = <BookedRooms>[];
      json['bookedRooms'].forEach((v) {
        bookedRooms!.add(BookedRooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ratingLabels != null) {
      data['ratingLabels'] = ratingLabels!.map((v) => v.toJson()).toList();
    }
    if (bookedRooms != null) {
      data['bookedRooms'] = bookedRooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RatingLabels {
  String? label;
  List<int>? stars;

  RatingLabels({this.label, this.stars});

  RatingLabels.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    stars = json['stars'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['stars'] = stars;
    return data;
  }
}