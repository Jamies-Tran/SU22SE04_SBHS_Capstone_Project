import 'package:get_it/get_it.dart';
import 'package:staywithme_passenger_application/service/auth_by_google_service.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<IAuthenticateByGoogleService>(
      () => AuthenticateByGoogleService());
}
