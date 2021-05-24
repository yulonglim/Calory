import 'package:flutter/material.dart';

class MainWorkOutPage extends StatefulWidget {
  @override
  _MainWorkOutPageState createState() => _MainWorkOutPageState();
}

class _MainWorkOutPageState extends State<MainWorkOutPage> {
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
          "Main Workout",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
