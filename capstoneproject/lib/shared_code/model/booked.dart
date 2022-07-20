class Booked {
  int? id;
  String? bookingDate;
  String? currencySymbol;
  double? totalFee;
  int? lastUpdated;

  Booked(
      {this.id,
      this.bookingDate,
      this.currencySymbol,
      this.totalFee,
      this.lastUpdated});

  Booked.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingDate = json['bookingDate'];
    currencySymbol = json['currencySymbol'];
    totalFee = json['totalFee'];
    lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bookingDate'] = bookingDate;
    data['currencySymbol'] = currencySymbol;
    data['totalFee'] = totalFee;
    data['lastUpdated'] = lastUpdated;
    return data;
  }
}