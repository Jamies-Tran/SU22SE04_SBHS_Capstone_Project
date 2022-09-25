import 'dart:convert';

import 'package:capstoneproject2/services/api_url_provider/api_url_provider.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_auth_service.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_clound_firestore_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/auth_model.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/model/homestay_model.dart';

import '../services/homestay_service.dart';
import 'package:http/http.dart' as http;

class HomestayServiceImpl extends IHomestayService {
  final homestayAvailableListUrl = "$homestayApiUrl/permit-all/available-list";

  final homestayAvailableByLocationListUrl = "$homestayApiUrl/permit-all/list";

  final homestayFilterSearchUrl = "$homestayApiUrl/permit-all/list";

  final homestayDetailsUrl = "$homestayApiUrl/permit-all/details";

  final firebaseCloudFirestore = locator<ICloudFirestoreService>();

  final firebaseAuth = locator<IFirebaseAuthenticateService>();

  @override
  Future getAvailableHomestay() async {
    var client = http.Client();
    var uri = Uri.parse(homestayAvailableListUrl);
    var response = await client.get(
        uri,
        headers: {"content-type" : "application/json"},
    ).timeout(const Duration(seconds: 20));
    if(response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      var homestayList = List<HomestayModel>.from(responseBody.map((element) => HomestayModel.fromJson(element)));
      return homestayList;
    } else {
      var responseBody = json.decode(response.body);
      var errorHandlerModel = ErrorHandlerModel.fromJson(responseBody);
      return errorHandlerModel;
    }
  }

  @override
  Future getAvailableHomestayByLocation(String location) async {
    var client = http.Client();
    var url = Uri.parse("$homestayAvailableByLocationListUrl/$location");
    var response = await client.get(url, headers: {"content-type" : "application/json"});
    var responseBody = json.decode(response.body);
    if(response.statusCode == 200) {
      var homestayModel = List<HomestayModel>.from(responseBody.map((e) => HomestayModel.fromJson(e)));
      return homestayModel;
    } else {
      ErrorHandlerModel errorHandlerModel = ErrorHandlerModel.fromJson(responseBody);
      return errorHandlerModel;
    }
  }

  @override
  Future findHomestayByName(String name) async {
    var client = http.Client();
    var url = Uri.parse("$homestayDetailsUrl/$name");
    var response = await client.get(url, headers: {"content-type" : "application/json"});
    final responseBody = json.decode(response.body);
    if(response.statusCode == 200) {
      final homestayModel = HomestayModel.fromJson(responseBody);
      return homestayModel;
    } else {
      final errorHandlerModel = ErrorHandlerModel.fromJson(responseBody);
      return errorHandlerModel;
    }

  }

  @override
  Future searchHomestayByFilter(HomestayFilterRequestModel homestayFilterRequestModel, int page, int size) async {
    final client = http.Client();
    final url = Uri.parse("$homestayFilterSearchUrl?page=$page&size=$size");
    final response = await client.post(
        url,
        headers: {"content-type" : "application/json"},
        body: json.encode(homestayFilterRequestModel.toJson())
    );
    if(response.statusCode == 200) {
      final homestayFilterResponseJson = json.decode(response.body);
      final homestayFilterResponseModel = HomestayFilterResponseModel.fromJson(homestayFilterResponseJson);
      return homestayFilterResponseModel;
    } else {
      final errorHandlerJson = json.decode(response.body);
      final errHandlerModel = ErrorHandlerModel.fromJson(errorHandlerJson);
      return errHandlerModel;
    }
  }

}