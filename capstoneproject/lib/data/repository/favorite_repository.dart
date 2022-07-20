import 'dart:async';
import 'package:capstoneproject/data/service/favorite_service.dart';
import 'package:capstoneproject/shared_code/model/favorite_model.dart';
import 'package:capstoneproject/shared_code/model/favorite_reponse.dart';
import 'package:capstoneproject/shared_code/model/favorite_response_detail.dart';
import 'package:dio/dio.dart';

class FavoriteRepository {
  final FavoriteService favoriteService;

  FavoriteRepository({required this.favoriteService});

  // Lấy số lượng phòng yêu thích
  Future<List<int>> getFavoriteListId() async {
    var c = Completer<List<int>>();

    try {
      final response = await favoriteService.fetchFavoritedCount();

      List<int> data = response.data;

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

  Future<bool> pushFavoriteListId(String id) async {
    var c = Completer<bool>();

    try {
      final response = await favoriteService.pushFavoritedItem(id);

      bool data = response.data['success']; //response.data;

      print("Data push: ${data}");

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

  Future<bool> removeFavoriteListId(String id) async {
    var c = Completer<bool>();

    try {
      final response = await favoriteService.removeFavoritedItem(id);

      bool data = response.data['success']; //response.data;

      print("Data push: ${data}");

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

  // Lấy các phần tử phòng yêu thích
  Future<List<Favorite>> getFavoriteListItem() async {
    var c = Completer<List<Favorite>>();

    try {
      final response = await favoriteService.fetchFavoritedList();

      List<Favorite>? data = FavoriteResponseDetail.fromJson(response.data).data;

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
