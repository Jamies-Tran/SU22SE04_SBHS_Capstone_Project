import 'package:capstoneproject/shared_code/model/user_response.dart';

class UserRegister {
	bool? success;
	Data? data;
	Null? error;

	UserRegister({this.success, this.data, this.error});

	UserRegister.fromJson(Map<String, dynamic> json) {
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
	String? username;
	String? password;
	String? address;
	String? gender;
	String? email;
	String? birthday;
	String? citizenIdentification;
	Role? role;
	String? phoneNumber;
	bool? phoneVerified;
	String? about;
	String? cookie;
	String? avatarPath;
	String? fullPathAddress;
	AddressDetails? addressDetails;
	bool? supremeHost;

	Data({this.id, this.status, this.createdDate, this.updatedDate, this.username, this.gender, this.birthday, this.email, this.password, this.role, this.phoneNumber, this.phoneVerified, this.about, this.cookie, this.avatarPath, this.fullPathAddress, this.addressDetails, this.supremeHost, this.address, this.citizenIdentification});

	Data.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		status = json['status'];
		createdDate = json['createdDate'];
		updatedDate = json['updatedDate'];
		username = json['username'];
		gender = json['gender'];
		birthday = json['birthday'];
		email = json['email'];
		password = json['password'];
		address = json['address'];
		citizenIdentification = json['citizen'];
		role = json['role'] != null ? Role.fromJson(json['role']) : null;
		phoneNumber = json['phoneNumber'];
		phoneVerified = json['phoneVerified'];
		about = json['about'];
		cookie = json['cookie'];
		avatarPath = json['avatarPath'];
		fullPathAddress = json['fullPathAddress'];
		addressDetails = json['addressDetails'] != null ? AddressDetails.fromJson(json['addressDetails']) : null;
		supremeHost = json['supremeHost'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['status'] = status;
		data['createdDate'] = createdDate;
		data['updatedDate'] = updatedDate;
		data['username'] = username;
		data['password'] = password;
		data['address'] = address;
		data['gender'] = gender;
		data['birthday'] = birthday;
		data['email'] = email;
		data['citizen'] = citizenIdentification;
		if (role != null) {
      data['role'] = role!.toJson();
    }
		data['phoneNumber'] = phoneNumber;
		data['phoneVerified'] = phoneVerified;
		data['about'] = about;
		data['cookie'] = cookie;
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