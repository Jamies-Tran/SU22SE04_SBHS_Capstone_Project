import 'package:capstoneproject/base/base_event.dart';

class UnknownErrorEvent extends BaseEvent {
  UnknownErrorEvent({required this.message});

  final String message;
}
