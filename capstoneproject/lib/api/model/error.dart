class Error {
  int? _code;
  String? _message;

  Error({int? code, String? message}) {
    if (code != null) {
      this._code = code;
    }
    if (message != null) {
      this._message = message;
    }
  }

  int? get code => _code;
  set code(int? code) => _code = code;
  String? get message => _message;
  set message(String? message) => _message = message;

  Error.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['message'] = this._message;
    return data;
  }
}
