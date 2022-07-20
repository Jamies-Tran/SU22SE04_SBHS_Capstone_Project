/// success : true
/// data : "Phone number has not been used by anyone yet"
/// error : null

class ApiResponse {
  bool? _success;
  String? _data;
  String? _error;

  bool? get success => _success;

  String? get data => _data;

  String? get error => _error;

  ApiResponse({bool? success, String? data, String? error}) {
    _success = success;
    _data = data;
    _error = error;
  }

  ApiResponse.fromJson(dynamic json) {
    _success = json["success"];
    _data = json["data"];
    _error = json["error"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["data"] = _data;
    map["error"] = _error;
    return map;
  }
}
