class CancelBookingResponse {
  bool? success;
  String? data;
  String? error;

  CancelBookingResponse({this.success, this.data, this.error});

  CancelBookingResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = this.data;
    data['error'] = error;
    return data;
  }
}
