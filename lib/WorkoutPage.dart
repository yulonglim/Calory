import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CoolDownPage.dart';
import 'MainWorkOutPage.dart';
import 'WarmUpPage.dart';

class WorkoutPage extends StatefulWidget {
  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
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
              Card(
                child: new InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WarmUpPage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Icon(
                            Icons.whatshot,
                            size: 80,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Warm Up",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: new InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainWorkOutPage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Icon(
                            Icons.sports_handball_outlined,
                            size: 80,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Main Workout",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: new InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CoolDownPage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Icon(
                            Icons.ac_unit_outlined,
                            size: 80,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Cool Down",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ])));
  }
}
