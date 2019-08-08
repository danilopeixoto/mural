import 'package:flutter/material.dart';
import 'card_data.dart';
import 'slider_widget.dart';
import 'tag_list_widget.dart';

enum ConfirmationAction { ACCEPT, CANCEL }

class DialogWidget {
  static Future<ConfirmationAction> confirmation(
      BuildContext context,
      String title, String message,
      String leftAction, String rightAction) async {
    return showDialog<ConfirmationAction>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(leftAction),
              onPressed: () {
                Navigator.of(context).pop(ConfirmationAction.CANCEL);
              },
            ),
            FlatButton(
              child: Text(rightAction),
              onPressed: () {
                Navigator.of(context).pop(ConfirmationAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }

   static Future<CardData> card(
      BuildContext context, String author, CardData cardData) async {
    final _formKey = GlobalKey<FormState>();
    
    CardData data = CardData.fill(author, cardData);

    TextEditingController titleTextFieldController = TextEditingController(text: data.title);
    TextEditingController descriptionTextFieldController = TextEditingController(text: data.description);

    titleTextFieldController.addListener(() {
      data.title = titleTextFieldController.text;
    });

    descriptionTextFieldController.addListener(() {
      data.description = descriptionTextFieldController.text;
    });

    return showDialog<CardData>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Cartão"),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(labelText: 'Título'),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: titleTextFieldController,
                    validator:  (value) {
                      if (value.isEmpty)
                        return 'Insira um título para o cartão.';

                      return null;
                    }
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Descrição'),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: descriptionTextFieldController,
                    validator:  (value) {
                      if (value.isEmpty)
                        return 'Insira uma descrição para o cartão.';

                      return null;
                    }
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Progresso"),
                        Center(
                          child: SliderWidget(
                            data.progress.toDouble(),
                            (double value) => data.progress = value.toInt()
                          ),
                        )
                      ]
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Etiqueta"),
                        Center(
                          child: TagListWidget(
                            data.color.index,
                            (int index) => data.color = CardColors.values[index]
                          )
                        )
                      ]
                    ),
                  )
                ]
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(cardData);
              },
            ),
            FlatButton(
              child: Text(cardData == null ? 'Adicionar' : 'Concluir'),
              onPressed: () {
                if (_formKey.currentState.validate())
                  Navigator.of(context).pop(data);
              },
            )
          ],
        );
      },
    );
  }
}