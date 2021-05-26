import 'package:flutter/material.dart';
import 'package:flutter_app/elements/exercise_card.dart';
import 'elements/example_data.dart';

class WarmUpPage extends StatefulWidget {
  @override
  _WarmUpPageState createState() => _WarmUpPageState();
}

class _WarmUpPageState extends State<WarmUpPage> {
  final listKey = GlobalKey<AnimatedListState>();
  final List<ExerciseItem> items = List.from(exampleData);

  void removeItem(int index) {
    final removedItem = items[index];
    items.removeAt(index);
    listKey.currentState.removeItem(
        index,
        (context, animation) => ExerciseCard(
              item: removedItem,
              animation: animation,
            ));
  }

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
            "Warm Up",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
        body: AnimatedList(
          key: listKey,
          initialItemCount: items.length,
          itemBuilder: (context, index, animation) => ExerciseCard(
            item: items[index],
            animation: animation,
            onClicked: () => removeItem(index),
          ),
        ));
  }
}
