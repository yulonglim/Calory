import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './WorkoutPage.dart';
import './GeneratePage.dart';
import './PlannerPage.dart';
import './ProgressPage.dart';

class Homepage extends StatelessWidget {

  String dateTime() {
    String Day;
    String Month = DateFormat.MMMM().format(DateTime.now());
    String Year = DateTime.now().year.toString();

    if (DateTime.now().day == 11 ||
        DateTime.now().day == 12 ||
        DateTime.now().day == 13) {
      Day = DateTime.now().day.toString() + "th";
    } else if (DateTime.now().day % 10 == 1) {
      Day = DateTime.now().day.toString() + "st";
    } else if (DateTime.now().day % 10 == 2) {
      Day = DateTime.now().day.toString() + "nd";
    } else if (DateTime.now().day % 10 == 3) {
      Day = DateTime.now().day.toString() + "rd";
    } else {
      Day = DateTime.now().day.toString() + "th";
    }

    return Day + " " + Month + " " + Year;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Calory",
            style: TextStyle(fontSize: 30),
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
                    fontSize: 50,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor.withAlpha(600),
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                children: [
                  Text(
                    "Today's Workout",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 40,
                    ),
                  ),
                  Container(

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.accessibility_new_sharp,
                        size: 50,
                        color: Theme.of(context).primaryColor,
                      ),
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
                            'Adjust',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              //buttons
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.accessibility_new_sharp,
                          size: 50,
                        ),
                        Column(
                          children: [
                            Text(
                              'Start a',
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ),
                            Text(
                              'Workout',
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PlannerPage()),
                      );
                    },
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.settings,
                          size: 50,
                        ),
                        Column(
                          children: [
                            Text(
                              'Generate',
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ),
                            Text(
                              'Workout',
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GeneratePage()),
                      );
                    },
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,

                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 50,
                        ),
                        Column(
                          children: [
                            Text(
                              'View',
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ),
                            Text(
                              'Progress',
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProgressPage()),
                      );
                    },
                  ),
                ),
              ],
            ), //the buttons
          ],
        ));
  }
}
