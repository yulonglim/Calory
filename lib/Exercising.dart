import 'package:flutter/material.dart';
import 'package:flutter_app/elements/exercise_card.dart';

class exercising extends StatefulWidget {
  final List<ExerciseItem> items;
  final int? rest;
  const exercising({Key? key, required this.items, this.rest})
      : super(key: key);

  @override
  _exercisingState createState() => _exercisingState();
}

class _exercisingState extends State<exercising> {
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
      ),
    );
  }
}
