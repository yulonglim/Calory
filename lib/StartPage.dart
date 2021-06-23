import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/HomePage.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/database/exercise_data.dart';

class StartPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        body: Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () async {
                await DBHelper().insertUpperBodyData(upperBodyData);
                //Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Homepage()),
                );
              },
              child: Text(
                'Begin',
                style: TextStyle(
                  fontSize: 30,
                ),
              )
          ),
        )
    );
  }

}