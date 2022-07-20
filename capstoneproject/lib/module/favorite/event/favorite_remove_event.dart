import 'package:capstoneproject/base/base_event.dart';

class FavoriteRemoveEvent extends BaseEvent {
  final String id;

  FavoriteRemoveEvent({required this.id});
}

//state
class FavoriteRemoveSuccess extends BaseEvent {}

class FavoriteRemoveError extends BaseEvent {
  final String message;
  FavoriteRemoveError(this.message);
}
