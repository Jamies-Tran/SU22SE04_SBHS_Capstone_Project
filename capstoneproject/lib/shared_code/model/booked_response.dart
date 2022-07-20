import 'package:capstoneproject/shared_code/model/booked.dart';

class BookedResponse {
  final bool success;
  final Booked? data;
  final String? error;

  BookedResponse(
    this.data,
    this.error,
    this.success,
  );

  BookedResponse.fromJson(dynamic json)
      : success = json['success'],
        data = Booked.fromJson(json['data']),
        error = json['error'] ?? "";
  BookedResponse.withError(this.error)
      : success = false,
        data = null;
}