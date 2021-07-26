import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/HomePage.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/database/exercise_data.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {

  runApp(MyApp());
}

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
        primaryColor: Color.fromRGBO(184, 15, 10, 1),
        secondaryHeaderColor: Color.fromRGBO(243, 240, 240, 1),
        brightness: Brightness.light,

        fontFamily: 'OpenSans',

        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 44.0, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 42.0, fontWeight: FontWeight.w600),
          headline3: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w600),
          headline4: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600),
          headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
          headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          bodyText1: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
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
