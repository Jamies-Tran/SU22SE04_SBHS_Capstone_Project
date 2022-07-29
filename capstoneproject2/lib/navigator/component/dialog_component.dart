import 'package:flutter/material.dart';

class DialogComponent extends StatelessWidget {
  const DialogComponent({Key? key, this.message}) : super(key: key);
  final message;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: AlertDialog(
        content: Padding(padding: const EdgeInsets.all(20.0),child: Text(message),),
        title: const Center(child: Text("Error")),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Retry"))
        ],
      ),
    );
  }
}
