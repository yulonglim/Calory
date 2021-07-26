import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/HomePage.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/database/goal.dart';
import 'package:flutter_app/elements/dateselector.dart';
import 'package:flutter_app/elements/image_banner.dart';

import 'package:flutter_app/elements/toggle_button.dart';

class GoalSetPage extends StatefulWidget {
  @override
  _GoalSetPageState createState() => _GoalSetPageState();
}

class _GoalSetPageState extends State<GoalSetPage> {
  late int goal = 0;

  late int difficultyLevel = 0;

  final String startDate = DateTime.now().toIso8601String();

  late String endDate = DateTime.now().toIso8601String();

  final int multiplier = 20;

  final int progress = 0;

  int daysAWeek = 0;

  var _currentSliderValue = 1;

  @override
  Widget build(BuildContext context) {
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
              child: Text('Set Your Goal',
                style: Theme.of(context).textTheme.headline4!
                    .merge(TextStyle(color: Colors.black))
              )
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('What is your Goal?',
                  style: Theme.of(context).textTheme.headline6!
                      .merge(TextStyle(color: Colors.black))
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                child: MyToggleButtons('Weight Loss', 'Strength', 'Endurance',
                    (x) => this.goal = x)),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Difficulty Level',
                  style: Theme.of(context).textTheme.headline6!
                      .merge(TextStyle(color: Colors.black))
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                child: MyToggleButtons(
                    'Easy', 'Medium', 'Hard', (x) => this.difficultyLevel = x)),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('When will you reach your goal?',
                  style: Theme.of(context).textTheme.headline6!
                      .merge(TextStyle(color: Colors.black))
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                child: DateSelector((x) => this.endDate = x)),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('How many days a week would you like to exercise?',
                  style: Theme.of(context).textTheme.headline6!
                      .merge(TextStyle(color: Colors.black)),
                  textAlign: TextAlign.center,
              ),
            ),
            Slider(
                value: _currentSliderValue.toDouble(),
                min: 1,
                max: 6,
                divisions: 5,
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
                    await DBHelper().insertGoal(
                      Goal(
                        goal: goal,
                        difficultyLevel: difficultyLevel,
                        startDate: startDate,
                        endDate: endDate,
                        multiplier: multiplier + difficultyLevel * 20,
                        progress: ((DateTime.parse(endDate)
                                        .difference(DateTime.parse(startDate))
                                        .inDays +
                                    1) /
                                7 *
                                _currentSliderValue)
                            .round(),
                        daysAWeek: _currentSliderValue.round(),
                      ),
                    );
                    //This is to refresh the homepage with the new goal data
                    int count = 0;
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
                    style: Theme.of(context).textTheme.bodyText1!
                        .merge(TextStyle(color: Theme.of(context).secondaryHeaderColor))
                  )),
            )
          ],
        ));
  }
}
