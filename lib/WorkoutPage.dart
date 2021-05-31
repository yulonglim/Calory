import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/EndWorkOutPage.dart';

import 'CoolDownPage.dart';
import 'MainWorkOutPage.dart';
import 'WarmUpPage.dart';
import 'elements/card_button.dart';

class WorkoutPage extends StatelessWidget {
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
              ),
              CardButton(
                iconData: Icons.sports_handball_outlined,
                buttonName: "Main Workout",
                nextPage: MainWorkOutPage(),
              ),
              CardButton(
                iconData: Icons.ac_unit_outlined,
                buttonName: "Cool Down",
                nextPage: CoolDownPage(),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EndWorkOutPage()),
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
