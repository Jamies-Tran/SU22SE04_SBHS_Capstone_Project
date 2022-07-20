
import 'package:flutter/material.dart';

class DialogOneButton extends StatelessWidget {
  const DialogOneButton({
    required this.onPressed,
    required this.title,
    required this.content,
    this.textButton = '',
  });

  final VoidCallback onPressed;
  final String title;
  final String content;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.1),
      child: AlertDialog(
        title: Text(title, style: TextStyle(color: Colors.black)),
        content: Text(content, style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child: Text(
              textButton.isEmpty ? 'OK' : textButton.toUpperCase(),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
