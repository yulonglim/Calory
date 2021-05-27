import 'package:flutter/material.dart';
import 'package:flutter_app/elements/rectangle_display.dart';

import '../WorkoutPage.dart';

class todays_workout extends StatelessWidget {

  bool planned = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor.withAlpha(600),
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Today's Workout",
                style: TextStyle(
                  //color: Theme.of(context).primaryColor,
                  fontSize: 40,
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.whatshot,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  Column(
                    children: [
                      RectangleDisplay('Difficulty: eg'),
                      RectangleDisplay('Duration: eg'),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 16, 4, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WorkoutPage()),
                        );
                      },
                      child: Text(
                        'Start',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Text(
                    'Snooze',
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).primaryColor),
                  ),
                  Switch(
                    value: false,
                    onChanged: null,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


