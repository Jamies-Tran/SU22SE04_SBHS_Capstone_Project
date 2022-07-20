import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@singleton
class HiveService {
  final Box box;
  HiveService() : box = Hive.box('settings');

  String get token => box.get('token', defaultValue: '');

  void updateToken(String value) => box.put('token', value);

  String get avatar => box.get('avatar', defaultValue: '');

  void updateAvatar(String avatar) => box.put('avatar', avatar);

  void updateShowSelection(bool value) => box.put('showSelectionPage',value);

  bool showSelectionPage() => box.get('showSelectionPage', defaultValue: false);

  void clearToken() => box.delete('token');
}
