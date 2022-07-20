import 'package:capstoneproject/api/app_client.dart';
import 'package:dio/dio.dart';

class RoomService {
  final String tagRoomDetail = "/room/";

  Future<Response> fetchRoom(String id) {
    return AppClient.instance.dio.get(tagRoomDetail + id);
  }
}
