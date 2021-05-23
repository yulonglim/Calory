import 'package:flutter/material.dart';
import 'package:flutter_app/elements/rectangle_display.dart';
import 'package:flutter_app/elements/square_button.dart';
import 'package:intl/intl.dart';

import './WorkoutPage.dart';
import './GeneratePage.dart';
import './PlannerPage.dart';
import './ProgressPage.dart';

class Homepage extends StatelessWidget {
  String dateTime() {
    String day;
    String month = DateFormat.MMMM().format(DateTime.now());
    String year = DateTime.now().year.toString();

    if (DateTime.now().day == 11 ||
        DateTime.now().day == 12 ||
        DateTime.now().day == 13) {
      day = DateTime.now().day.toString() + "th";
    } else if (DateTime.now().day % 10 == 1) {
      day = DateTime.now().day.toString() + "st";
    } else if (DateTime.now().day % 10 == 2) {
      day = DateTime.now().day.toString() + "nd";
    } else if (DateTime.now().day % 10 == 3) {
      day = DateTime.now().day.toString() + "rd";
    } else {
      day = DateTime.now().day.toString() + "th";
    }

    return day + " " + month + " " + year;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Calory",
            style: TextStyle(fontSize: 32),
          ),
        ),
        body: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            Container(
              // Container for today's plan
              color: Theme.of(context).secondaryHeaderColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5,
              alignment: Alignment.centerLeft,
              child: Center(
                child: Text(
                  dateTime(),
                  style: TextStyle(
                    fontSize: 48,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),

            Padding(
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
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Today's Workout",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    Divider(
                      height: 16,
                      thickness: 2,
                      color: Theme.of(context).primaryColor.withAlpha(600),
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
                      padding: const EdgeInsets.all(4.0),
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
                                'Snooze',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              //buttons
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SquareButton(Icons.accessibility_new_sharp, 'Start a', 'Workout', PlannerPage()),
                SquareButton(Icons.settings, 'Generate', 'Workout', GeneratePage()),
                SquareButton(Icons.calendar_today_rounded, 'View', 'Progress', ProgressPage()),
              ],
            ), //the buttons
          ],
        ));
  }
}
