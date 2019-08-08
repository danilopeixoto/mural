import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'authentication_service.dart';
import 'license_widget.dart';

class SignInWidget extends StatelessWidget {
  final AuthenticationService authentication = AuthenticationService.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return Padding(
            padding: orientation == Orientation.portrait
                ? EdgeInsets.all(40)
                : EdgeInsets.symmetric(horizontal: 120, vertical: 20),
            child: Column(
              crossAxisAlignment: orientation == Orientation.portrait
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/icon.png', width: 100, height: 100),
                Text('Bem-vindo ao Mural',
                    textScaleFactor:
                        orientation == Orientation.portrait ? 3.0 : 2.0,
                    style: TextStyle(fontWeight: FontWeight.bold)
                ),
                Spacer(),
                Center(
                    child: Container(
                  width: 320,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                            'Comece a utilizar o Mural com a Conta do Google e mantenha suas tarefas organizadas.',
                            textAlign: TextAlign.center),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(minWidth: double.infinity),
                        child: RaisedButton.icon(
                            color: Theme.of(context).primaryColor,
                            label: Text(
                              'Entrar com a Conta do Google',
                              style: TextStyle(color: Colors.white),
                            ),
                            icon: Icon(FontAwesomeIcons.google,
                                color: Colors.white),
                            onPressed: () => authentication.signIn()
                        ),
                      ),
                    ],
                  ),
                )),
                Spacer(),
                Center(
                  child: FlatButton(
                      child: Text(
                          'Ao entrar você concorda com a Licença do Mural.',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LicenseWidget()),
                        );
                      }),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
