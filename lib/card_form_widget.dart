import 'package:flutter/material.dart';
import 'card_data.dart';
import 'slider_widget.dart';
import 'tag_list_widget.dart';

class CardFormWidget extends StatefulWidget {
  final String _author;
  final CardData _cardData;

  CardFormWidget(this._author, this._cardData);

  @override
  createState() {
    return CardFormWidgetState(_author, _cardData);
  }
}

class CardFormWidgetState extends State<CardFormWidget> {
  final String _author;
  final CardData _cardData;

  final _formKey = GlobalKey<FormState>();

  CardData data;

  TextEditingController titleTextFieldController;
  TextEditingController descriptionTextFieldController;

  CardFormWidgetState(this._author, this._cardData);

  @override
  void initState() {
    data = CardData.fill(_author, _cardData);

    titleTextFieldController = TextEditingController(text: data.title);
    descriptionTextFieldController = TextEditingController(text: data.description);

    titleTextFieldController.addListener(() {
      data.title = titleTextFieldController.text;
    });

    descriptionTextFieldController.addListener(() {
      data.description = descriptionTextFieldController.text;
    });

    super.initState();
  }

  @override
  void dispose() {
    titleTextFieldController.dispose();
    descriptionTextFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cartão'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(_cardData);
          }
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Salvar', textScaleFactor: 1.2, style: TextStyle(color: Colors.white)),
            onPressed: () {
              if (_formKey.currentState.validate())
                Navigator.of(context).pop(data);
            },
          )
        ]
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: 'Título'),
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
          )
      )
    );
  }
}