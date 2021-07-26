import 'package:flutter/material.dart';
import 'package:flutter_app/Functions.dart';
import 'package:flutter_app/Pages/Library.dart';
import 'package:flutter_app/Pages/HistoryPage.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/database/exercise_data.dart';
import 'package:flutter_app/elements/goalbutton.dart';
import 'package:flutter_app/elements/square_button.dart';
import "package:flutter_app/elements/today's_workout_widget.dart";

import 'ProgressPage.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<exerciseData> upperBody = [];
  List<exerciseData> lowerBody = [];
  List<exerciseData> core = [];

  @override
  void initState() {
    super.initState();
    openExcel();
    DBHelper()
        .insertExerciseData(DBHelper.tableLowerBody, lowerBodyData2)
        .whenComplete(() => DBHelper().getExercises(2).then((l) => l.isNotEmpty
            ? setState(() {
                this.lowerBody = l;
              })
            : null));
    DBHelper().insertExerciseData(DBHelper.tableUpperBody, upperBodyData2);
    DBHelper()
        .insertExerciseData(DBHelper.tableCoreExercise, coreExerciseData2)
        .whenComplete(() => DBHelper().getExercises(0).then((c) => c.isNotEmpty
            ? setState(() {
                this.core = c;
              })
            : null));
    DBHelper()
        .insertExerciseData(DBHelper.tableCardio, cardioData2)
        .whenComplete(() => DBHelper().getExercises(1).then((u) => u.isNotEmpty
            ? setState(() {
                this.upperBody = u;
              })
            : null));
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
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor),
                    shape: MaterialStateProperty.all<CircleBorder>(
                        CircleBorder(side: BorderSide(color: Theme.of(context).primaryColor)))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryPage()),
                  );
                },
                child: Icon(Icons.person)),
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
                Functions().dateTime(),
                style: Theme.of(context).textTheme.headline1!
                    .merge(TextStyle(color: Colors.black)),
              ),
            ),
          ),
          TodaysWorkOut(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            //buttons
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GoalButton(Icons.settings, 'Goal'),
              SquareButton(
                Icons.book,
                'Exercise Library',
                LibraryPage(
                  core: core,
                  upperBody: upperBody,
                  lowerBody: lowerBody,
                ),
              ),
              SquareButton(Icons.calendar_today_rounded, 'View Progress',
                  ProgressPage()),
            ],
          ), //the buttons
        ],
      ),
    );
  }
}
