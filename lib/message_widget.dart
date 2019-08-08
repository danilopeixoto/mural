import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String message;
  final IconData icon;

  MessageWidget(this.message, this.icon);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Icon(icon, size: 64, color: Colors.grey),
          Text(message,
              textScaleFactor: 1.25, style: TextStyle(color: Colors.grey)),
        ]));
  }
}