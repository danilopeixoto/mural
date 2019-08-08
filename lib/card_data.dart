import 'dart:convert';

enum CardColors { RED, GREEN, BLUE, YELLOW, PURPLE }

class CardData {
  String id;
  String title;
  String description;
  int progress;
  CardColors color;
  List<String> authors;

  static CardData fromData(String id, Map<String, dynamic> data) {
    CardData temp = CardData();

    temp.id = id;
    temp.title = data['title'];
    temp.description = data['description'];
    temp.progress = data['progress'];
    temp.color = CardColors.values[data['color']];
    temp.authors = List<String>.from(jsonDecode(data['authors']));

    return temp;
  }
  static CardData fill(String author, CardData cardData) {
    CardData temp = CardData();

    if (cardData != null) {
      temp.id = cardData.id;
      temp.title = cardData.title;
      temp.description = cardData.description;
      temp.progress = cardData.progress;
      temp.color = cardData.color;
      temp.authors = List<String>.from(cardData.authors);

      temp.authors.remove(author);
      temp.authors.add(author);
    }
    else{
      temp.title = "";
      temp.description = "";
      temp.progress = 0;
      temp.color = CardColors.RED;

      temp.authors = List<String>();
      temp.authors.add(author);
    }

    return temp;
  }

  Map<String, dynamic> toData() {
    var data = {
      'title': title,
      'description': description,
      'progress': progress,
      'color': color.index,
      'authors': jsonEncode(authors)
    };

    return data;
  }
}