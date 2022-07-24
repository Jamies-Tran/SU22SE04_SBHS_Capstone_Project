class Authority {
  String authority;

  Authority({this.authority = ""});

  factory Authority.fromJson(Map<String, dynamic> json) => Authority(
    authority: json['authority']
  );
}

class AuthenticateModel {
  String userInfo;
  String password;
  String loginDate;
  String jwtToken;
  List<dynamic> roles;


  AuthenticateModel({
    this.userInfo = "",
    this.password = "",
    this.loginDate = "",
    this.jwtToken = "",
    this.roles = const []
  });

  factory AuthenticateModel.fromJson(Map<String, dynamic> json) => AuthenticateModel(
    userInfo: json["userInfo"],
    password: "",
    loginDate: json["loginDate"],
    jwtToken: json["token"],
    roles: json["roles"]
  );

  Map<String, dynamic> toJson() => {
    "userInfo" : userInfo,
    "password" : password
  };
}