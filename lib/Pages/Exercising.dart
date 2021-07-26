import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/database/exercise_data.dart';
import 'package:flutter_app/elements/exercise_card.dart';
import 'package:flutter_beep/flutter_beep.dart';

class exercising extends StatefulWidget {
  final List<exerciseData> items;
  final int rest;

  exercising({Key? key, required this.items, required this.rest})
      : super(key: key);

  @override
  _exercisingState createState() => _exercisingState(this.items, this.rest);
}

class _exercisingState extends State<exercising> {
  CountDownController _controller = new CountDownController();
  final listKey = GlobalKey<AnimatedListState>();
  final listKey2 = GlobalKey<AnimatedListState>();
  final List<exerciseData> items;
  final int rest;
  List<exerciseData> temp = <exerciseData>[];

  void removeItem(int index) {
    final removedItem = temp[index];
    temp.removeAt(index);
    listKey.currentState!.removeItem(
        index,
        (context, animation) => ExerciseCard(
              item: removedItem,
              animation: animation,
              onClicked: () {},
            ));
    listKey2.currentState!.removeItem(
        index,
        (context, animation) => ExerciseCard(
              item: removedItem,
              animation: animation,
              onClicked: () {},
            ));
  }

  _exercisingState(this.items, this.rest) {
    int count2 = 0;
    if (this.rest == 0) {
      while (count2 < items.length) {
        this.temp.add(this.items[count2]);
        this.temp.add(exerciseData(
            exerciseId: 'R',
            exerciseTime: rest,
            exerciseName: 'Rest',
            exerciseDescription:
                'Prepare for the next exercise or do some light stretching'));
        count2++;
      }
    } else {
      this.temp.addAll(this.items);
    }
  }

  @override
  Widget build(BuildContext context) {
    int count = 0;
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
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.14,
            child: AnimatedList(
              physics: NeverScrollableScrollPhysics(),
              key: listKey,
              initialItemCount: temp.length,
              itemBuilder: (context, index, animation) => ExerciseCard(
                item: temp[index],
                animation: animation,
                onClicked: () => removeItem(index),
              ),
            ),
          ),
          Center(
            child: CircularCountDownTimer(
              duration: temp[0].exerciseTime,
              initialDuration: 0,
              controller: _controller,
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.45,
              ringColor: Theme.of(context).secondaryHeaderColor,
              ringGradient: null,
              fillColor: Theme.of(context).primaryColor,
              fillGradient: null,
              backgroundColor: Theme.of(context).primaryColor,
              backgroundGradient: null,
              strokeWidth: 40.0,
              strokeCap: StrokeCap.round,
              textStyle: TextStyle(
                  fontSize: 56.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textFormat: CountdownTextFormat.S,
              isReverse: true,
              isReverseAnimation: false,
              isTimerTextShown: true,
              autoStart: true,
              onComplete: () {
                if (temp.length == 1) {
                  Navigator.of(context).popUntil((route) => count++ == 1);
                } else {
                  FlutterBeep.beep();
                  removeItem(0);
                  _controller.restart(
                    duration: temp[0].exerciseTime,
                  );

                }
              },
            ),
          ),
          Text(
            'Next Exercise:',
            style:Theme.of(context).textTheme.headline5
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.14,
            child: AnimatedList(
              physics: NeverScrollableScrollPhysics(),
              key: listKey2,
              initialItemCount: temp.length - 1,
              itemBuilder: (context, index, animation) => ExerciseCard(
                item: temp[index + 1],
                animation: animation,
                onClicked: () => removeItem(index),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 32,
          ),
          _button(title: "Pause", onPressed: () {
            _controller.pause();
          }),
          SizedBox(
            width: 8,
          ),
          _button(title: "Resume", onPressed: () => _controller.resume()),
        ],
      ),
    );
  }

  _button({required String title, VoidCallback? onPressed}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.40,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline5!
              .merge(TextStyle(color: Theme.of(context).secondaryHeaderColor)),
        ),
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
