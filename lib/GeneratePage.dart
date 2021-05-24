import 'package:flutter/material.dart';
import 'package:flutter_app/elements/toggle_button.dart';

class GeneratePage extends StatelessWidget {
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
        body: Container(
        padding: EdgeInsets.only(left: 16, top: 20, right: 16),
        child: ListView(
          children: [
            //ImageBanner(),
            Text(
                'Set Your Goal',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)
            ),

            Divider(
              height: 15,
              thickness: 2,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'What is your Goal?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
              ),
            ),

            MyToggleButtons('Weight Loss', 'Strength', 'Endurance'),
          ],
        ),
      )
    );
  }
}

