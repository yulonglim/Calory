import 'package:flutter/material.dart';
import 'package:flutter_app/AppData/cool_down_data.dart';
import 'package:flutter_app/AppData/warm_up_data.dart';
import 'package:flutter_app/Functions.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/database/exercise_data.dart';
import 'package:flutter_app/elements/No_plan_workout.dart';
import 'package:flutter_app/elements/done_workout.dart';
import 'package:flutter_app/elements/rectangle_display.dart';
import 'package:flutter_app/main.dart';
import '../Pages/FullWorkoutPage.dart';

//Today's Workout Widget on the Homepage

class TodaysWorkOut extends StatefulWidget {
  @override
  _TodaysWorkOutState createState() => _TodaysWorkOutState();
}

class _TodaysWorkOutState extends State<TodaysWorkOut> {
  late bool planned = false;
  bool done = false;
  bool recalibrate = false;
  final List<exerciseData> warmUpItems = List.from(warmUpData);
  final List<exerciseData> coolDownItems = List.from(coolDownData);
  late List<exerciseData> workOutItems = [];
  late List<exerciseData> tempWorkOutItems = [];
  late String difficulty = 'Error ';
  late int duration = 0;

  @override
  void initState() {
    super.initState();
    DBHelper().getWorkOut().then((value) => value.isNotEmpty
        ? DateTime.parse(value.last.workoutDate).day == DateTime.now().day
            ? DBHelper()
                .previousExercises(value.last.workoutList!)
                .then((prevList) => setState(() {
                      for (int i = 0; i < prevList.length; i++) {
                        this.workOutItems.add(exerciseData(
                            exerciseId: prevList[i].exerciseId,
                            exerciseTime: prevList[i].exerciseTime,
                            exerciseName: prevList[i].exerciseName,
                            exerciseDescription:
                                prevList[i].exerciseDescription,
                            exerciseValue: prevList[i].exerciseValue != null
                                ? (prevList[i].exerciseValue! *
                                        value.last.multiplier /
                                        100)
                                    .round()
                                : null));
                      }
                      this.done = true;
                      this.duration = value.last.workoutDuration;
                    }))
            : DBHelper().getGoals().then((goal) => goal.isNotEmpty
                ? DateTime.parse(goal.last.endDate).isAfter(
                        DateTime.now()) // check if previous goal finished
                    ? DBHelper()
                        .generateExercises(goal.last.goal)
                        .then((workOutItems) => setState(() {
                              planned = true;
                              this.difficulty = Functions().difficultyToString(
                                  goal.last.difficultyLevel);
                              workOutItems.forEach((element) {
                                this.tempWorkOutItems.add(exerciseData(
                                    exerciseId: element.exerciseId,
                                    exerciseValue: element.exerciseValue != null
                                        ? (element.exerciseValue! *
                                                goal.last.multiplier /
                                                100)
                                            .round()
                                        : null,
                                    exerciseTime: element.exerciseTime,
                                    exerciseName: element.exerciseName,
                                    exerciseDescription:
                                        element.exerciseDescription));
                              });
                              if (DateTime.parse(goal.last.endDate).isBefore(
                                  DateTime.now().add(Duration(
                                      days: goal.last.progress == 0
                                          ? 0
                                          : goal.last.progress - 1)))) {
                                recalibrate = true;
                              }
                              this.workOutItems = tempWorkOutItems;
                              setWorkOutData(this.workOutItems);
                            }))
                    : null
                : null)
        : DBHelper().getGoals().then((goal) => goal.isNotEmpty
            ? DateTime.parse(goal.last.endDate).isBefore(DateTime.now()) &&
                    goal.last.progress == 0 // check if previous goal finished
                ? DBHelper()
                    .generateExercises(goal.last.goal)
                    .then((workOutItems) => setState(() {
                          planned = true;
                          this.difficulty = Functions()
                              .difficultyToString(goal.last.difficultyLevel);
                          workOutItems.forEach((element) {
                            this.tempWorkOutItems.add(exerciseData(
                                exerciseId: element.exerciseId,
                                exerciseValue: element.exerciseValue != null
                                    ? (element.exerciseValue! *
                                            goal.last.multiplier /
                                            100)
                                        .round()
                                    : null,
                                exerciseTime: element.exerciseTime,
                                exerciseName: element.exerciseName,
                                exerciseDescription:
                                    element.exerciseDescription));
                          });
                          this.recalibrate = true;
                          this.workOutItems = tempWorkOutItems;
                          setWorkOutData(this.workOutItems);
                        }))
                : DBHelper()
                    .generateExercises(goal.last.goal)
                    .then((workOutItems) => setState(() {
                          this.planned = true;
                          this.difficulty = Functions()
                              .difficultyToString(goal.last.difficultyLevel);

                          workOutItems.forEach((element) {
                            this.tempWorkOutItems.add(exerciseData(
                                exerciseId: element.exerciseId,
                                exerciseValue: element.exerciseValue != null
                                    ? (element.exerciseValue! *
                                            goal.last.multiplier /
                                            100)
                                        .round()
                                    : null,
                                exerciseTime: element.exerciseTime,
                                exerciseName: element.exerciseName,
                                exerciseDescription:
                                    element.exerciseDescription));
                          });
                          this.workOutItems = tempWorkOutItems;
                          setWorkOutData(this.workOutItems);
                        }))
            : null));
  }

  @override
  Widget build(BuildContext context) {
    if (done) {
      return doneWorkout(this.workOutItems);
    }
    if (!planned) {
      return noPlan();
    }
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor.withAlpha(600),
            width: 3,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          children: [
            /*
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Today's Workout",
                style: Theme.of(context).textTheme.headline2!
                    .merge(TextStyle(color: Colors.black)),
              ),
            ),
             */
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
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
                      RectangleDisplay('Duration: ' +
                          Functions().totalduration(this.workOutItems)),
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
                                    workoutItems: this.workOutItems,
                                    oneTime: false,
                                    recalibrate: this.recalibrate,
                                    done: false,
                                  )),
                        );
                      },
                      child: Text(
                        'Start',
                        style: Theme.of(context).textTheme.bodyText1!
                            .merge(TextStyle(color: Theme.of(context).secondaryHeaderColor)),
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
