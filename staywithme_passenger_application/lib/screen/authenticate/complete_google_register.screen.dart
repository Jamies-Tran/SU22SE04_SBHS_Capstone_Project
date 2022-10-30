import 'package:flutter/material.dart';

class CompleteGoogleRegisterScreen extends StatefulWidget {
  const CompleteGoogleRegisterScreen({super.key});

  static const completeGoogleRegisterRoute = "/complete_google_sign_in";

  @override
  State<CompleteGoogleRegisterScreen> createState() =>
      _CompleteGoogleRegisterScreenState();
}

// TODO: create sign out google account
class _CompleteGoogleRegisterScreenState
    extends State<CompleteGoogleRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complete google register")),
    );
  }
}
