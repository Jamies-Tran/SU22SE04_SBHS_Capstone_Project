import 'package:capstoneproject/shared_code/model/favorite_model.dart';

class FavoriteResponseDetail {
  bool? success;
  List<Favorite>? data;
  String? error;

  FavoriteResponseDetail({this.success, this.data, this.error});

  FavoriteResponseDetail.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Favorite>[];
      json['data'].forEach((v) {
        data!.add(Favorite.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = error;
    return data;
  }
}
