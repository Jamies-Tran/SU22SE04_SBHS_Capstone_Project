import 'dart:convert';
import 'package:capstoneproject2/services/api_url_provider/api_url_provider.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_auth_service.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_clound_firestore_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/auth_model.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/model/rating_model.dart';
import 'package:capstoneproject2/services/rating_service.dart';
import 'package:http/http.dart' as http;

class RatingServiceImpl extends IRatingService {
  final ratingUrl = RATING_API_URL;
  final firebaseUserService = locator.get<ICloudFirestoreService>();
  final firebaseAuthService = locator.get<IFirebaseAuthenticateService>();

  @override
  Future ratingHomestay(String? username, RatingModel ratingModel) async {
   final user = await firebaseUserService.findUserFireStore(username!);
   if(user is AuthenticateModel) {
     final client = http.Client();
     final url = Uri.parse(ratingUrl);
     final response = await client.patch(
       url,
       headers: {"content-type" : "application/json", "Authorization" : "Bearer ${user.accessToken}"},
       body: json.encode(ratingModel.toJson())
     );
     if(response.statusCode == 200) {
       final ratingModelJson = json.decode(response.body);
       final ratingModel = RatingModel.fromJson(ratingModelJson);
       return ratingModel;
     } else {
       if(response.statusCode == 403) {
         await firebaseAuthService.forgetGoogleSignIn(username);
       }
       final errorHandlerModelJson = json.decode(response.body);
       final errorHandlerModel = ErrorHandlerModel.fromJson(errorHandlerModelJson);
       return errorHandlerModel;
     }
   }
  }

}