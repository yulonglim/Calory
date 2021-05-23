import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final IconData _icon;
  final String _text1;
  final String _text2;
  final Widget _nextpage;

  SquareButton(this._icon, this._text1, this._text2, this._nextpage);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme
              .of(context)
              .primaryColor,
        ),
        child: Column(
          children: [
            Icon(
              _icon,
              size: 48,
            ),
            Column(
              children: [
                Text(
                  _text1,
                  style: TextStyle(
                      fontSize: 24,
                      color:
                      Theme
                          .of(context)
                          .secondaryHeaderColor),
                ),
                Text(
                  _text2,
                  style: TextStyle(
                      fontSize: 24,
                      color:
                      Theme
                          .of(context)
                          .secondaryHeaderColor),
                ),
              ],
            ),
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => _nextpage),
          );
        },
      ),
    );
  }
}