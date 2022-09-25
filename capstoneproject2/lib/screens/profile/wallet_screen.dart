import 'package:capstoneproject2/components/dialog_component.dart';
import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/navigator/wallet_payment_navigator.dart';
import 'package:capstoneproject2/screens/home_page/home_page_screen.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/model/payment_model.dart';
import 'package:capstoneproject2/services/model/wallet_model.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

const url = "https://test-payment.momo.vn/v2/gateway/pay?t=TU9NTzNJMEgyMDIyMDcwNXw0NmY1ZTIwNi1hMjg5LTQ0NjAtOWM3NC1mYWVhN2U1Zjg4ZDE=";

class WalletManagementScreen extends StatefulWidget {
  const WalletManagementScreen({Key? key}) : super(key: key);

  @override
  State<WalletManagementScreen> createState() => _WalletManagementScreenState();
}

class _WalletManagementScreenState extends State<WalletManagementScreen> {
  final passengerService = locator.get<IPassengerService>();
  final firebaseAuth = FirebaseAuth.instance;
  final currencyFormat = NumberFormat("#,##0");
  final amountEditingController = TextEditingController();
  final globalFormKey = GlobalKey<FormState>();
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      setState(() {

      });
    });
    super.initState();
  }

  @override
  void dispose() {
    amountEditingController.dispose();
   // globalFormKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your wallet"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: passengerService.getUserWallet(firebaseAuth.currentUser!.email!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitComponent();
          } else if(snapshot.hasData) {
            final snapshotData = snapshot.data;
            if(snapshotData is WalletModel) {
              Codec<String, String> stringToBase64 = utf8.fuse(base64);
              String usernameEncoded = stringToBase64.encode("{\"username\":\"${firebaseAuth.currentUser!.displayName}\"}");
              return RefreshIndicator(
                  onRefresh: () => Future.delayed(const Duration(seconds: 0)).then((value) => setState((){})),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 100),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Your Balance".toUpperCase(), style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              )),
                              Container(
                                width: 250,
                                height: 100,
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black38, width: 2.0, style: BorderStyle.solid)
                                ),
                                child: Center(
                                  child: Text(
                                      "${currencyFormat.format(snapshotData.balance)} VND", style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'OpenSans',
                                      letterSpacing: 1.5,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Your Future Pay".toUpperCase(), style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              )),
                              Container(
                                width: 250,
                                height: 100,
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black38, width: 2.0, style: BorderStyle.solid)
                                ),
                                child: Center(
                                  child: Text(
                                      "${currencyFormat.format(snapshotData.futurePay)} VND", style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'OpenSans',
                                      letterSpacing: 1.5,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Your Actual balance".toUpperCase(), style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'OpenSans',
                                  letterSpacing: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              )),
                              Container(
                                width: 250,
                                height: 100,
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black38, width: 2.0, style: BorderStyle.solid)
                                ),
                                child: Center(
                                  child: Text(
                                      "${currencyFormat.format(snapshotData.balance! - snapshotData.futurePay!)} VND", style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'OpenSans',
                                      letterSpacing: 1.5,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 400,
                          height: 100,
                          margin: const EdgeInsets.only(top: 30, left: 25, right: 25),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(context: context, builder: (context) => AlertDialog(
                                    title: const Center(child: Text("Enter booking Otp"),),
                                    content: Form(
                                      key: globalFormKey,
                                      child: TextFormField(
                                        controller: amountEditingController,
                                        validator: (value) {
                                          if(value == null || value == "") {
                                            return "Please fill in transaction amount";
                                          } else if(int.parse(value) < 1000) {
                                            return "invalid transaction amount";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "${currencyFormat.format(1000)} VND"
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.red,
                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                              maximumSize: const Size(120, 56),
                                              minimumSize: const Size(120, 56)
                                          ),
                                          child: Text("cancel".toUpperCase())
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            if(globalFormKey.currentState!.validate()) {
                                              PaymentRequestModel paymentRequestModel = PaymentRequestModel(
                                                  amount: int.parse(amountEditingController.text),
                                                  orderInfo: "passenger_wallet",
                                                  extraData: usernameEncoded
                                              );
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => WalletPaymentNavigator(paymentRequestModel: paymentRequestModel),));
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.green,
                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                              maximumSize: const Size(150, 56),
                                              minimumSize: const Size(150, 56)
                                          ),
                                          child: Text("next".toUpperCase())
                                      )
                                    ],
                                  ),);
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor
                                ),
                                child: Text("Add balance".toUpperCase()),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              );
            } else if(snapshotData is ErrorHandlerModel) {
              return DialogComponent(message: snapshotData.message, eventHandler: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePageScreen(),)),);
            }
          } else if(snapshot.hasError)  {
            return DialogComponent(message: "Error occur ${snapshot.error}", eventHandler: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePageScreen(),)),);
          }

          return Container();
        },
      ),
    );
  }
}
