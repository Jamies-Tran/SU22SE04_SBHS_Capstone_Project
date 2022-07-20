import 'package:capstoneproject/base/base_event.dart';

class FavoriteAddEvent extends BaseEvent {
  final String id;

  FavoriteAddEvent({required this.id});
}

//state
class FavoriteAddSuccess extends BaseEvent {}

class FavoriteAddError extends BaseEvent {
  final String message;

  FavoriteAddError(this.message);
}
