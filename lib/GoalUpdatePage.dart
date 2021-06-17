import 'package:flutter/material.dart';
import 'package:flutter_app/HomePage.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/database/goal.dart';
import 'package:flutter_app/elements/dateselector.dart';
import 'package:flutter_app/elements/image_banner.dart';

import 'package:flutter_app/elements/toggle_button.dart';

class GoalUpdatePage extends StatelessWidget {
  late int goal = 0;
  late int difficultyLevel = 0;
  final String startDate = DateTime.now().toIso8601String();
  late String endDate = DateTime.now().toIso8601String();
  final int multiplier = 1;
  final int progress = 0;
  int? currentId = 0;

  @override
  Widget build(BuildContext context) {
    int count = 0;
    DBHelper().getGoals().then((value) => currentId = value.first.goalId);
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
            ImageBanner("assets/images/reach_goal.jpg"),
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
              padding: const EdgeInsets.all(45.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    onPressed: () async {
                      await DBHelper().updateGoal(Goal(
                          goalId: this.currentId,
                          goal: goal,
                          difficultyLevel: difficultyLevel,
                          startDate: startDate,
                          endDate: endDate,
                          multiplier: multiplier,
                          progress: progress));
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
            ),
          ],
        ));
  }
}
