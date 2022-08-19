

class HomestayImageModel {
  dynamic id;
  dynamic url;

  HomestayImageModel({this.id, this.url});

  factory HomestayImageModel.fromJson(Map<String, dynamic> json) => HomestayImageModel(
    id: json["id"],
    url: json["url"]
  );

}

class HomestayServiceModel {
  dynamic id;
  dynamic name;
  int? price;

  HomestayServiceModel({this.id, this.name, this.price});

  factory HomestayServiceModel.fromJson(Map<String, dynamic> json) => HomestayServiceModel(
    id: json["id"],
    name: json["name"],
    price: json["price"]
  );

  Map<String, dynamic> toJson() => {
    "name" : name,
    "price" : price
  };
}

class HomestayCommonFacilityModel {
  dynamic id;
  dynamic name;
  dynamic amount;

  HomestayCommonFacilityModel({this.id, this.name, this.amount});

  factory HomestayCommonFacilityModel.fromJson(Map<String, dynamic> json) => HomestayCommonFacilityModel(
    id: json["id"],
    name: json["name"],
    amount: json["amount"]
  );
}

class HomestayAdditionalFacilityModel {
  dynamic id;
  dynamic name;
  dynamic amount;

  HomestayAdditionalFacilityModel({this.id, this.name, this.amount});

  factory HomestayAdditionalFacilityModel.fromJson(Map<String, dynamic> json) => HomestayAdditionalFacilityModel(
    id: json["Id"],
    name: json["name"],
    amount: json["amount"]
  );
}

class HomestayPriceListModel {
  dynamic id;
  dynamic price;
  dynamic type;
  SpecialDayPriceListModel? specialDayPriceList;

  HomestayPriceListModel({this.id, this.price, this.type, this.specialDayPriceList});

  factory HomestayPriceListModel.fromJson(Map<String, dynamic> json) => HomestayPriceListModel(
    id: json["Id"],
    price: json["price"],
    type: json["type"],
    specialDayPriceList: SpecialDayPriceListModel.fromJson(json["specialDayList"])
  );
}

class SpecialDayPriceListModel {
  dynamic startDay;
  dynamic endDay;
  dynamic startMonth;
  dynamic endMonth;
  dynamic specialDayCode;
  dynamic description;

  SpecialDayPriceListModel({this.startDay, this.startMonth, this.endDay, this.endMonth, this.description, this.specialDayCode});

  factory SpecialDayPriceListModel.fromJson(Map<String, dynamic>? json) => SpecialDayPriceListModel(
    startDay: json?["startDay"],
    startMonth: json?["startMonth"],
    endDay: json?["endDay"],
    endMonth: json?["endMonth"],
    description: json?["description"],
    specialDayCode: json?["specialDayCode"]
  );
}

class HomestayModel {
  dynamic id;
  dynamic name;
  dynamic description;
  dynamic owner;
  dynamic address;
  dynamic numberOfRoom;
  dynamic city;
  dynamic checkInTime;
  dynamic checkOutTime;
  dynamic convenientPoint;
  dynamic securityPoint;
  dynamic positionPoint;
  dynamic averagePoint;
  dynamic numberOfFinishedBooking;
  List<HomestayImageModel> homestayImages;
  List<HomestayServiceModel> homestayServices;
  List<HomestayCommonFacilityModel> homestayCommonFacilities;
  List<HomestayAdditionalFacilityModel> homestayAdditionalFacilities;
  List<HomestayPriceListModel> homestayPriceLists;

  HomestayModel({
    this.id, 
    this.name,
    this.description,
    this.owner,
    this.address, 
    this.city,
    this.numberOfRoom,
    this.checkInTime,
    this.checkOutTime,
    this.convenientPoint,
    this.securityPoint,
    this.positionPoint,
    this.averagePoint,
    this.numberOfFinishedBooking,
    this.homestayCommonFacilities = const [],
    this.homestayAdditionalFacilities = const [],
    this.homestayImages = const [],
    this.homestayServices = const [],
    this.homestayPriceLists = const []
  });

  factory HomestayModel.fromJson(Map<String, dynamic> json) => HomestayModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    owner: json["owner"],
    numberOfRoom: json["numberOfRoom"],
    checkInTime: json["checkInTime"],
    checkOutTime: json["checkOutTime"],
    address: json["address"],
    city: json["city"],
    convenientPoint: json["convenientPoint"],
    securityPoint: json["securityPoint"],
    positionPoint: json["positionPoint"],
    averagePoint: json["average"],
    numberOfFinishedBooking: json["numberOfFinishedBooking"],
      homestayCommonFacilities: List<HomestayCommonFacilityModel>.from(json["homestayCommonFacilities"].map((element) => HomestayCommonFacilityModel.fromJson(element))),
    homestayImages: List<HomestayImageModel>.from(json["homestayImages"].map((element) => HomestayImageModel.fromJson(element))),
    homestayServices: List<HomestayServiceModel>.from(json["homestayServices"].map((element) => HomestayServiceModel.fromJson(element))),
    homestayAdditionalFacilities: List<HomestayAdditionalFacilityModel>.from(json["homestayAdditionalFacilities"].map((element) => HomestayAdditionalFacilityModel.fromJson(element))),
    homestayPriceLists: List<HomestayPriceListModel>.from(json["homestayPriceList"].map((element) => HomestayPriceListModel.fromJson(element))),

  );
}