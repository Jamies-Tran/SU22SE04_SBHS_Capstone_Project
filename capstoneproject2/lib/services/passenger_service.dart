import 'package:capstoneproject2/services/model/passenger_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class IPassengerService {
  Future<dynamic> completeGoogleSignUpPassenger(PassengerModel passengerModel, GoogleSignInAccount? googleSignInAccount);

  Future<dynamic> checkEmailExistOnSystem(String? email);

  Future<dynamic> signUpWithSWMAccount(PassengerModel passengerModel);

  Future<dynamic> signUpWithGoogleAccount(PassengerModel passengerModel, GoogleSignInAccount googleSignInAccount);

  Future<dynamic> findUserByUsername(String username);

  Future<dynamic> getUserWallet(String email);
}