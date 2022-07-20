import 'package:capstoneproject/api/app_client.dart';
import 'package:dio/dio.dart';

class SearchService {

  Future<Response> getAllResultSearch(String query, int idCategory) {
    return AppClient.instance.dio.get("/rooms?categoryId=$idCategory&query=$query");
  }
}
