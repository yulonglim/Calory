import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/database/goal.dart';
import 'package:intl/intl.dart';

class GoalCard extends StatelessWidget {
  final Goal item;
  final Animation<double> animation;

  GoalCard(
      {Key? key,
      required this.item,
      required this.animation,})
      : super(key: key);

  String goalToString(int goalType) {
    switch (goalType) {
      case 0:
        {
          return 'Weight Loss';
        }
      case 1:
        {
          return 'Strength';
        }
      case 2:
        {
          return 'Endurance';
        }
      default:
        {
          return 'Not Set';
        }
    }
  }

  String dateTime(String formattedDate) {
    String day;
    String month = DateFormat.MMMM().format(DateTime.parse(formattedDate));
    String year = DateTime.parse(formattedDate).year.toString();

    if (DateTime.parse(formattedDate).day == 11 ||
        DateTime.parse(formattedDate).day == 12 ||
        DateTime.parse(formattedDate).day == 13) {
      day = DateTime.parse(formattedDate).day.toString() + "th";
    } else if (DateTime.parse(formattedDate).day % 10 == 1) {
      day = DateTime.parse(formattedDate).day.toString() + "st";
    } else if (DateTime.parse(formattedDate).day % 10 == 2) {
      day = DateTime.parse(formattedDate).day.toString() + "nd";
    } else if (DateTime.parse(formattedDate).day % 10 == 3) {
      day = DateTime.parse(formattedDate).day.toString() + "rd";
    } else {
      day = DateTime.parse(formattedDate).day.toString() + "th";
    }

    return day + " " + month + " " + year;
  }

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
                content: Column(
                  children: [
                    Text('Start Date: ' + dateTime(item.startDate),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    Text('End Date: ' + dateTime(item.startDate),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    Text('Difficulty: ' + (item.difficultyLevel == 0 ? 'Easy' : item.difficultyLevel == 1 ? 'Medium' : 'Hard'),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ],
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
                  'Goal Type: ' + goalToString(item.goal),
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
