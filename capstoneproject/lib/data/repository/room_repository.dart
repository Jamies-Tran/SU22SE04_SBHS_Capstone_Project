import 'dart:async';

import 'package:capstoneproject/data/service/room_service.dart';
import 'package:capstoneproject/shared_code/model/room_detail.dart';
import 'package:capstoneproject/shared_code/model/room_detail_response.dart';
import 'package:dio/dio.dart';

class RoomRepository {
  final RoomService roomService;

  RoomRepository({required this.roomService});

  // Lấy phòng theo id phòng
  Future<RoomDetail> getRoomById(String id) async {
    var c = Completer<RoomDetail>();

    try {
      final response = await roomService.fetchRoom(id);

      RoomDetail data = RoomDetailResponse.fromJson(response.data).roomDetail;

      c.complete(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        c.completeError("Kết nối bị hết hạn");
      }
      c.completeError(e.toString());
    } catch (ex) {
      c.completeError(ex.toString());
    }

    return c.future;
  }
}