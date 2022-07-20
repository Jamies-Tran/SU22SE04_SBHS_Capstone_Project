import 'package:capstoneproject/shared_code/model/booked_data.dart';

class Reservation {
  bool? success;
  BookedData? data;
  String? error;

  Reservation({this.success, this.data, this.error});

  Reservation.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? BookedData.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = error;
    return data;
  }
}