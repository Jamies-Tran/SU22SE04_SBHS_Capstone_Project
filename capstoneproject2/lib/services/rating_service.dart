import 'package:capstoneproject2/services/model/rating_model.dart';

abstract class IRatingService {
  Future<dynamic> ratingHomestay(String? username, RatingModel ratingModel);
}