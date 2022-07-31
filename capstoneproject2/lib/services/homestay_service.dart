abstract class IHomestayService {
  Future<dynamic> getAvailableHomestay();

  Future<dynamic> getAvailableHomestayByLocation(String location);
}