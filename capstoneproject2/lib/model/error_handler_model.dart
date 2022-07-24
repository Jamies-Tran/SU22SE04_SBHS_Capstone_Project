// object để nhận lỗi trả về từ server
class ErrorHandlerModel {
  String status;
  int statusCode;
  String issuedAt;
  String message;
  String description;

  ErrorHandlerModel({
    this.status = "",
    this.statusCode = 0,
    this.issuedAt = "",
    this.message = "",
    this.description = ""
  });

  factory ErrorHandlerModel.fromJson(Map<String, dynamic> json) => ErrorHandlerModel(
    status: json["status"],
    statusCode: json["statusCode"],
    issuedAt: json["issuedAt"],
    message: json["message"],
    description: json["description"]
  );

}