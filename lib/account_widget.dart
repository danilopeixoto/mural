import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  final String name;
  final String image;

  AccountWidget(this.name, this.image);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Container(
                  width: 100.0,
                  height: 100.0,
                  margin: EdgeInsets.only(bottom: 5.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill, image: NetworkImage(image)))),
              Text(name, textScaleFactor: 1.5)
            ])));
  }
}