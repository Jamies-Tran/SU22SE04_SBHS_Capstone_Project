class WalletModel {
  int? balance;
  String? owner;

  WalletModel({this.balance, this.owner});

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
    balance: json["balance"],
    owner: json["owner"]
  );
}