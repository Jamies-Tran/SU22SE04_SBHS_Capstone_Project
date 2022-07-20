import 'package:capstoneproject/api/app_client.dart';
import 'package:capstoneproject/hive/hive_service.dart';
import 'package:capstoneproject/injection/injection.dart';
import 'package:dio/dio.dart';

class HomeService {
  final String tagCategory = "/categories";
  final String tagRoom = "/rooms?categoryId=";
  final String tagGetCountLiked = "/user/wishlists/ids";

  Future<Response> fetchCategoryList() {
    print("COK: ${AppClientCookie.instance.dio.options.headers['Cookie']}");
    return AppClientCookie.instance.dio.get(tagCategory);
  }

  Future<Response> fetchRoomList(String id) {
    print("COK: ${AppClientCookie.instance.dio.options.headers['Cookie']}");
    return AppClientCookie.instance.dio.get(tagRoom + id);
  }

  Future<Response> fetchFavoriteIdList() {
    print("COK: ${AppClientCookie.instance.dio.options.headers['Cookie']}");
    print("COK1: ${getIt<HiveService>().token}");
    AppClientCookie.instance.dio.options.headers['Cookie'] = getIt<HiveService>().token;
    print("COK: ${AppClientCookie.instance.dio.options.headers['Cookie']}");

    return AppClientCookie.instance.dio.get(tagGetCountLiked);
  }
}
