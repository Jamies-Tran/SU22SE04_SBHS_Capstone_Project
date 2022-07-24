import 'package:capstoneproject2/model/auth_model.dart';

const baseUserUrl = "http://10.0.2.2:8080/api/user";

abstract class IAuthenticateService {
  Future<dynamic> login(AuthenticateModel authenticateModel);
}