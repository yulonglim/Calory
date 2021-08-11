import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/database/exercise_data.dart';
import 'package:flutter_app/elements/exercise_card.dart';

class LibraryPage extends StatefulWidget {
  final List<ExerciseData> upperBody;
  final List<ExerciseData> lowerBody;
  final List<ExerciseData> core;
  LibraryPage(
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
  List<bool> _isOpen = [false, false, false];
  final List<ExerciseData> upperBody;
  final List<ExerciseData> lowerBody;
  final List<ExerciseData> core;
  final coreListKey = new GlobalKey<AnimatedListState>();
  final uBodyListKey = new GlobalKey<AnimatedListState>();
  final lBodyListKey = new GlobalKey<AnimatedListState>();

  _LibraryPageState(this.upperBody, this.lowerBody, this.core);

  void removeItem(int index, GlobalKey<AnimatedListState> key,
      List<ExerciseData> exercise) {
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
        title: Text("Exercise Library",
            style: Theme.of(context).textTheme.headline5),
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: ListView(children: [
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _isOpen[index] = !_isOpen[index];
              });
            },
            dividerColor: Theme.of(context).secondaryHeaderColor,
            children: [
              ExpansionPanel(
                  canTapOnHeader: true,
                  headerBuilder: (context, isOpen) {
                    return Text(
                      "Core",
                      style: Theme.of(context).textTheme.headline5,
                    );
                  },
                  body: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: AnimatedList(
                      initialItemCount: core.length,
                      itemBuilder: (context, index, animation) => ExerciseCard(
                        item: core[index],
                        animation: animation,
                        onClicked: () => removeItem(index, coreListKey, core),
                      ),
                    ),
                  ),
                  isExpanded: _isOpen[0]),
              ExpansionPanel(
                  canTapOnHeader: true,
                  headerBuilder: (context, isOpen) {
                    return Text(
                      "Upper Body",
                      style: Theme.of(context).textTheme.headline5,
                    );
                  },
                  body: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: AnimatedList(
                      initialItemCount: upperBody.length,
                      itemBuilder: (context, index, animation) => ExerciseCard(
                        item: upperBody[index],
                        animation: animation,
                        onClicked: () => removeItem(index, uBodyListKey, core),
                      ),
                    ),
                  ),
                  isExpanded: _isOpen[1]),
              ExpansionPanel(
                  canTapOnHeader: true,
                  headerBuilder: (context, isOpen) {
                    return Text(
                      "Lower Body",
                      style: Theme.of(context).textTheme.headline5,
                    );
                  },
                  body: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: AnimatedList(
                      initialItemCount: lowerBody.length,
                      itemBuilder: (context, index, animation) => ExerciseCard(
                        item: lowerBody[index],
                        animation: animation,
                        onClicked: () => removeItem(index, lBodyListKey, core),
                      ),
                    ),
                  ),
                  isExpanded: _isOpen[2]),
            ],
          ),
        ]),
      ),
    );
  }
}
