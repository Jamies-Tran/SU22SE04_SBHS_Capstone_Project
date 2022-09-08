class CancelBookingTicketModel {
  int? id;
  bool? firstTimeCancelActive;
  bool? secondTimeCancelActive;
  dynamic activeDate;

  CancelBookingTicketModel({
    this.id,
    this.firstTimeCancelActive,
    this.secondTimeCancelActive,
    this.activeDate,

  });

  factory CancelBookingTicketModel.fromJson(Map<String, dynamic> json) => CancelBookingTicketModel(
    id: json["Id"],
    firstTimeCancelActive: json["firstTimeCancelActive"],
    secondTimeCancelActive: json["secondTimeCancelActive"],
    activeDate: json["activeDate"]
  );

}