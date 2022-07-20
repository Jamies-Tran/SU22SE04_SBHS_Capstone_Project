// class Gender {
//   String? _id;
//   String? _value;
//
//   Gender({String? id, String? value}) {
//     if (id != null) {
//       this._id = id;
//     }
//     if (value != null) {
//       this._value = value;
//     }
//   }
//
//   String? get id => _id;
//   set id(String? id) => _id = id;
//   String? get value => _value;
//   set value(String? value) => _value = value;
//
//   Gender.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _value = json['value'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     data['value'] = this._value;
//     return data;
//   }
// }
