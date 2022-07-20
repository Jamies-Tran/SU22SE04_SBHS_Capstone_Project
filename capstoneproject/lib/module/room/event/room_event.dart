import 'package:capstoneproject/base/base_event.dart';
import 'package:capstoneproject/shared_code/model/room_detail.dart';

class GetRoomDetail extends BaseEvent {
  final RoomDetail roomDetail;

  GetRoomDetail(this.roomDetail);
}
