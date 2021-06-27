import 'package:flutter/material.dart';
import 'package:flutter_app/HomePage.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/database/goal.dart';
import 'package:flutter_app/database/workout.dart';

class EndWorkOutPage extends StatefulWidget {
  const EndWorkOutPage({Key? key}) : super(key: key);

  @override
  EndWorkOutPageState createState() => EndWorkOutPageState();
}

class EndWorkOutPageState extends State<EndWorkOutPage> {
  double _currentSliderValue = 2;

  String? feedback(i) {
    switch (i.round()) {
      case 0:
        {
          return 'Too Easy';
        }
      case 1:
        {
          return 'Easy';
        }
      case 2:
        {
          return 'Manageable';
        }
      case 3:
        {
          return 'Difficult';
        }
      case 4:
        {
          return 'Too Difficult';
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please Rate Today's Workout",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: 4,
                  divisions: 4,
                  label: feedback(_currentSliderValue),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  }),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () async {
                    dynamic currentGoal;
                    dynamic workout;
                    await DBHelper().getGoals().then((value) =>
                        value.isNotEmpty ? currentGoal = value.first : null);
                    await DBHelper().getWorkOut().then((value) =>
                        value.isNotEmpty ? workout = value.first : null);
                    if (workout == null ||
                        DateTime.parse(workout.workoutDate).day !=
                            DateTime.now().day) {
                      if (currentGoal != null) {
                        await DBHelper().updateGoal(Goal(
                            goalId: currentGoal.goalId,
                            goal: currentGoal.goal,
                            difficultyLevel: currentGoal.multiplier +
                                        5 -
                                        _currentSliderValue.round() * 2 >
                                    60
                                ? 2
                                : currentGoal.multiplier +
                                            5 -
                                            _currentSliderValue.round() * 2 >
                                        40
                                    ? 1
                                    : 0,
                            startDate: currentGoal.startDate,
                            endDate: currentGoal.endDate,
                            multiplier: currentGoal.multiplier +
                                        5 -
                                        _currentSliderValue.round() * 2 >=
                                    100
                                ? 100
                                : currentGoal.multiplier +
                                    5 -
                                    _currentSliderValue.round() * 2,
                            progress: currentGoal.progress - 1 < 0 ? 0 : currentGoal.progress - 1));
                      }
                      await DBHelper().insertWorkout(Workout(
                          //goalId: currentGoal != null ? currentGoal.goalId : 0,
                          muscleGroup: 0,
                          difficultyLevel: currentGoal != null
                              ? currentGoal.difficultyLevel
                              : 0,
                          workoutDate: DateTime.now().toIso8601String(),
                          workoutDuration: 0));
                    }
                    int count = 0;
                    Navigator.popUntil(context, (route) {
                      return count++ == 4;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                    );
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  )),
            ],
          ),
        ));
  }
}
