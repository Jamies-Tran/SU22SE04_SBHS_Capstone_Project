import 'package:capstoneproject2/services/model/homestay_model.dart';

class BookingModel {
  dynamic id;
  dynamic passengerName;
  dynamic passengerPhone;
  dynamic passengerEmail;
  dynamic homestayName;
  dynamic homestayLocation;
  dynamic homestayCity;
  dynamic homestayOwner;
  dynamic homestayOwnerPhone;
  dynamic homestayOwnerEmail;
  List<HomestayServiceModel> homestayServiceList;
  dynamic checkIn;
  dynamic checkOut;
  int? totalPrice;
  int? deposit;
  double? homestayAverageRating;
  dynamic status;
  dynamic bookingOtp;

  BookingModel({
    this.id,
    this.passengerName,
    this.passengerPhone,
    this.passengerEmail,
    this.homestayName,
    this.homestayLocation,
    this.homestayCity,
    this.homestayOwner,
    this.homestayOwnerPhone,
    this.homestayOwnerEmail,
    this.homestayAverageRating,
    this.homestayServiceList = const [],
    this.checkIn,
    this.checkOut,
    this.totalPrice,
    this.deposit,
    this.status,
    this.bookingOtp
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    id: json["id"],
    passengerName: json["passengerName"],
    homestayName: json["homestayName"],
    homestayLocation: json["homestayLocation"],
    homestayCity: json["homestayCity"],
    homestayAverageRating: json["homestayAverageRating"],
    homestayOwner: json["homestayOwner"],
    homestayOwnerPhone: json["homestayOwnerPhone"],
    homestayOwnerEmail: json["homestayOwnerEmail"],
    passengerPhone: json["passengerPhone"],
    passengerEmail: json["passengerEmail"],
    homestayServiceList: List.from(json["homestayServiceList"].map((element) => HomestayServiceModel.fromJson(element))),
    checkIn: json["checkIn"],
    checkOut: json["checkOut"],
    totalPrice: json["totalPrice"],
    deposit: json["deposit"],
    status: json["status"],
    bookingOtp: json["bookingOtp"]
  );

  Map<String, dynamic> toJson() => {
    "passengerName" : passengerName,
    "passengerEmail" : passengerEmail,
    "homestayName" : homestayName,
    "homestayOwner" : homestayOwner,
    "homestayLocation" : homestayLocation,
    "homestayServiceList" : List.from(homestayServiceList.map((e) => e.toJson())),
    "totalPrice" : totalPrice,
    "deposit" : deposit,
    "checkIn" : checkIn,
    "checkOut" : checkOut,
  };
}