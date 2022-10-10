import 'package:geolocator/geolocator.dart';

abstract class IGeometryService {
  Future<Position> getCurrentLocation();

  Future<String> getLocationPosition(String location);
}