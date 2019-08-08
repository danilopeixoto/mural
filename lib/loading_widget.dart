import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitFadingCircle(
        color: Theme.of(context).primaryColor,
        size: 50.0,
      )
    );
  }
}
