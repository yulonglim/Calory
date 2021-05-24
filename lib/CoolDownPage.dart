import 'package:flutter/material.dart';

class CoolDownPage extends StatefulWidget {
  @override
  _CoolDownPageState createState() => _CoolDownPageState();
}

class _CoolDownPageState extends State<CoolDownPage> {
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
          "Cool Down",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
