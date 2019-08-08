import 'package:flutter/material.dart';

class TagListWidget extends StatefulWidget {
  final int _index;
  final Function _onChanged;

  TagListWidget(this._index, this._onChanged);

  @override
  createState() {
    return TagListWidgetState(_index, _onChanged);
  }
}

class TagListWidgetState extends State<TagListWidget> {
  final int _index;
  final Function _onChanged;

  List<TagModel> data = List<TagModel>();

  TagListWidgetState(this._index, this._onChanged);

  @override
  void initState() {
    super.initState();

    data.add(TagModel(false, Color(0xFFFF0053)));
    data.add(TagModel(false, Color(0xFF0FE1A5)));
    data.add(TagModel(false, Color(0xFF2D69F7)));
    data.add(TagModel(false, Color(0xFFFFA324)));
    data.add(TagModel(false, Color(0xFF9346ED)));

    data[_index].isSelected = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.0,
      height: 50,
      alignment: Alignment.center,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                data.forEach((element) => element.isSelected = false);
                data[index].isSelected = true;
              });

              _onChanged(index);
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TagItem(data[index]),
            ),
          );
        },
      ),
    );
  }
}

class TagItem extends StatelessWidget {
  final TagModel _item;

  TagItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.0,
      width: 36.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _item.color,
        border: Border.all(
            width: 3.0,
            color: _item.isSelected
                ? Colors.lightBlue
                : Colors.transparent)
      )
    );
  }
}

class TagModel {
  bool isSelected;
  final Color color;

  TagModel(this.isSelected, this.color);
}