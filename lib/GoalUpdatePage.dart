import 'package:flutter/material.dart';
import 'package:flutter_app/HomePage.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/database/goal.dart';
import 'package:flutter_app/elements/dateselector.dart';
import 'package:flutter_app/elements/image_banner.dart';

import 'package:flutter_app/elements/toggle_button.dart';

class GoalUpdatePage extends StatefulWidget {
  @override
  _GoalUpdatePageState createState() => _GoalUpdatePageState();
}

class _GoalUpdatePageState extends State<GoalUpdatePage> {
  late int goal = 0;

  late int difficultyLevel = 0;

  late String endDate = DateTime.now().toIso8601String();

  final int progress = 0;

  late Goal currentGoal;

  var _currentSliderValue = 1;

  int daysAWeek = 1;

  @override
  Widget build(BuildContext context) {
    int count = 0;
    DBHelper()
        .getGoals()
        .then((value) => value.isNotEmpty ? currentGoal = value.first : null);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        body: Column(
          children: [
            //ImageBanner("assets/images/reach_goal.jpg"),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Update Your Goal',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('What is your Goal?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                child: MyToggleButtons('Weight Loss', 'Strength', 'Endurance',
                    (x) => this.goal = x)),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Difficulty Level',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                child: MyToggleButtons(
                    'Easy', 'Medium', 'Hard', (x) => this.difficultyLevel = x)),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('When will you reach your goal?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                child: DateSelector((x) => this.endDate = x)),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('How many days a week would you like to exercise?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ),
            Slider(
                value: _currentSliderValue.toDouble(),
                min: 1,
                max: 6,
                divisions: 6,
                label: _currentSliderValue.round().toString() + " Days",
                onChanged: (double value) {
                  setState(() {
                    this.daysAWeek = value.round();
                    _currentSliderValue = value.round();
                  });
                }),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.92,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () async {
                    await DBHelper().updateGoal(Goal(
                        goalId: currentGoal.goalId,
                        goal: goal,
                        difficultyLevel: difficultyLevel,
                        startDate: currentGoal.startDate,
                        endDate: endDate,
                        multiplier: 20 + difficultyLevel * 20,
                        progress: ((DateTime.parse(endDate)
                                    .difference(DateTime.parse(currentGoal.startDate))
                                    .inDays) /
                                7 *
                                _currentSliderValue)
                            .round()));
                    //This is to refresh the homepage with the new goal data
                    Navigator.popUntil(context, (route) {
                      return count++ == 2;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                    );
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
            ),
          ],
        ));
  }
}
