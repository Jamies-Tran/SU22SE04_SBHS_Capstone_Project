/// success : false
/// data : null
/// error : "Phone number has already been taken"

class DataResponse {
  bool? _success;
  dynamic? _data;
  String? _error;

  bool? get success => _success;
  dynamic? get data => _data;
  String? get error => _error;

  DataResponse({
      bool? success, 
      dynamic? data, 
      String? error}){
    _success = success;
    _data = data;
    _error = error;
}

  DataResponse.fromJson(dynamic json) {
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