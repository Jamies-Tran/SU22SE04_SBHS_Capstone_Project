import 'package:capstoneproject2/services/auth_service.dart';
import 'package:capstoneproject2/services/booking_service.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_auth_service.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_cloud_storage_service.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_clound_firestore_service.dart';
import 'package:capstoneproject2/services/homestay_service.dart';
import 'package:capstoneproject2/services/rating_service.dart';
import 'package:capstoneproject2/services_impl/auth_service_impl.dart';
import 'package:capstoneproject2/services_impl/booking_service_impl.dart';
import 'package:capstoneproject2/services_impl/firebase_service_impl/firebase_auth_impl.dart';
import 'package:capstoneproject2/services_impl/firebase_service_impl/firebase_cloud_storage.dart';
import 'package:capstoneproject2/services_impl/firebase_service_impl/firesbase_clound_firestore_impl.dart';
import 'package:capstoneproject2/services_impl/homestay_service_impl.dart';
import 'package:capstoneproject2/services_impl/passenger_service_impl.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:capstoneproject2/services_impl/rating_service_impl.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
void setup() {
  locator.registerLazySingleton<IPassengerService>(() => PassengerServiceImpl());
  locator.registerLazySingleton<IAuthenticateService>(() => AuthenticateServiceImpl());
  locator.registerLazySingleton<IFirebaseAuthenticateService>(() => FirebaseAuthServiceImpl());
  locator.registerLazySingleton<ICloudFirestoreService>(() => CloudFireStoreServiceImpl());
  locator.registerLazySingleton<IFirebaseCloudStorage>(() => FirebaseCloudStorageImpl());
  locator.registerLazySingleton<IHomestayService>(() => HomestayServiceImpl());
  locator.registerLazySingleton<IBookingService>(() => BookingServiceImpl());
  locator.registerLazySingleton<IRatingService>(() => RatingServiceImpl());
}