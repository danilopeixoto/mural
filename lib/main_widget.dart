import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_service.dart';
import 'loading_widget.dart';
import 'sign_in_widget.dart';
import 'home_widget.dart';

class MainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }
}

class _MainState extends State<MainWidget> {
  final AuthenticationService authentication = AuthenticationService.instance;

  FirebaseUser _user;
  bool _loading = false;

  @override
  initState() {
    super.initState();

    authentication.user.listen((state) => setState(() => _user = state));
    authentication.loading.listen((state) => setState(() => _loading = state));
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _loading ? 0 : 1,
      children: <Widget>[
        LoadingWidget(),
        _user == null ? SignInWidget() : HomeWidget(_user)
      ],
    );
  }
}