class PassengerModel {
  PassengerModel(
      {this.username,
      this.password,
      this.email,
      this.address,
      this.gender,
      this.citizenIdentification,
      this.dob,
      this.avatarUrl});

  String? username;
  String? password;
  String? email;
  String? address;
  String? gender;
  String? citizenIdentification;
  String? dob;
  String? avatarUrl;

  factory PassengerModel.fromJson(Map<String, String> json) => PassengerModel(
      username: json["username"],
      password: json["password"],
      address: json["address"],
      email: json["email"],
      avatarUrl: json["avatarUrl"],
      citizenIdentification: json["citizenIdentification"],
      dob: json["dob"],
      gender: json["gender"]);

  Map<String, String?> toJson() => {
        "username": username,
        "password": password,
      };
}
