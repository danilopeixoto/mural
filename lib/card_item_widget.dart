import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'card_data.dart';
import 'card_form_widget.dart';

class CardItemWidget extends StatelessWidget {
  final Firestore _database = Firestore.instance;

  final FirebaseUser _user;
  final CardData _data;

  final List<List<Color>> gradients =
    [[Color(0xFFFF0137), Color(0xFFFF6B6D)],
     [Color(0xFF02CA94), Color(0xFF24FCB7)],
     [Color(0xFF0A53FC), Color(0xFF6792FF)],
     [Color(0xFFFF7F01), Color(0xFFFFCA4F)],
     [Color(0xFF6227FC), Color(0xFFBD62E0)]];

    final List<Color> lightColors = [
      Color(0xFFFF859F),
      Color(0xFF5AEDC6),
      Color(0xFF6E98FA),
      Color(0xFFFFB873),
      Color(0xFF9872FC)
    ];

  CardItemWidget(this._user, this._data);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(_data.id),
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Icon(
            OMIcons.deleteOutline,
            color: Theme.of(context).primaryColor,
            size: 26),
        )
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {
        await _database.collection('cards').document(_data.id).delete();
      },
      child: InkWell(
        onTap: () async {
          CardData result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                CardFormWidget(_user.displayName, _data))
          );
          
          if (result != _data) {
            var data = result.toData();
            DocumentReference document = _database.collection('cards').document(result.id);
            
            return document.setData(data, merge: true);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0, 1.0],
              colors: gradients[_data.color.index]
            )
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    _data.title,
                    overflow: TextOverflow.ellipsis,
                    textScaleFactor: 1.5,
                    style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold)
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
                        child: CircularPercentIndicator(
                          radius: 80.0,
                          lineWidth: 8.0,
                          percent: _data.progress * 0.01,
                          center: Text(
                            '${_data.progress}%',
                            textScaleFactor: 1.2,
                            style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold)),
                          progressColor: Colors.white,
                          backgroundColor: lightColors[_data.color.index]
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          height: 100,
                          child: Text.rich(
                            TextSpan(
                              text: _data.description,
                              style: TextStyle(color: Colors.white)),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            textScaleFactor: 1.2,
                            maxLines: 5
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ),
      )
    );
  }
}