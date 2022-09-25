import 'package:capstoneproject2/services/model/homestay_model.dart';

abstract class IHomestayService {
  Future<dynamic> getAvailableHomestay();

  Future<dynamic> getAvailableHomestayByLocation(String location);

  Future<dynamic> findHomestayByName(String name);

  Future<dynamic> searchHomestayByFilter(HomestayFilterRequestModel homestayFilterRequestModel, int page, int size);
}