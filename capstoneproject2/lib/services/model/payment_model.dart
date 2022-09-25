class PaymentRequestModel {
  int? amount;
  String? orderInfo;
  String? extraData;

  PaymentRequestModel({this.amount, this.orderInfo, this.extraData});

  Map<String, dynamic> toJson() => {
    "amount" : amount,
    "orderInfo" : orderInfo,
    "extraData" : extraData
  };
}

class PaymentResponseModel {
  String? payUrl;

  PaymentResponseModel({this.payUrl});

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) => PaymentResponseModel(
    payUrl: json["payUrl"]
  );
}