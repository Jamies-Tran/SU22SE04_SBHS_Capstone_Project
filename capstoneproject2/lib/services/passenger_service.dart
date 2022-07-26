import 'package:google_sign_in/google_sign_in.dart';

import '../model/passenger_model.dart';

const baseUserUrl = "http://10.0.2.2:8080/api/user";

abstract class IPassengerService {
  Future<dynamic> completeGoogleSignUpPassenger(PassengerModel passengerModel, GoogleSignInAccount? googleSignInAccount);

  Future<dynamic> checkEmailExistOnSystem(String? email);

  Future<dynamic> signUpWithSWMAccount(PassengerModel passengerModel);
}