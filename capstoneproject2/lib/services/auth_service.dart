import 'package:capstoneproject2/model/auth_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

const baseUserUrl = "http://10.0.2.2:8080/api/user";

abstract class IAuthenticateService {
  Future<dynamic> loginBySwmAccount(AuthenticateModel authenticateModel);

  Future<dynamic> loginByGoogleAccount(GoogleSignInAccount? googleSignInAccount);
}