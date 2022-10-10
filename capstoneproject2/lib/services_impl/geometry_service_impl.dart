import 'package:capstoneproject2/services/firebase_service/firebase_clound_firestore_service.dart';
import 'package:capstoneproject2/services/geometry_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


class GeometryServiceImpl implements IGeometryService {
  final firebaseFirestoreService = locator.get<ICloudFirestoreService>();
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Position> getCurrentLocation() async {
    final isServiceEnabled= await Geolocator.isLocationServiceEnabled();
    dynamic permission;
    if(!isServiceEnabled) {
      Future.error("Service not enable");
    }
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        Future.error("no permission granted");
      }
    }

    if(permission == LocationPermission.deniedForever) {
      Future.error("no permission granted");
    }
    final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return pos;
  }

  @override
  Future<String> getLocationPosition(String location) async {
    List<Location> locations = await locationFromAddress(location);
    String latLng = "${locations[0].latitude},${locations[0].longitude}";

    return latLng;
  }

}