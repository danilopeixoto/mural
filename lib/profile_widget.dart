import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_service.dart';
import 'dialog_widget.dart';
import 'account_widget.dart';
import 'about_widget.dart';
import 'license_widget.dart';

class ProfileWidget extends StatelessWidget {
  final AuthenticationService authentication = AuthenticationService.instance;
  final FirebaseUser _user;

  ProfileWidget(this._user);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 0),
          child: ListView(physics: NeverScrollableScrollPhysics(), shrinkWrap: true, children: <Widget>[
          AccountWidget(_user.displayName, _user.photoUrl),
          Divider(height: 0),
          Ink(
            color: Theme.of(context).backgroundColor,
            child: ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Sobre'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AboutWidget()),
                  );
                })),
          Divider(height: 0),
          Ink(
            color: Theme.of(context).backgroundColor,
            child: ListTile(
                leading: Icon(OMIcons.description),
                title: Text('Licença'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LicenseWidget()),
                  );
                })),
          Divider(height: 0),
          Divider(height: 10, color: Colors.transparent),
          Divider(height: 0),
          Ink(
            color: Theme.of(context).backgroundColor,
            child: ListTile(title: Center(child: Text('Sair')),
             onTap: () => authentication.signOut())),
          Divider(height: 0),
          Ink(
            color: Theme.of(context).backgroundColor,
            child: ListTile(
                title: Center(
                    child: Text('Apagar Conta',
                        style: TextStyle(color: Theme.of(context).primaryColor))),
                onTap: () async {
                  ConfirmationAction result = await DialogWidget.confirmation(
                    context,
                    "Você tem certeza que deseja apagar sua conta?",
                    "Todos os seus dados serão excluídos permanentemente.",
                    "Cancelar",
                    "Apagar");

                  if (result == ConfirmationAction.ACCEPT)
                    authentication.deleteAccount();
                }
            )
          ),
          Divider(height: 0)
        ]),
        ),
      ),
    );
  }
}