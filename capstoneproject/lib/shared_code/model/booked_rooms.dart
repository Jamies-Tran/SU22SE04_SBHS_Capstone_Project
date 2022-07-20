import 'package:capstoneproject/shared_code/model/review_rating.dart';

class BookedRooms  {
  int? bookingId;
  String? bookingDate;
  String? checkinDate;
  String? checkoutDate;
  double? pricePerDay;
  int? numberOfDays;
  double? siteFee;
  int? roomId;
  String? roomThumbnail;
  String? roomName;
  String? hostName;
  String? hostAvatar;
  String? currency;
  String? privacyType;
  String? roomCategory;
  String? priceType;
  String? bookingReview;
  ReviewRating? reviewRating;
  bool? refund;
  bool? complete;

  BookedRooms(
      {this.bookingId,
      this.bookingDate,
      this.checkinDate,
      this.checkoutDate,
      this.pricePerDay,
      this.numberOfDays,
      this.siteFee,
      this.roomId,
      this.roomThumbnail,
      this.roomName,
      this.hostName,
      this.hostAvatar,
      this.currency,
      this.privacyType,
      this.roomCategory,
      this.priceType,
      this.bookingReview,
      this.reviewRating,
      this.refund,
      this.complete});

  BookedRooms.fromJson(Map<String, dynamic> json) {
    bookingId = json['bookingId'];
    bookingDate = json['bookingDate'];
    checkinDate = json['checkinDate'];
    checkoutDate = json['checkoutDate'];
    pricePerDay = json['pricePerDay'];
    numberOfDays = json['numberOfDays'];
    siteFee = json['siteFee'];
    roomId = json['roomId'];
    roomThumbnail = json['roomThumbnail'];
    roomName = json['roomName'];
    hostName = json['hostName'];
    hostAvatar = json['hostAvatar'];
    currency = json['currency'];
    privacyType = json['privacyType'];
    roomCategory = json['roomCategory'];
    priceType = json['priceType'];
    bookingReview = json['bookingReview'];
    reviewRating = json['reviewRating'] != null
        ? ReviewRating.fromJson(json['reviewRating'])
        : null;
    refund = json['refund'];
    complete = json['complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookingId'] = bookingId;
    data['bookingDate'] = bookingDate;
    data['checkinDate'] = checkinDate;
    data['checkoutDate'] = checkoutDate;
    data['pricePerDay'] = pricePerDay;
    data['numberOfDays'] = numberOfDays;
    data['siteFee'] = siteFee;
    data['roomId'] = roomId;
    data['roomThumbnail'] = roomThumbnail;
    data['roomName'] = roomName;
    data['hostName'] = hostName;
    data['hostAvatar'] = hostAvatar;
    data['currency'] = currency;
    data['privacyType'] = privacyType;
    data['roomCategory'] = roomCategory;
    data['priceType'] = priceType;
    data['bookingReview'] = bookingReview;
    if (reviewRating != null) {
      data['reviewRating'] = reviewRating!.toJson();
    }
    data['refund'] = refund;
    data['complete'] = complete;
    return data;
  }
}