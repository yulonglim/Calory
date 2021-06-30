import 'package:flutter/material.dart';
import 'package:flutter_app/HomePage.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/database/exercise_data.dart';

void main() => runApp(MyApp());

late List<exerciseData> workoutData = [];
late DateTime? tempDate;

void clearWorkOutData() {
  workoutData = [];
}

void setWorkOutData(List<exerciseData> list) async {
  await DBHelper().getWorkOut().then((value) => value.isNotEmpty
      ? tempDate = DateTime.parse(value.first.workoutDate)
      : null);
  if (workoutData.isEmpty ||
      tempDate == null ||
      DateTime.now().day != tempDate!.day) {
    workoutData = list;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        //fontFamily: "Cairo",
        primaryColor: Color.fromRGBO(184, 15, 10, 1),
        secondaryHeaderColor: Color.fromRGBO(243, 240, 240, 1),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
          primaryColor: Colors.grey[800],
          secondaryHeaderColor: Colors.blueGrey[400],
          brightness: Brightness.dark),
      themeMode: ThemeMode.light,
      home: Homepage(),
    );
  }
}
