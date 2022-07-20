class RatingLabels  {
  String? label;
  List<int>? stars;

  RatingLabels({this.label, this.stars});

  RatingLabels.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    stars = json['stars'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['stars'] = stars;
    return data;
  }
}