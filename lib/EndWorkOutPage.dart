import 'package:flutter/material.dart';


class EndWorkOutPage extends StatefulWidget {
  const EndWorkOutPage({Key? key}) : super(key: key);

  @override
   EndWorkOutPageState createState() =>  EndWorkOutPageState();
}

class  EndWorkOutPageState extends State<EndWorkOutPage> {
  double _currentSliderValue = 0;

  String? feedback(i)  {
    switch (i.round()) {
      case 0: {
        return 'Too Easy';
      }
      case 1: {
        return 'Easy';
      }
      case 2: {
        return 'Manageable';
      }
      case 3: {
        return 'Difficult';
      }
      case 4: {
        return 'Too Difficult';
      }
    }
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
                  label: feedback(_currentSliderValue),
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
                    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
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