import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/GoalSetPage.dart';
import 'package:flutter_app/GoalUpdatePage.dart';
import 'package:flutter_app/database/DBHelper.dart';

// Used for the 2 square buttons at the bottom of the HomePage

class GoalButton extends StatefulWidget {
  final IconData _icon;
  final String _text;

  GoalButton(this._icon, this._text);

  @override
  _GoalButtonState createState() => _GoalButtonState();
}

class _GoalButtonState extends State<GoalButton> {
  late bool planned = false;

  @override
  Widget build(BuildContext context) {
    DBHelper().getGoals().then((value) => this.planned != value.isNotEmpty
        ? setState(() {
            planned = true;
          })
        : null);
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: [
            Icon(
              widget._icon,
              size: 48,
            ),
            Column(
              children: [
                Text(
                  planned ? 'Update Your' : 'Set Your',
                  style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).secondaryHeaderColor),
                ),
                Text(
                  widget._text,
                  style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).secondaryHeaderColor),
                ),
              ],
            ),
          ],
        ),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              if (planned) {
                return GoalUpdatePage();
              }
              return GoalSetPage();
            }),
          );
        },
      ),
    );
  }
}