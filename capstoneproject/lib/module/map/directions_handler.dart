// import 'package:capstoneproject/main.dart';
// import 'package:capstoneproject/shared_code/model/room_detail.dart';
// import 'package:capstoneproject/utils/mapbox_requests.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
//
// Future<Map> getDirectionsAPIResponse(LatLng currentLatLng, int index, RoomDetail room) async {
//   final response = await getCyclingRouteUsingMapbox(
//       currentLatLng,
//       LatLng(room.latitude!, room.longitude!));
//   Map geometry = response['routes'][0]['geometry'];
//   num duration = response['routes'][0]['duration'];
//   num distance = response['routes'][0]['distance'];
//   print('-------------------${room.name}-------------------');
//   print(distance);
//   print(duration);
//
//   Map modifiedResponse = {
//     "geometry": geometry,
//     "duration": duration,
//     "distance": distance,
//   };
//   return modifiedResponse;
// }
//
// void saveDirectionsAPIResponse(int index, String response) {
//   sharedPreferences.setString('restaurant--$index', response);
// }
