class WalletModel {
  int? balance;
  int? futurePay;
  String? owner;

  WalletModel({this.balance, this.futurePay, this.owner});

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
    balance: json["balance"],
    futurePay: json["futurePay"],
    owner: json["owner"]
  );
}