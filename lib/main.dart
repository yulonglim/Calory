import 'package:flutter/material.dart';
import './HomePage.dart';


void main() => runApp(MyApp());



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
        primaryColor:Color.fromRGBO(184, 15, 10, 1),
        secondaryHeaderColor: Colors.grey,
        brightness: Brightness.dark
      ),
      themeMode: ThemeMode.light ,
      home:
          Homepage(),
    );
  }
}

