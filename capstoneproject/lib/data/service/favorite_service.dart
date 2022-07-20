import 'package:capstoneproject/api/app_client.dart';
import 'package:dio/dio.dart';

class FavoriteService {

  final String tagGetCountLiked = "/user/wishlists/ids";
  final String tagGetList = "/user/wishlists";
  final String tagPutFavorite = "/user/add-to-favoritelists/";
  final String tagPutToRemoveFavorite = "/user/remove-from-favoritelists/";

  Future<Response> fetchFavoritedCount() {
    print("COK: ${AppClientCookie.instance.dio.options.headers['Cookie']}");

    return AppClientCookie.instance.dio.get(
        tagGetCountLiked);
  }

  Future<Response> fetchFavoritedList() {
    return AppClientCookie.instance.dio.get(
        tagGetList);
  }

  Future<Response> pushFavoritedItem(String id) {
    return AppClientCookie.instance.dio.put(
        tagPutFavorite + id);
  }

  Future<Response> removeFavoritedItem(String id) {
    return AppClientCookie.instance.dio.put(
        tagPutToRemoveFavorite + id);
  }
  
}
