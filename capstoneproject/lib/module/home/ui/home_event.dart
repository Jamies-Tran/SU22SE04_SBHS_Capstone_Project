import 'package:capstoneproject/base/base_event.dart';
import 'package:capstoneproject/shared_code/model/room_model.dart';

class GetRoomEvent extends BaseEvent {
  List<RoomModel> listRoom = [];
  GetRoomEvent(this.listRoom);
}
