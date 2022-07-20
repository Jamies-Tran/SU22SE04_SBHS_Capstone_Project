class UserSend {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? password;
  String? sex;
  String? birthday;

  UserSend(
      {this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.password,
      this.sex,
      this.birthday});

  UserSend.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    password = json['password'];
    sex = json['sex'];
    birthday = json['birthday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['password'] = password;
    data['sex'] = sex;
    data['birthday'] = birthday;
    return data;
  }
}
