import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AppData/warm_up_data.dart';
import 'package:flutter_app/EndWorkOutPage.dart';
import 'package:flutter_app/elements/exercise_card.dart';

import 'CoolDownPage.dart';
import 'WorkOutPage.dart';
import 'WarmUpPage.dart';
import 'elements/card_button.dart';

class FullWorkoutPage extends StatelessWidget {
  final List<ExerciseItem> items = List.from(warmUpData);
  String durationMMSS(int duration) {
    int mins = 0;
    int temp = duration;
    while (temp > 0) {
      temp -= 60;
      mins++;
    }
    return mins.toString() + 'm ' + temp.toString() + 's';
  }

  String warmUpduration() {
    int duration = 0;
    for (int counter = 0; counter < items.length; counter++) {
      duration += items[counter].value;
    }
    return durationMMSS(duration);
  }

  @override
  Widget build(BuildContext context) {
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
                nextPage: WorkOutPage(),
                duration: warmUpduration(),
              ),
              CardButton(
                iconData: Icons.ac_unit_outlined,
                buttonName: "Cool Down",
                nextPage: CoolDownPage(),
                duration: warmUpduration(),
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
