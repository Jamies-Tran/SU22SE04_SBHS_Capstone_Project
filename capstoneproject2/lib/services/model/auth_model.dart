class AuthenticateModel {
  var username;
  var email;
  var password;
  var loginDate;
  var accessToken;
  var avatarUrl;
  List<dynamic> roles;


  AuthenticateModel({
    this.username = "",
    this.email = "",
    this.password = "",
    this.loginDate = "",
    this.accessToken = "",
    this.avatarUrl = "",
    this.roles = const []
  });

  factory AuthenticateModel.fromJson(Map<String, dynamic> json) => AuthenticateModel(
    username: json["username"],
    email: json["email"],
    loginDate: json["loginDate"],
    accessToken: json["token"],
    roles: json["roles"]
  );

  Map<String, dynamic> toJson() => {
    "userInfo" : email,
    "password" : password
  };
}