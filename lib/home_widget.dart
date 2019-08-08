import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'card_data.dart';
import 'card_form_widget.dart';
import 'cards_widget.dart';
import 'profile_widget.dart';

class HomeWidget extends StatefulWidget {
  final FirebaseUser _user;

  HomeWidget(this._user);

  @override
  State<StatefulWidget> createState() {
    return _HomeState(_user);
  }
}

class _HomeState extends State<HomeWidget> {
  final Firestore _database = Firestore.instance;

  FirebaseUser _user;
  int _currentIndex = 0;

  final List<String> _tabLabels = ['Cartões', 'Perfil'];

  _HomeState(this._user);

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [CardsWidget(_user), ProfileWidget(_user)];

    return Scaffold(
      appBar: AppBar(
          title: Text(_tabLabels[_currentIndex]),
          centerTitle: true,
          actions: _currentIndex == 0
              ? <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () async {
                      CardData result  = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                            CardFormWidget(_user.displayName, null))
                      );
                      
                      if (result != null) {
                        var data = result.toData();

                        CollectionReference collection = _database.collection('cards');
                        collection.add(data);
                      }
                    },
                  )
                ]
              : <Widget>[]),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        selectedFontSize: 12.0,
        backgroundColor: Theme.of(context).backgroundColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(OMIcons.featuredPlayList), title: Text(_tabLabels[0])),
          BottomNavigationBarItem(
              icon: Icon(OMIcons.accountCircle), title: Text(_tabLabels[1]))
        ],
      ),
    );
  }
}