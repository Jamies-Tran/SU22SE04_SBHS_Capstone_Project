class CompleteGoogleRegisterState {
  CompleteGoogleRegisterState(
      {this.username,
      this.email,
      this.phone,
      this.address,
      this.citizenIdentification,
      this.gender,
      this.dob,
      this.avatarUrl});

  String? username;
  String? email;
  String? phone;
  String? address;
  String? citizenIdentification;
  String? gender;
  String? avatarUrl;
  String? dob;

  String? validateUsername() {
    if (username == null || username == "") {
      return "Enter username";
    }

    return null;
  }

  String? validateEmail() {
    if (email == null || email == "") {
      return "Enter email";
    }

    return null;
  }

  String? validatePhone() {
    if (phone == null || phone == "") {
      return "Enter phone";
    }

    return null;
  }

  String? validateAddress() {
    if (address == null || address == "") {
      return "Enter address";
    }

    return null;
  }

  String? validateCitizenIdentification() {
    if (citizenIdentification == null || citizenIdentification == "") {
      return "Enter citizen identification";
    }

    return null;
  }

  String? validateDob() {
    if (dob == null || dob == "") {
      return "Enter your birthday";
    }

    return null;
  }
}
