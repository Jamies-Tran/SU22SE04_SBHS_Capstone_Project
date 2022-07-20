class Favorite {
  int? id;
  List<String>? images;

  Favorite({this.id, this.images});

  Favorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['images'] = images;
    return data;
  }
}
