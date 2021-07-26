import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Used for the square buttons at the bottom of the HomePage

class SquareButton extends StatelessWidget {
  final IconData _icon;
  final String _text;
  final Widget _nextpage;

  SquareButton(this._icon, this._text, this._nextpage);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.24,
          child: Column(
            children: [
              Icon(
                _icon,
                size: 48,
              ),
              Column(
                children: [
                  Text(
                    _text,
                    style: Theme.of(context).textTheme.bodyText1!
                        .merge(TextStyle(color: Theme.of(context).secondaryHeaderColor)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => _nextpage),
          );
        },
      ),
    );
  }
}
