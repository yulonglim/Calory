import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/database/exercise_data.dart';
import 'package:flutter_app/elements/exercise_card.dart';

class LibraryPage extends StatefulWidget {
  final List<exerciseData> upperBody;
  final List<exerciseData> lowerBody;
  final List<exerciseData> core;
  const LibraryPage(
      {Key? key,
      required this.upperBody,
      required this.lowerBody,
      required this.core})
      : super(key: key);

  @override
  _LibraryPageState createState() =>
      _LibraryPageState(this.upperBody, this.lowerBody, this.core);
}

class _LibraryPageState extends State<LibraryPage> {
  final List<exerciseData> upperBody;
  final List<exerciseData> lowerBody;
  final List<exerciseData> core;
  final corelistKey = new GlobalKey<AnimatedListState>();
  final ubodylistKey = new GlobalKey<AnimatedListState>();
  final lbodylistKey = new GlobalKey<AnimatedListState>();

  _LibraryPageState(this.upperBody, this.lowerBody, this.core);

  void removeItem(int index, GlobalKey<AnimatedListState> key,
      List<exerciseData> exercise) {
    final removedItem = exercise[index];
    exercise.removeAt(index);
    key.currentState!.removeItem(
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        // title: Text(
        //   "Exercise Library",
        //   style: Theme.of(context).textTheme.headline5!.merge(
        //     TextStyle(color: Theme.of(context).primaryColor,)
        //   ),
        // ),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Exercise Library",
            style: Theme.of(context).textTheme.headline5,
          ),
          Divider(
            height: 10,
            thickness: 2,
          ),
          Text(
            "Core",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          Divider(
            height: 10,
            thickness: 2,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.22,
            child: AnimatedList(
              key: corelistKey,
              initialItemCount: core.length,
              itemBuilder: (context, index, animation) => ExerciseCard(
                item: core[index],
                animation: animation,
                onClicked: () => removeItem(index, corelistKey, core),
              ),
            ),
          ),
          Divider(
            height: 10,
            thickness: 2,
          ),
          Text(
            "Upper Body",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Divider(
            height: 10,
            thickness: 2,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.22,
            child: AnimatedList(
              key: ubodylistKey,
              initialItemCount: upperBody.length,
              itemBuilder: (context, index, animation) => ExerciseCard(
                item: upperBody[index],
                animation: animation,
                onClicked: () => removeItem(index, ubodylistKey, upperBody),
              ),
            ),
          ),
          Divider(
            height: 10,
            thickness: 2,
          ),
          Text(
            "Lower Body",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Divider(
            height: 10,
            thickness: 2,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.22,
            child: AnimatedList(
              key: lbodylistKey,
              initialItemCount: lowerBody.length,
              itemBuilder: (context, index, animation) => ExerciseCard(
                item: lowerBody[index],
                animation: animation,
                onClicked: () => removeItem(index, lbodylistKey, lowerBody),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
