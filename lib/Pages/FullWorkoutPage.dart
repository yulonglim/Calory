import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AppData/cool_down_data.dart';
import 'package:flutter_app/AppData/warm_up_data.dart';
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

  FullWorkoutPage({Key? key, required this.workoutItems, required this.oneTime, this.difficultyLevel}) : super(key: key);

  String durationMMSS(int duration) {
    int mins = 0;
    int temp = duration;
    while (temp >= 60) {
      temp -= 60;
      mins++;
    }
    return mins.toString() + 'm ' + temp.toString() + 's';
  }

  String warmUpduration() {
    int duration = 0;
    for (int counter = 0; counter < WarmUpItems.length; counter++) {
      duration += WarmUpItems[counter].exerciseTime;
    }
    return durationMMSS(duration);
  }

  String coolDownduration() {
    int duration = 0;
    for (int counter = 0; counter < CoolDownItems.length; counter++) {
      duration += CoolDownItems[counter].exerciseTime;
    }
    return durationMMSS(duration);
  }

  String workOutduration() {
    int duration = 0;
    for (int counter = 0; counter < workoutItems.length; counter++) {
      duration += workoutItems[counter].exerciseTime;
    }
    return durationMMSS(duration);
  }

  @override
  Widget build(BuildContext context){
    if(oneTime) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 1,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
            title: Text(
              "Today's Workout",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          body: Container(
              padding: EdgeInsets.only(left: 16, top: 20, right: 16),
              child: ListView(children: [
                CardButton(
                  iconData: Icons.whatshot,
                  buttonName: "Warm Up",
                  nextPage: WarmUpPage(),
                  duration: warmUpduration(),
                ),
                CardButton(
                  iconData: Icons.sports_handball_outlined,
                  buttonName: "Main Workout",
                  nextPage: WorkOutPage(
                    items: workoutItems,
                  ),
                  duration: workOutduration(),
                ),
                CardButton(
                  iconData: Icons.ac_unit_outlined,
                  buttonName: "Cool Down",
                  nextPage: CoolDownPage(),
                  duration: coolDownduration(),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    onPressed: () async {
                      setWorkOutData(this.workoutItems);
                      dynamic workout;
                      int duration = 0;
                      String workoutList = '';
                      for (int counter = 0; counter < workoutItems.length; counter++) {
                        duration += workoutItems[counter].exerciseTime;
                        if(workoutItems[counter].exerciseName != 'Rest'){
                          workoutList += workoutItems[counter].exerciseName + '\n';
                        }
                      }
                      await DBHelper().getWorkOut().then((value) =>
                      value.isNotEmpty ? workout = value.first : null);
                      if (workout == null ||
                          DateTime.parse(workout.workoutDate).day !=
                              DateTime.now().day) {
                        await DBHelper().insertWorkout(Workout(
                            muscleGroup: 0,
                            difficultyLevel:  this.difficultyLevel! ,
                            workoutDate: DateTime.now().toIso8601String(),
                            workoutDuration: duration,
                          workoutList: workoutList,
                            multiplier: ((this.difficultyLevel! + 1) / 3 * 100).round()
                        ));
                      }
                      int count = 0;
                      Navigator.popUntil(context, (route) {
                        return count++ == 3;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Homepage()),
                      );
                    },
                    child: Text(
                      'End Workout',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ])));
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          title: Text(
            "Today's Workout",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 16, top: 20, right: 16),
            child: ListView(children: [
              CardButton(
                iconData: Icons.whatshot,
                buttonName: "Warm Up",
                nextPage: WarmUpPage(),
                duration: warmUpduration(),
              ),
              CardButton(
                iconData: Icons.sports_handball_outlined,
                buttonName: "Main Workout",
                nextPage: WorkOutPage(
                  items: workoutItems
                ),
                duration: workOutduration(),
              ),
              CardButton(
                iconData: Icons.ac_unit_outlined,
                buttonName: "Cool Down",
                nextPage: CoolDownPage(),
                duration: coolDownduration(),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EndWorkOutPage()),
                    );
                  },
                  child: Text(
                    'End Workout',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ])));
  }

}
