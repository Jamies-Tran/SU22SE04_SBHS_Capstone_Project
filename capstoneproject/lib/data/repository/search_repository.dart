import 'dart:async';

import 'package:capstoneproject/data/service/booking_service.dart';
import 'package:capstoneproject/data/service/search_service.dart';
import 'package:capstoneproject/shared_code/model/booked.dart';
import 'package:capstoneproject/shared_code/model/booked_data.dart';
import 'package:capstoneproject/shared_code/model/booked_response.dart';
import 'package:capstoneproject/shared_code/model/reservation.dart';
import 'package:capstoneproject/shared_code/model/search_model.dart';
import 'package:capstoneproject/shared_code/model/search_response.dart';
import 'package:dio/dio.dart';

class SearchRepository {
  final SearchService searchService;

  SearchRepository({required this.searchService});

  Future<List<SearchModel>> getAllResultSearch(
      String query, int idCategory) async {
    var c = Completer<List<SearchModel>>();

    try {
      final response =
          await searchService.getAllResultSearch(query, idCategory);

      List<SearchModel> data = SearchResponse.fromJson(response.data).data!;

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
