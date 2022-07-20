import 'package:capstoneproject/base/base_event.dart';

class BookingEvent extends BaseEvent {
  final String idRoom;
  final String checkIn;
  final String checkOut;
  final int numberOfDays;

  BookingEvent(
      {required this.idRoom,
      required this.checkIn,
      required this.checkOut,
      required this.numberOfDays});
}

class CancleBookingEvent extends BaseEvent {
  final String id;

  CancleBookingEvent({required this.id});
}
