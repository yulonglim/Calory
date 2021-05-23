import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            borderRadius:
            BorderRadius.all(Radius.circular(8))),
        width: MediaQuery.of(context).size.width * 0.6,
        //color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _text,
            style: TextStyle(
              fontSize: 32,
              color: Theme.of(context)
                  .secondaryHeaderColor,
            ),
          ),
        ),
      ),
    );
  }

}