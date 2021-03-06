import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/GoalSetPage.dart';
import 'package:flutter_app/Pages/GoalUpdatePage.dart';
import 'package:flutter_app/database/DBHelper.dart';

// Used for the goal set square buttons at the bottom of the HomePage

class GoalButton extends StatefulWidget {
  final String _text;

  GoalButton(this._text);

  @override
  _GoalButtonState createState() => _GoalButtonState();
}

class _GoalButtonState extends State<GoalButton> {
  late bool planned = false;

  @override
  Widget build(BuildContext context) {
    DBHelper().getGoals().then((value) => this.planned != value.isNotEmpty
        ? DateTime.parse(value.last.endDate).isBefore(DateTime.now())
            ? setState(() {
                planned = false;
              })
            : setState(() {
                planned = true;
              })
        : null);
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.24,
          child: Column(
            children: [
              ImageIcon(
                AssetImage("assets/images/target.png"),
                color: Theme.of(context).secondaryHeaderColor,
                size: 48,
              ),
              Column(
                children: [
                  Text(
                    planned ? 'Update' : 'Set a',
                    style: Theme.of(context).textTheme.bodyText1!.merge(
                        TextStyle(
                            color: Theme.of(context).secondaryHeaderColor)),
                  ),
                  Text(
                    widget._text,
                    style: Theme.of(context).textTheme.bodyText1!.merge(
                        TextStyle(
                            color: Theme.of(context).secondaryHeaderColor)),
                  ),
                ],
              ),
            ],
          ),
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
