import 'package:flutter/material.dart';
import 'package:flutter_app/Functions.dart';
import 'package:flutter_app/Pages/HomePage.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/database/goal.dart';
import 'package:flutter_app/database/workout.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

class EndWorkOutPage extends StatefulWidget {
  const EndWorkOutPage({Key? key}) : super(key: key);

  @override
  EndWorkOutPageState createState() => EndWorkOutPageState();
}

void initializeSetting() async {
  var initializeAndroid = AndroidInitializationSettings('app_logo');
  var initializeSetting = InitializationSettings(android: initializeAndroid);
  await notificationsPlugin.initialize(initializeSetting);
}

class EndWorkOutPageState extends State<EndWorkOutPage> {
  double _currentSliderValue = 2;



  Future<void> displayNotification(DateTime dateTime) async {
    notificationsPlugin.zonedSchedule(
        0,
        'ExerciseLah!',
        'It has been 3 days since your last workout! Come back and sweat it out!',
        tz.TZDateTime.from(dateTime, tz.local),
        NotificationDetails(
          android: AndroidNotificationDetails(
            'channel id',
            'channel name',
            'channel description',
            priority: Priority.high,
            importance: Importance.max,
            showWhen: true,
            fullScreenIntent: true,
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  @override
  void initState() {
    initializeSetting();
    tz.initializeTimeZones();
    super.initState();
  }

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please Rate Today's Workout",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: 4,
                  divisions: 4,
                  label: Functions().feedbackToString(_currentSliderValue),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  }),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () async {
                    dynamic currentGoal;
                    dynamic workout;
                    int duration = 0;
                    String workoutList = '';
                    await DBHelper().getGoals().then((value) =>
                        value.isNotEmpty ? currentGoal = value.first : null);
                    await DBHelper().getWorkOut().then((value) =>
                        value.isNotEmpty ? workout = value.first : null);
                    if (workout == null ||
                        DateTime.parse(workout.workoutDate).day !=
                            DateTime.now().day) {
                      if (currentGoal != null) {
                        await DBHelper().updateGoal(Goal(
                            goalId: currentGoal.goalId,
                            goal: currentGoal.goal,
                            difficultyLevel: currentGoal.multiplier +
                                        5 -
                                        _currentSliderValue.round() * 2 >
                                    60
                                ? 2
                                : currentGoal.multiplier +
                                            5 -
                                            _currentSliderValue.round() * 2 >
                                        40
                                    ? 1
                                    : 0,
                            startDate: currentGoal.startDate,
                            endDate: currentGoal.endDate,
                            multiplier: currentGoal.multiplier +
                                        5 -
                                        _currentSliderValue.round() * 2 >=
                                    100
                                ? 100
                                : currentGoal.multiplier +
                                    5 -
                                    _currentSliderValue.round() * 2,
                            progress: currentGoal.progress - 1 < 0
                                ? 0
                                : currentGoal.progress - 1));
                      }
                      for (int i = 0; i < workoutData.length; i++) {
                        duration += workoutData[i].exerciseTime;
                        if (workoutData[i].exerciseName != 'Rest') {
                          workoutList =
                              workoutList + '\n' + workoutData[i].exerciseName;
                        }
                      }
                      await DBHelper().insertWorkout(Workout(
                          muscleGroup: 3,
                          difficultyLevel: currentGoal != null
                              ? currentGoal.difficultyLevel
                              : 0,
                          workoutDate: DateTime.now().toIso8601String(),
                          workoutDuration: duration,
                          workoutList: workoutList,
                          multiplier: currentGoal.multiplier));
                    }
                    notificationsPlugin.cancelAll();
                    displayNotification(DateTime.now().add(Duration(days: 3)));
                    int count = 0;
                    Navigator.popUntil(context, (route) {
                      return count++ == 4;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                    );
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  )),
            ],
          ),
        ));
  }
}
