import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  final double _value;
  final Function _onChanged;

  SliderWidget(this._value, this._onChanged);

  @override
  createState() {
    return SliderWidgetState(_value, _onChanged);
  }
}

class SliderWidgetState extends State<SliderWidget> {
  double _value;
  final Function _onChanged;

  SliderWidgetState(this._value, this._onChanged);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Slider(
            activeColor: Theme.of(context).primaryColor,
            min: 0.0,
            max: 100.0,
            divisions: 100,
            value: _value,
            onChanged: (newValue) {
              setState(() => _value = newValue);
              _onChanged(newValue);
            }
          ),
        ),
        Container(
          width: 50,
          alignment: Alignment.centerRight,
          child: Text(
            '${_value.toInt()}%',
            style: Theme.of(context).textTheme.display1,
            textAlign: TextAlign.right,
            textScaleFactor: 0.6
          ),
        )
      ]
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