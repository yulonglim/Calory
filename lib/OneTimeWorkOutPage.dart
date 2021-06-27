import 'package:flutter/material.dart';
import 'package:flutter_app/database/exercise_data.dart';
import 'package:flutter_app/elements/toggle_button.dart';
import 'package:flutter_app/main.dart';

import 'FullWorkoutPage.dart';
import 'database/DBHelper.dart';

class OneTimeWorkOut extends StatefulWidget {
  const OneTimeWorkOut({Key? key}) : super(key: key);

  @override
  _OneTimeWorkOutState createState() => _OneTimeWorkOutState();
}

class _OneTimeWorkOutState extends State<OneTimeWorkOut> {
  double _currentSliderValue = 15;
  late int muscleGroup = 0;
  late int difficulty = 0;
  late int duration = 0;
  List<exerciseData> tempWorkOutItems = [];
  List<exerciseData> workOutItems = [];

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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Choose a workout',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Which Muscle Group would u like to train?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                child: MyToggleButtons('Upper Body', 'Lower Body', 'Core',
                    (x) => this.muscleGroup = x)),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Difficulty Level',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                child: MyToggleButtons(
                    'Easy', 'Medium', 'Hard', (x) => this.difficulty = x)),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('How long would you like to exercise?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ),
            Slider(
                value: _currentSliderValue,
                min: 15,
                max: 30,
                divisions: 3,
                label: _currentSliderValue.round().toString() + " Mins",
                onChanged: (double value) {
                  setState(() {
                    this.duration = value.round();
                    _currentSliderValue = value;
                  });
                }),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                onPressed: () async {
                  this.tempWorkOutItems = [];
                  await DBHelper()
                      .getExercisesMuscles(this.muscleGroup,((this._currentSliderValue)/5).round() - 1)
                      .then((workOutItems) => setState(() {
                            workOutItems.forEach((element) {
                              this.tempWorkOutItems.add(exerciseData(
                                  exerciseId: element.exerciseId,
                                  exerciseValue: element.exerciseValue != null
                                      ? (element.exerciseValue! *
                                              (this.difficulty + 1) /
                                              3)
                                          .round()
                                      : null,
                                  exerciseTime: element.exerciseTime,
                                  exerciseName: element.exerciseName,
                                  exerciseDescription:
                                      element.exerciseDescription));
                            });
                            setWorkOutData(tempWorkOutItems);
                            this.workOutItems = tempWorkOutItems;
                          }));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FullWorkoutPage(
                              workoutItems: this.workOutItems,
                            )),
                  );
                },
                child: Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                )),
          ],
        ));
  }
}
