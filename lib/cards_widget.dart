import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'card_data.dart';
import 'message_widget.dart';
import 'loading_widget.dart';
import 'card_item_widget.dart';

class CardsWidget extends StatefulWidget {
  final FirebaseUser _user;

  CardsWidget(this._user);

  @override
  createState() {
    return CardsWidgetState(_user);
  }
}

class CardsWidgetState extends State<CardsWidget> {
  final Firestore _database = Firestore.instance;
  final FirebaseUser _user;

  CardsWidgetState(this._user);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot>(
        stream: _database.collection('cards').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return MessageWidget(
              'Erro ao carregar conteúdo',
              OMIcons.errorOutline
            );
          
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return LoadingWidget();
            default:
              MessageWidget message = MessageWidget(
                'Nenhum cartão adicionado',
                OMIcons.featuredPlayList
              );

              if (!snapshot.hasData)
                return message;
              else if (snapshot.data.documents.length == 0)
                return message;

              return ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot document = snapshot.data.documents.elementAt(index);
                  CardData cardData = CardData.fromData(document.documentID, document.data);

                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: CardItemWidget(_user, cardData),
                  );
                }
              );
          }
        },
      ),
    );
  }
}