

class HomestayImageModel {
  var id;
  var url;

  HomestayImageModel({this.id, this.url});

  factory HomestayImageModel.fromJson(Map<String, dynamic> json) => HomestayImageModel(
    id: json["id"],
    url: json["url"]
  );

}

class HomestayServiceModel {
  var id;
  var name;
  var price;

  HomestayServiceModel({this.id, this.name, this.price});

  factory HomestayServiceModel.fromJson(Map<String, dynamic> json) => HomestayServiceModel(
    id: json["id"],
    name: json["name"],
    price: json["price"]
  );

}

class HomestayFacilityModel {
  var id;
  var name;
  var amount;

  HomestayFacilityModel({this.id, this.name, this.amount});

  factory HomestayFacilityModel.fromJson(Map<String, dynamic> json) => HomestayFacilityModel(
    id: json["id"],
    name: json["name"],
    amount: json["amount"]
  );
}

class HomestayModel {
  var id;
  var name;
  var address;
  var city;
  var price;
  var convenientPoint;
  var securityPoint;
  var positionPoint;
  var averagePoint;
  var numberOfFinishedBooking;
  List<HomestayImageModel> homestayImages;
  List<HomestayServiceModel> homestayServices;
  List<HomestayFacilityModel> homestayFacilities;

  HomestayModel({
    this.id, 
    this.name, 
    this.address, 
    this.city, 
    this.price,
    this.convenientPoint,
    this.securityPoint,
    this.positionPoint,
    this.averagePoint,
    this.numberOfFinishedBooking,
    this.homestayFacilities = const [],
    this.homestayImages = const [],
    this.homestayServices = const []
  });

  factory HomestayModel.fromJson(Map<String, dynamic> json) => HomestayModel(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    address: json["address"],
    city: json["city"],
    convenientPoint: json["convenientPoint"],
    securityPoint: json["securityPoint"],
    positionPoint: json["positionPoint"],
    averagePoint: json["average"],
    numberOfFinishedBooking: json["numberOfFinishedBooking"],
    homestayFacilities: List<HomestayFacilityModel>.from(json["homestayFacilities"].map((element) => HomestayFacilityModel.fromJson(element))),
    homestayImages: List<HomestayImageModel>.from(json["homestayImages"].map((element) => HomestayImageModel.fromJson(element))),
    homestayServices: List<HomestayServiceModel>.from(json["homestayServices"].map((element) => HomestayServiceModel.fromJson(element)))
  );
}