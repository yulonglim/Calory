import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/elements/exercise_card.dart';

class exercising extends StatefulWidget {
  final List<ExerciseItem> items;
  final int? rest;

  exercising({Key? key, required this.items, this.rest}) : super(key: key);

  @override
  _exercisingState createState() => _exercisingState(this.items, this.rest);
}

class _exercisingState extends State<exercising> {
  CountDownController _controller = new CountDownController();
  final listKey = GlobalKey<AnimatedListState>();
  final List<ExerciseItem> items;
  final int? rest;
  List<ExerciseItem> temp = <ExerciseItem>[];

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
  }

  _exercisingState(List<ExerciseItem> items, this.rest) : items = items {
    if (this.rest != null) {
      int count2 = 0;
      while (count2 < items.length) {
        this.temp.add(this.items[count2]);
        this.temp.add(ExerciseItem('Rest', rest!, true, 'Prepare for the next exercise or do some light stretching'));
        count2 = count2 + 1;
      }
    } else {
      this.temp = this.items;
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
              duration: temp[0].durationBased ? temp[0].value : 60,
              initialDuration: 0,
              controller: _controller,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              ringColor: Theme.of(context).secondaryHeaderColor,
              ringGradient: null,
              fillColor: Theme.of(context).primaryColor,
              fillGradient: null,
              backgroundColor: Theme.of(context).primaryColor,
              backgroundGradient: null,
              strokeWidth: 20.0,
              strokeCap: StrokeCap.round,
              textStyle: TextStyle(
                  fontSize: 33.0,
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
                  removeItem(0);
                  _controller.restart(
                    duration: temp[0].durationBased ? temp[0].value : 60,
                  );
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 16,
          ),
          _button(title: "Pause", onPressed: () => _controller.pause()),
          SizedBox(
            width: 16,
          ),
          _button(title: "Resume", onPressed: () => _controller.resume()),
        ],
      ),
    );
  }

  _button({required String title, VoidCallback? onPressed}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton(
        child: Text(
          title,
          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
        ),
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
