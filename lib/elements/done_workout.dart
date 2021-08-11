import 'package:flutter/material.dart';
import 'package:flutter_app/Functions.dart';
import 'package:flutter_app/database/exercise_data.dart';
import 'package:flutter_app/elements/rectangle_display.dart';
import 'package:flutter_app/Pages/FullWorkoutPage.dart';


class DoneWorkout extends StatelessWidget {
  final List<ExerciseData> previousList;
  DoneWorkout(this.previousList);

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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
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
                      RectangleDisplay('Duration: ' + Functions().totalDuration(previousList)),
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
                                    workoutItems: previousList,
                                    oneTime: false,
                                  )),
                        );
                      },
                      child: Text(
                        'Check out what you did!',
                        style: Theme.of(context).textTheme.bodyText1!.merge(
                            TextStyle(
                                color: Theme.of(context).secondaryHeaderColor))
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
