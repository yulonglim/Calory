import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/Testing/TestingPage3.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/database/goal.dart';
import "package:flutter_app/elements/today's_workout_widget.dart";

class TestPage2 extends StatefulWidget {
  const TestPage2({Key? key}) : super(key: key);

  @override
  _TestPage2State createState() => _TestPage2State();
}

class _TestPage2State extends State<TestPage2> {
  bool refresh = false;
  Goal test = Goal(
      goal: 0,
      difficultyLevel: 0,
      startDate: DateTime.now().toIso8601String(),
      endDate: DateTime.now().toIso8601String(),
      multiplier: 20,
      progress: 5,
      daysAWeek: 5);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DBHelper().insertGoal(test).then((value) => setState(() {
      this.refresh = true;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TodayWorkOut(test: true,),
          SizedBox(
            child: Text('Test with a goal planned + not completed'),
          ),
          SizedBox(
            height: 4,
          ),
          SizedBox(
            child: Text('The widget should be showing goal set, difficulty easy, pressing end workout will bring u back to this page. \nWhen end workout is clicked recalibration should occur use back button to come back'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.24,
              child: Column(
                children: [
                  Icon(
                    Icons.done,
                    size: 48,
                  ),
                  Column(
                    children: [
                      Text(
                        'Passed',
                        style: Theme.of(context).textTheme.bodyText1!
                            .merge(TextStyle(color: Theme.of(context).secondaryHeaderColor)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onPressed: () {
              DBHelper().deleteAll().whenComplete(() => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TestPage3())));

            },
          ),
        ],
      ),
    );
  }
}