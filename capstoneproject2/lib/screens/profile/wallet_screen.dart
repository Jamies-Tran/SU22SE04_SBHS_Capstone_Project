import 'package:capstoneproject2/components/dialog_component.dart';
import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/screens/home_page/home_page_screen.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/model/wallet_model.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WalletManagementScreen extends StatefulWidget {
  const WalletManagementScreen({Key? key}) : super(key: key);

  @override
  State<WalletManagementScreen> createState() => _WalletManagementScreenState();
}

class _WalletManagementScreenState extends State<WalletManagementScreen> {
  final passengerService = locator.get<IPassengerService>();
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your wallet"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: passengerService.getUserWallet(firebaseAuth.currentUser!.displayName!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return SpinKitComponent();
          } else if(snapshot.hasData) {
            final snapshotData = snapshot.data;
            if(snapshotData is WalletModel) {
              return Center(child: Text("${snapshotData.balance}"),);
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
