abstract class RegisterEvent {}

class InputUsernameEvent extends RegisterEvent {
  InputUsernameEvent({this.username});

  String? username;
}

class InputPasswordEvent extends RegisterEvent {
  InputPasswordEvent({this.password});

  String? password;
}

class InputEmailEvent extends RegisterEvent {
  InputEmailEvent({this.email});

  String? email;
}

class InputAddressEvent extends RegisterEvent {
  InputAddressEvent({this.address});

  String? address;
}

class InputPhoneEvent extends RegisterEvent {
  InputPhoneEvent({this.phone});

  String? phone;
}

class InputGenderEvent extends RegisterEvent {
  InputGenderEvent({this.gender});

  String? gender;
}

class InputCitizenIdentificationEvent extends RegisterEvent {
  InputCitizenIdentificationEvent({this.citizenIdentification});

  String? citizenIdentification;
}

class InputDobEvent extends RegisterEvent {
  InputDobEvent({this.dob});

  String? dob;
}

class InputAvatarUrlEvent extends RegisterEvent {
  InputAvatarUrlEvent({this.avatarUrl});

  String? avatarUrl;
}

class SubmitRegisterAccountEvent extends RegisterEvent {
  SubmitRegisterAccountEvent(
      {this.username,
      this.password,
      this.email,
      this.address,
      this.phone,
      this.gender,
      this.citizenIdentification,
      this.dob,
      this.avatarUrl});

  String? username;
  String? password;
  String? email;
  String? address;
  String? phone;
  String? gender;
  String? citizenIdentification;
  String? dob;
  String? avatarUrl;
}
