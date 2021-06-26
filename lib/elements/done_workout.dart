import 'package:flutter/material.dart';
import 'package:flutter_app/elements/rectangle_display.dart';
import 'package:flutter_app/FullWorkoutPage.dart';
import 'package:flutter_app/main.dart';

class doneWorkout extends StatelessWidget {
  final String duration;
  doneWorkout(this.duration);

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
                    Icons.thumb_up,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  Column(
                    children: [
                      RectangleDisplay('Completed'),
                      RectangleDisplay('Duration: '+ duration),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 16, 4, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullWorkoutPage(
                                    workoutItems: List.from(workoutData),
                                  )),
                        );
                      },
                      child: Text(
                        'Check out what you did!',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
