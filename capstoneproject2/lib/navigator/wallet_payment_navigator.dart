import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/screens/profile/wallet_screen.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/model/payment_model.dart';
import 'package:capstoneproject2/services/wallet_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WalletPaymentNavigator extends StatelessWidget {
  const WalletPaymentNavigator({
    Key? key,
    this.paymentRequestModel
  }) : super(key: key);
  final PaymentRequestModel? paymentRequestModel;

  @override
  Widget build(BuildContext context) {

    final walletService = locator<IWalletService>();

    return Scaffold(
      body: FutureBuilder(
        future: walletService.momoPayment(paymentRequestModel!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitComponent();
          } else if(snapshot.hasData) {
            final paymentData = snapshot.data;
            if(paymentData is PaymentResponseModel) {
              launchUrl(Uri.parse(paymentData.payUrl!), mode: LaunchMode.externalNonBrowserApplication).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WalletManagementScreen())));
            } else if(paymentData is ErrorHandlerModel) {
              return Center(
                child: Text("Can't connect to server due to ${paymentData.description}."),
              );
            }
          } else if(snapshot.hasError) {
            return Center(
              child: Text("Can't connect to server due to ${snapshot.error}."),
            );
          }
          return const Center(
            child: Text("Can't connect to server."),
          );
        },
      ),
    );
  }
}
