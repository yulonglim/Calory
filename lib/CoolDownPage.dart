import 'package:flutter/material.dart';
import 'package:flutter_app/AppData/cool_down_data.dart';
import 'package:flutter_app/elements/exercise_card.dart';

class CoolDownPage extends StatefulWidget {
  @override
  _CoolDownPageState createState() => _CoolDownPageState();
}

class _CoolDownPageState extends State<CoolDownPage> {
  final listKey = GlobalKey<AnimatedListState>();
  final List<ExerciseItem> items = List.from(coolDownData);

  void removeItem(int index) {
    final removedItem = items[index];
    items.removeAt(index);
    listKey.currentState!.removeItem(
        index,
        (context, animation) => ExerciseCard(
              item: removedItem,
              animation: animation,
              onClicked: () {},
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
            "Cool Down",
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
