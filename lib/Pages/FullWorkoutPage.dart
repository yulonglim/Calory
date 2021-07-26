import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AppData/cool_down_data.dart';
import 'package:flutter_app/AppData/warm_up_data.dart';
import 'package:flutter_app/Functions.dart';
import 'package:flutter_app/Pages/EndWorkOutPage.dart';
import 'package:flutter_app/Pages/HomePage.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/database/exercise_data.dart';
import 'package:flutter_app/database/workout.dart';
import 'package:flutter_app/main.dart';

import 'CoolDownPage.dart';
import 'WorkOutPage.dart';
import 'WarmUpPage.dart';
import '../elements/card_button.dart';

class FullWorkoutPage extends StatelessWidget {
  final List<exerciseData> WarmUpItems = List.from(warmUpData);
  final List<exerciseData> CoolDownItems = List.from(coolDownData);
  int restduration = 5;
  List<exerciseData> workoutItems;
  final bool oneTime;
  final int? difficultyLevel;
  final bool? recalibrate;
  final bool? done;

  FullWorkoutPage(
      {Key? key,
      required this.workoutItems,
      required this.oneTime,
      this.recalibrate,
      this.difficultyLevel,
      this.done})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            ),
          ),
          title: Text(
            "Today's Workout",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .merge(TextStyle(color: Colors.black)),
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 16, top: 20, right: 16),
            child: ListView(children: [
              CardButton(
                iconData: Icons.whatshot,
                buttonName: "Warm Up",
                nextPage: WarmUpPage(),
                duration: Functions().totalduration(WarmUpItems),
              ),
              CardButton(
                iconData: Icons.sports_handball_outlined,
                buttonName: "Main Workout",
                nextPage: WorkOutPage(
                  items: workoutItems,
                ),
                duration: Functions().totalduration(workoutItems),
              ),
              CardButton(
                iconData: Icons.ac_unit_outlined,
                buttonName: "Cool Down",
                nextPage: CoolDownPage(),
                duration: Functions().totalduration(coolDownData),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () async {
                    if (!oneTime) {
                      if (done == false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EndWorkOutPage(
                                  recalibrate: this.recalibrate)),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    } else if (done == true) {
                      Navigator.pop(context);
                    } else {
                      setWorkOutData(this.workoutItems);
                      dynamic workout;
                      int duration = 0;
                      String workoutList = '';
                      for (int i = 0; i < workoutItems.length; i++) {
                        duration += workoutItems[i].exerciseTime;
                        if (workoutItems[i].exerciseName == 'Rest' &&
                            workoutItems[i].exerciseTime == 5) {
                        } else {
                          print(workoutItems[i].exerciseName);
                          workoutList =
                              workoutList + '\n' + workoutItems[i].exerciseName;
                        }
                      }
                      await DBHelper().getWorkOut().then((value) =>
                          value.isNotEmpty ? workout = value.last : null);
                      if (workout == null ||
                          DateTime.parse(workout.workoutDate).day !=
                              DateTime.now().day) {
                        await DBHelper().insertWorkout(Workout(
                            muscleGroup: 0,
                            difficultyLevel: this.difficultyLevel!,
                            workoutDate: DateTime.now().toIso8601String(),
                            workoutDuration: duration,
                            workoutList: workoutList,
                            multiplier: ((this.difficultyLevel! + 1) / 3 * 100)
                                .round()));
                      }
                      int count = 0;
                      Navigator.popUntil(context, (route) {
                        return count++ == 3;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Homepage()),
                      );
                    }
                  },
                  child: Text(
                    'End Workout',
                    style: Theme.of(context).textTheme.headline5!.merge(
                        TextStyle(
                            color: Theme.of(context).secondaryHeaderColor)),
                    textAlign: TextAlign.center,
                  )),
            ])));
  }
}
