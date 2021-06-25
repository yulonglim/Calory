import 'package:flutter/material.dart';
import 'package:flutter_app/AppData/cool_down_data.dart';
import 'package:flutter_app/AppData/warm_up_data.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/database/exercise_data.dart';
import 'package:flutter_app/elements/No_plan_workout.dart';
import 'package:flutter_app/elements/done_workout.dart';
import 'package:flutter_app/elements/rectangle_display.dart';
import 'package:flutter_app/main.dart';

import '../FullWorkoutPage.dart';

class todays_workout extends StatefulWidget {
  @override
  _todays_workoutState createState() => _todays_workoutState();
}

class _todays_workoutState extends State<todays_workout> {
  late bool planned = false;
  bool done = false;
  final List<exerciseData> WarmUpItems = List.from(warmUpData);
  final List<exerciseData> CoolDownItems = List.from(coolDownData);
  late List<exerciseData> workOutItems = [];
  late List<exerciseData> tempWorkOutItems = [];
  late String difficulty = 'Error ';

  int restduration = 5;

  String durationMMSS(int duration) {
    int mins = 0;
    int temp = duration;
    while (temp >= 60) {
      temp -= 60;
      mins++;
    }
    return mins.toString() + 'm ' + temp.toString() + 's';
  }

  @override
  void initState() {
    super.initState();
    DBHelper().getWorkOut().then((value) =>
        DateTime.parse(value.last.workoutDate).day == DateTime.now().day
            ? setState(() {
                this.done = true;
              })
            : null);
    if (!done) {
      DBHelper().getGoals().then((goal) => goal.first.goalId != null
          ? DBHelper()
              .getExercises(goal.first.goal)
              .then((workOutItems) => setState(() {
                    planned = true;
                    goal.first.difficultyLevel == 0
                        ? this.difficulty = 'Easy'
                        : goal.first.difficultyLevel == 1
                            ? this.difficulty = 'Medium'
                            : this.difficulty = 'Hard';
                    workOutItems.forEach((element) {
                      this.tempWorkOutItems.add(exerciseData(
                          exerciseId: element.exerciseId,
                          exerciseValue: element.exerciseValue != null
                              ? (element.exerciseValue! *
                                      goal.first.multiplier /
                                      100)
                                  .round()
                              : null,
                          exerciseTime: element.exerciseTime,
                          exerciseName: element.exerciseName,
                          exerciseDescription: element.exerciseDescription));
                    });
                    this.workOutItems = tempWorkOutItems;
                    setWorkOutData(this.workOutItems);
                  }))
          : null);
    }
  }

  String totalduration() {
    int duration = 0;
    for (int counter = 0; counter < WarmUpItems.length; counter++) {
      duration += WarmUpItems[counter].exerciseTime + restduration;
    }
    for (int counter = 0; counter < CoolDownItems.length; counter++) {
      duration += CoolDownItems[counter].exerciseTime + restduration;
    }
    for (int counter = 0; counter < workOutItems.length; counter++) {
      duration += workOutItems[counter].exerciseTime + restduration;
    }

    return durationMMSS(duration);
  }

  @override
  Widget build(BuildContext context) {
    if (!planned) {
      return noPlan();
    }
    if (done) {
      return doneWorkout();
    }
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor.withAlpha(600),
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Today's Workout",
                style: TextStyle(
                  //color: Theme.of(context).primaryColor,
                  fontSize: 40,
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.whatshot,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  Column(
                    children: [
                      RectangleDisplay('Difficulty: ' + this.difficulty),
                      RectangleDisplay('Duration: ' + totalduration()),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 16, 4, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullWorkoutPage(
                                  workoutItems: this.workOutItems)),
                        );
                      },
                      child: Text(
                        'Start',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
