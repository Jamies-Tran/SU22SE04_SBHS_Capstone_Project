import 'package:capstoneproject2/services/firebase_service/firebase_auth_service.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_cloud_storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseCloudStorageImpl extends IFirebaseCloudStorage {
  final homestayCloudStorage = FirebaseStorage.instance;

  @override
  Future<String> getImageDownloadUrl(String name) async {
    final downLoadURL = await homestayCloudStorage.ref("homestay/$name").getDownloadURL();

    return downLoadURL;
  }

  @override
  Future uploadAvatar(String path, String fileName) {
    // TODO: implement uploadAvatar
    throw UnimplementedError();
  }

}