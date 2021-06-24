import 'package:flutter/material.dart';
import 'package:flutter_app/elements/toggle_button.dart';

import 'FullWorkoutPage.dart';

class OneTimeWorkOut extends StatefulWidget {
  const OneTimeWorkOut({Key? key}) : super(key: key);

  @override
  _OneTimeWorkOutState createState() => _OneTimeWorkOutState();
}

class _OneTimeWorkOutState extends State<OneTimeWorkOut> {
  double _currentSliderValue = 0;
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Choose a workout',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Which Muscle Group would u like to train?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                child: MyToggleButtons('Upper Body', 'Lower Body', 'Core',(x)=> 0)),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Difficulty Level',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                child: MyToggleButtons('Easy', 'Medium', 'Hard',(x)=> 0)),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('How long would you like to exercise?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ),
            Slider(
                value: _currentSliderValue,
                min: 0,
                max: 60,
                divisions: 4,
                label: _currentSliderValue.round().toString() + " Mins",
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                }),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FullWorkoutPage(workoutItems: [],)),
                  );
                },
                child: Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                )),
          ],
        ));
  }
}
