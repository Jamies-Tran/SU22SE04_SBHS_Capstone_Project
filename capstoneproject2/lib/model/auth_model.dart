class AuthenticateModel {
  var userInfo;
  var password;
  var loginDate;
  var jwtToken;
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