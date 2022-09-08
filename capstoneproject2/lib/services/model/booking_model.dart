import 'package:capstoneproject2/services/model/homestay_model.dart';

class BookingModel {
  var id;
  var passengerName;
  var passengerPhone;
  var passengerEmail;
  var homestayName;
  var homestayLocation;
  var homestayCity;
  var homestayOwner;
  var homestayOwnerPhone;
  var homestayOwnerEmail;
  List<HomestayServiceModel> homestayServiceList;
  var checkIn;
  var checkOut;
  int? totalPrice;
  int? deposit;
  var status;
  var bookingOtp;

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