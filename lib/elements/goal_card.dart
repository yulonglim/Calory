import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Functions.dart';
import 'package:flutter_app/database/goal.dart';

class GoalCard extends StatelessWidget {
  final Goal item;
  final Animation<double> animation;

  GoalCard(
      {Key? key,
      required this.item,
      required this.animation,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).primaryColor,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          title: new InkWell(
            onTap: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(
                  'Goal no: ' + item.goalId.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      //color: Theme.of(context).primaryColor
                  ),
                ),
                content: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    children: [
                      Text('Start Date: ' + Functions().dateTime2(item.startDate),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Text('End Date: ' + Functions().dateTime2(item.endDate),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Text('Difficulty: ' + Functions().difficultyToString(item.difficultyLevel),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Text('Days Done: ' + (Functions().daysWorkedOut(item.startDate, item.endDate, item.daysAWeek) - item.progress).toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Goal no: ' + item.goalId.toString(),
                  style: TextStyle(
                      //fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: Theme.of(context).secondaryHeaderColor),
                ),
                Text(
                  'Goal Type: ' + Functions().goalToString(item.goal),
                  style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).secondaryHeaderColor),
                ),
              ],
            ),
          ),
          //
        ),
      ),
    );
  }
}
