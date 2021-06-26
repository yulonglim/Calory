import 'package:flutter/material.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/database/exercise_data.dart';
import 'package:flutter_app/elements/goalbutton.dart';
import 'package:flutter_app/elements/square_button.dart';
import "package:flutter_app/elements/today's_workout_widget.dart";
import 'package:intl/intl.dart';

import './ProgressPage.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String dateTime() {
    String day;
    String month = DateFormat.MMMM().format(DateTime.now());
    String year = DateTime.now().year.toString();

    if (DateTime.now().day == 11 ||
        DateTime.now().day == 12 ||
        DateTime.now().day == 13) {
      day = DateTime.now().day.toString() + "th";
    } else if (DateTime.now().day % 10 == 1) {
      day = DateTime.now().day.toString() + "st";
    } else if (DateTime.now().day % 10 == 2) {
      day = DateTime.now().day.toString() + "nd";
    } else if (DateTime.now().day % 10 == 3) {
      day = DateTime.now().day.toString() + "rd";
    } else {
      day = DateTime.now().day.toString() + "th";
    }

    return day + " " + month + " " + year;
  }
  @override
  void initState() {
    super.initState();
    openExcel();
    DBHelper().insertExerciseData(DBHelper.tableUpperBody, upperBodyData2);
    DBHelper().insertExerciseData(DBHelper.tableLowerBody, lowerBodyData2);
    DBHelper().insertExerciseData(DBHelper.tableCoreExercise, coreExerciseData2);
    DBHelper().insertExerciseData(DBHelper.tableCardio, cardioData2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "ExerciseLah!",
            style: TextStyle(fontSize: 32),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                int? currentID = 0;
                await DBHelper().getGoals().then((value) => currentID = value.isNotEmpty ? value.first.goalId : 0);
                await DBHelper().deleteGoal(currentID!);
                await DBHelper().deleteAllWorkOuts();
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              },
              child: Text('Clear'),
            )
          ],
        ),
        body: Wrap(
          spacing: MediaQuery.of(context).size.height * 0.01,
          runSpacing: MediaQuery.of(context).size.height * 0.01,
          children: [
            Container(
              // Container for today's plan
              color: Theme.of(context).secondaryHeaderColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5,
              alignment: Alignment.centerLeft,
              child: Center(
                child: Text(
                  dateTime(),
                  style: TextStyle(
                    fontSize: 48,
                    //color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            todays_workout(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              //buttons
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GoalButton(Icons.settings, 'Goal'),
                SquareButton(Icons.calendar_today_rounded, 'View', 'Progress',
                    ProgressPage()),
              ],
            ), //the buttons
          ],
        ));
  }
}
