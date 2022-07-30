import 'dart:convert';

import 'package:capstoneproject2/services/api_url_provider/api_url_provider.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/model/homestay_model.dart';

import '../services/homestay_service.dart';
import 'package:http/http.dart' as http;

class HomestayServiceImpl extends IHomestayService {
  final homestayAvailableListUrl = "$HOMESTAY_API_URL/view/available-all";

  @override
  Future getAvailableHomestay() async {
    var client = http.Client();
    var uri = Uri.parse(homestayAvailableListUrl);
    var response = await client.get(
        uri,
        headers: {"content-type" : "application/json"},
    );
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

}