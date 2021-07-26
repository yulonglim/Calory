import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Functions.dart';
import 'package:flutter_app/database/goal.dart';

class GoalCard extends StatelessWidget {
  final Goal item;
  final Animation<double> animation;

  GoalCard({
    Key? key,
    required this.item,
    required this.animation,
  }) : super(key: key);

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
                title: Text('Goal no: ' + item.goalId.toString(),
                    style: Theme.of(context).textTheme.headline4),
                content: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Start Date: ',
                              style: Theme.of(context).textTheme.bodyText1!),
                          Text(Functions().dateTime2(item.startDate),
                              style: Theme.of(context).textTheme.bodyText1!),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('End Date: ',
                              style: Theme.of(context).textTheme.bodyText1!),
                          Text(Functions().dateTime2(item.endDate),
                              style: Theme.of(context).textTheme.bodyText1!),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Difficulty: ',
                              style: Theme.of(context).textTheme.bodyText1!),
                          Text(
                              Functions()
                                  .difficultyToString(item.difficultyLevel),
                              style: Theme.of(context).textTheme.bodyText1!),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Days Done: ',
                              style: Theme.of(context).textTheme.bodyText1!),
                          Text(
                              (Functions().daysWorkedOut(item.startDate,
                                          item.endDate, item.daysAWeek) -
                                      item.progress)
                                  .toString(),
                              style: Theme.of(context).textTheme.bodyText1!),
                        ],
                      ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Goal Date: ',
                      style: Theme.of(context).textTheme.bodyText1!.merge(
                          TextStyle(
                              color: Theme.of(context).secondaryHeaderColor)),
                    ),
                    Text(
                      Functions().dateTime2(item.startDate),
                      style: Theme.of(context).textTheme.bodyText1!.merge(
                          TextStyle(
                              color: Theme.of(context).secondaryHeaderColor)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Goal Type: ',
                      style: Theme.of(context).textTheme.bodyText1!.merge(
                          TextStyle(
                              color: Theme.of(context).secondaryHeaderColor)),
                    ),
                    Text(
                      Functions().goalToString(item.goal),
                      style: Theme.of(context).textTheme.bodyText1!.merge(
                          TextStyle(
                              color: Theme.of(context).secondaryHeaderColor)),
                    ),
                  ],
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
