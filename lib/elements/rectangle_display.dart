import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Used for the Difficulty and Duration display on the HomePage

class RectangleDisplay extends StatelessWidget {
  final String _text;

  RectangleDisplay(this._text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        width: MediaQuery.of(context).size.width * 0.7,
        //color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _text,
            style: Theme.of(context).textTheme.headline4!
                .merge(TextStyle(color: Theme.of(context).secondaryHeaderColor)),
              )
            ),
          ),
        );
  }
}
