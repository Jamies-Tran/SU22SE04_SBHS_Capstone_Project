/// success : true
/// data : [{"id":"MALE","value":"Nam"},{"id":"FEMALE","value":"Nữ"},{"id":"OTHER","value":"Khác"}]
/// error : null

class GenderResponse {
  bool? _success;
  List<Gender>? _data;
  dynamic? _error;

  bool? get success => _success;
  List<Gender>? get data => _data;
  dynamic? get error => _error;

  GenderResponse({
      bool? success, 
      List<Gender>? data,
      dynamic? error}){
    _success = success;
    _data = data;
    _error = error;
}

  GenderResponse.fromJson(dynamic json) {
    _success = json["success"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data?.add(Gender.fromJson(v));
      });
    }
    _error = json["error"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    if (_data != null) {
      map["data"] = _data?.map((v) => v.toJson()).toList();
    }
    map["error"] = _error;
    return map;
  }

}

/// id : "MALE"
/// value : "Nam"

class Gender {
  String? _id;
  String? _value;

  String? get id => _id;
  String? get value => _value;

  Gender({
      String? id, 
      String? value}){
    _id = id;
    _value = value;
}

  Gender.fromJson(dynamic json) {
    _id = json["id"];
    _value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["value"] = _value;
    return map;
  }

}