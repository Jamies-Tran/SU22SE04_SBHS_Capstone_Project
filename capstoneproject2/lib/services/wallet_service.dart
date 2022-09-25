import 'package:capstoneproject2/services/model/payment_model.dart';

abstract class IWalletService {
  Future<dynamic> momoPayment(PaymentRequestModel paymentRequestModel);
}