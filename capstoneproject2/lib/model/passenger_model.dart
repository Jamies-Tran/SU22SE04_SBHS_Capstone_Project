class PassengerModel {
  String? username;
  String password;
  String address;
  String gender;
  String email;
  String phone;
  String citizenIdentificationString;
  String dob;
  String avatarUrl;

  PassengerModel({
    this.username = "",
    this.password = "",
    this.address = "",
    this.gender = "",
    this.email = "",
    this.phone = "",
    this.citizenIdentificationString = "",
    this.dob = "",
    this.avatarUrl = ""
  });

  factory PassengerModel.fromJson(Map<String, dynamic> json) => PassengerModel(
    username: json["username"],
    address: json["address"],
    gender: json["gender"],
    email: json["email"],
    phone: json["phone"],
    citizenIdentificationString: json["citizenIdentificationString"],
    dob: json["dob"],
    avatarUrl: json["avatarUrl"]
  );

  Map<String, dynamic> toJson() => {
    "username" : username,
    "password" : password,
    "address" : address,
    "gender" : gender,
    "email" : email,
    "phone" : phone,
    "citizenIdentificationString" : citizenIdentificationString,
    "dob" : dob,
    "avatarUrl" : avatarUrl
  };
}