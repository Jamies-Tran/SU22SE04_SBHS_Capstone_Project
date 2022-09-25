import 'dart:convert';

import 'package:capstoneproject2/services/api_url_provider/api_url_provider.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/model/payment_model.dart';
import '../services/wallet_service.dart';
import 'package:http/http.dart' as http;

class WalletServiceImpl extends IWalletService {

  final String paymentUrl = paymentApiUrl;

  @override
  Future momoPayment(PaymentRequestModel paymentRequestModel) async {
    final client = http.Client();
    final url = Uri.parse(paymentUrl);
    final response = await client.post(
        url,
        headers: {"content-type" : "application/json"},
        body: json.encode(paymentRequestModel.toJson()),
    );
    if(response.statusCode == 201) {
      final paymentResponseJson = json.decode(response.body);
      final paymentResponse = PaymentResponseModel.fromJson(paymentResponseJson);
      return paymentResponse;
    } else {
      final errorHandlerJson = json.decode(response.body);
      final errorHandlerModel = ErrorHandlerModel.fromJson(errorHandlerJson);
      return errorHandlerModel;
    }
  }

}