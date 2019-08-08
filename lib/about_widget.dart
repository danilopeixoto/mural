import 'package:flutter/material.dart';

class AboutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Sobre'), centerTitle: true),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Image.asset('assets/images/icon.png', width: 100, height: 100),
              Text('Mural', textScaleFactor: 1.5),
              Text('Versão 1.0.0'),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Text(
                      'Mural Unificado para Recados Administrativos Leucotron',
                      textAlign: TextAlign.center))
            ])));
  }
}