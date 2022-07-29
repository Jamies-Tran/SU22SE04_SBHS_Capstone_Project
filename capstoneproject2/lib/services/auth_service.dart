import 'package:capstoneproject2/services/model/auth_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class IAuthenticateService {
  Future<dynamic> loginBySwmAccount(AuthenticateModel authenticateModel);

  Future<dynamic> loginByGoogleAccount(GoogleSignInAccount? googleSignInAccount);
}