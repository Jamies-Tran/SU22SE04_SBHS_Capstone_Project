class RatingModel {
  int? id;
  double? convenientPoint;
  double? securityPoint;
  double? positionPoint;
  String? homestayName;

  RatingModel({this.id, this.convenientPoint, this.securityPoint, this.positionPoint, this.homestayName});

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
    id: json["Id"],
    convenientPoint: json["convenientPoint"],
    securityPoint: json["securityPoint"],
    positionPoint: json["positionPoint"],
    homestayName: json["homestayName"]
  );

  Map<String, dynamic> toJson() => {
    "Id" : id,
    "convenientPoint" : convenientPoint,
    "securityPoint" : securityPoint,
    "positionPoint" : positionPoint,
    "homestayName" : homestayName
  };

}