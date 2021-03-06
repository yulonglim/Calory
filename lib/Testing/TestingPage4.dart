import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/Pages/ProgressPage.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/database/goal.dart';
import 'package:flutter_app/database/workout.dart';
import 'package:flutter_app/elements/square_button.dart';
import "package:flutter_app/elements/today's_workout_widget.dart";

class TestPage4 extends StatefulWidget {
  const TestPage4({Key? key}) : super(key: key);

  @override
  _TestPage4State createState() => _TestPage4State();
}

class _TestPage4State extends State<TestPage4> {
  bool refresh = false;
  Goal test = Goal(
      goal: 0,
      difficultyLevel: 0,
      startDate: DateTime.now().toIso8601String(),
      endDate: DateTime.now().toIso8601String(),
      multiplier: 20,
      progress: 5,
      daysAWeek: 5);
  Workout test2 = Workout(muscleGroup: 0, difficultyLevel: 0, workoutDate: DateTime.now().toIso8601String(), workoutDuration: 30, workoutList: 'Rest', multiplier: 30);


  @override
  void initState() {
    super.initState();
    DBHelper().insertGoal(test).then((value) => setState(() async {
      await DBHelper().insertWorkout(test2);
      this.refresh = true;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SquareButton(Icons.calendar_today, 'Progress page', ProgressPage()),
          SizedBox(
            child: Text('workout done today + progress page reflects workout done'),
          ),
          SizedBox(
            height: 4,
          ),
          SizedBox(
            child: Text('The page should show goal with no exercises inside'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.24,
              child: Column(
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: 48,
                  ),
                  Column(
                    children: [
                      Text(
                        'Done',
                        style: Theme.of(context).textTheme.bodyText1!
                            .merge(TextStyle(color: Theme.of(context).secondaryHeaderColor)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onPressed: () {
              DBHelper().deleteAll();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}
