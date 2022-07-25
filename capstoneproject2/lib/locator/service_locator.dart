import 'package:capstoneproject2/services/auth_service.dart';
import 'package:capstoneproject2/services/firebase_auth_service.dart';
import 'package:capstoneproject2/services_impl/auth_service_impl.dart';
import 'package:capstoneproject2/services_impl/firebase_auth_service_impl.dart';
import 'package:capstoneproject2/services_impl/passenger_service_impl.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
void setup() {
  locator.registerLazySingleton<IPassengerService>(() => PassengerServiceImpl());
  locator.registerLazySingleton<IAuthenticateService>(() => AuthenticateServiceImpl());
  locator.registerLazySingleton<IFirebaseAuthService>(() => FirebaseAuthServiceImpl());
}