import 'package:flutter/material.dart';
import 'package:flutter_app/elements/dateselector.dart';
import 'package:flutter_app/elements/image_banner.dart';
import 'package:flutter_app/elements/toggle_button.dart';

class GoalSetPage extends StatelessWidget {
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
        body: Container(
        padding: EdgeInsets.only(left: 16, top: 20, right: 16),
        child: ListView(
          children: [
            ImageBanner("assets/images/reach_goal.jpg"),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                  'Set Your Goal',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)
              ),
            ),

            Divider(
              height: 15,
              thickness: 2,
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                  'What is your Goal?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
              ),
            ),

            MyToggleButtons('Weight Loss', 'Strength', 'Endurance'),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                  'Difficulty Level',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
              ),
            ),

            MyToggleButtons('Easy', 'Medium', 'Hard'),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                  'When will you reach your goal?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
              ),
            ),

            DateSelector(),
          ],
        ),
      )
    );
  }
}

