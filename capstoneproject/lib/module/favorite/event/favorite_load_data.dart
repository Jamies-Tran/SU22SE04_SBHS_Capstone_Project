import 'package:capstoneproject/base/base_event.dart';
import 'package:capstoneproject/shared_code/model/favorite_model.dart';

class FavoriteLoadData extends BaseEvent {
  final List<Favorite> listFavorite;

  FavoriteLoadData(this.listFavorite);
}
