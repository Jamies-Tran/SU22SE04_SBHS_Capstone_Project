import 'package:capstoneproject/base/base_event.dart';

class NoDataShowEvent extends BaseEvent {
  NoDataShowEvent({this.message = ''});

  final String message;
}
