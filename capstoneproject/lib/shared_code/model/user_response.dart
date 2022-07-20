class UserResponse {
  bool? success;
  Data? data;
  String? error;

  UserResponse({this.success, this.data, this.error});

  UserResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = error;
    return data;
  }
}

class Data {
  int? id;
  bool? status;
  int? createdDate;
  int? updatedDate;
  String? firstName;
  String? lastName;
  String? sex;
  String? birthday;
  String? email;
  String? password;
  Role? role;
  String? phoneNumber;
  bool? phoneVerified;
  String? about;
  String? cookie;
  String? fullName;
  String? avatarPath;
  String? fullPathAddress;
  AddressDetails? addressDetails;
  bool? supremeHost;

  Data(
      {this.id,
      this.status,
      this.createdDate,
      this.updatedDate,
      this.firstName,
      this.lastName,
      this.sex,
      this.birthday,
      this.email,
      this.password,
      this.role,
      this.phoneNumber,
      this.phoneVerified,
      this.about,
      this.cookie,
      this.fullName,
      this.avatarPath,
      this.fullPathAddress,
      this.addressDetails,
      this.supremeHost});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    sex = json['sex'];
    birthday = json['birthday'];
    email = json['email'];
    password = json['password'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
    phoneNumber = json['phoneNumber'];
    phoneVerified = json['phoneVerified'];
    about = json['about'];
    cookie = json['cookie'];
    fullName = json['fullName'];
    avatarPath = json['avatarPath'];
    fullPathAddress = json['fullPathAddress'];
    addressDetails = json['addressDetails'] != null
        ? AddressDetails.fromJson(json['addressDetails'])
        : null;
    supremeHost = json['supremeHost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['sex'] = sex;
    data['birthday'] = birthday;
    data['email'] = email;
    data['password'] = password;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    data['phoneNumber'] = phoneNumber;
    data['phoneVerified'] = phoneVerified;
    data['about'] = about;
    data['cookie'] = cookie;
    data['fullName'] = fullName;
    data['avatarPath'] = avatarPath;
    data['fullPathAddress'] = fullPathAddress;
    if (addressDetails != null) {
      data['addressDetails'] = addressDetails!.toJson();
    }
    data['supremeHost'] = supremeHost;
    return data;
  }
}

class Role {
  int? id;
  String? name;

  Role({this.id, this.name});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class AddressDetails {
  Role? country;
  Role? state;
  Role? city;
  String? aprtNoAndStreet;

  AddressDetails({this.country, this.state, this.city, this.aprtNoAndStreet});

  AddressDetails.fromJson(Map<String, dynamic> json) {
    country = json['country'] != null ? Role.fromJson(json['country']) : null;
    state = json['state'] != null ? Role.fromJson(json['state']) : null;
    city = json['city'] != null ? Role.fromJson(json['city']) : null;
    aprtNoAndStreet = json['aprtNoAndStreet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (state != null) {
      data['state'] = state!.toJson();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['aprtNoAndStreet'] = aprtNoAndStreet;
    return data;
  }
}
