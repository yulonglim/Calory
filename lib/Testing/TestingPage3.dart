import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/database/goal.dart';
import 'package:flutter_app/database/workout.dart';
import 'package:flutter_app/elements/test_button.dart';
import "package:flutter_app/elements/today's_workout_widget.dart";

class TestPage3 extends StatefulWidget {
  const TestPage3({Key? key}) : super(key: key);

  @override
  _TestPage3State createState() => _TestPage3State();
}

class _TestPage3State extends State<TestPage3> {
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
    // TODO: implement initState
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
          TodaysWorkOut(),
          SizedBox(
            child: Text('Test with a goal planned + workout completed today'),
          ),
          SizedBox(
            height: 4,
          ),
          SizedBox(
            child: Text('The widget should be showing workout completed, duration 0m 30s'),
          ),
          TestButton(Icons.done, "Passed", TestPage3(),
              DBHelper().deleteAll()
          ),
        ],
      ),
    );
  }
}
