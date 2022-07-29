abstract class IFirebaseCloudStorage {
  Future<dynamic> uploadAvatar(String path, String fileName);

  Future<String> getImageDownloadUrl(String name);
}