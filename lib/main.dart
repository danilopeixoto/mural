import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_cupertino_localizations/flutter_cupertino_localizations.dart';
import 'main_widget.dart';

void main() => runApp(MuralApplication());

class MuralApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mural',
        home: MainWidget(),
        theme: ThemeData(
            primaryColor: Colors.redAccent[400],
            backgroundColor: Colors.white),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: [
          Locale('en', 'US'),
          Locale('pt', 'BR')
        ]
    );
  }
}
