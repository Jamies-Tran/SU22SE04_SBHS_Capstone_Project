import 'dart:convert';

import 'package:capstoneproject2/services/api_url_provider/api_url_provider.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/model/homestay_model.dart';

import '../services/homestay_service.dart';
import 'package:http/http.dart' as http;

class HomestayServiceImpl extends IHomestayService {
  final homestayAvailableListUrl = "$HOMESTAY_API_URL/permit-all/available-list";

  final homestayAvailableByLocationListUrl = "$HOMESTAY_API_URL/permit-all/list";

  final homestayDetailsUrl = "$HOMESTAY_API_URL/permit-all/details";

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

}