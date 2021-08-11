import 'package:flutter/material.dart';
import 'package:flutter_app/Functions.dart';
import 'package:flutter_app/Pages/Exercising.dart';
import 'package:flutter_app/database/exercise_data.dart';
import 'package:flutter_app/elements/exercise_card.dart';

class WorkOutPage extends StatefulWidget {
  final List<ExerciseData> items;

  WorkOutPage({Key? key, required this.items}) : super(key: key);

  @override
  _WorkOutPageState createState() => _WorkOutPageState(this.items);
}

class _WorkOutPageState extends State<WorkOutPage> {
  final listKey = GlobalKey<AnimatedListState>();
  final List<ExerciseData> items;
  int restDuration = 5;

  _WorkOutPageState(this.items);

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
    List<ExerciseData> copyItems = <ExerciseData>[];
    for (int i = 0; i < items.length; i++) {
      copyItems.add(items[i]);
      if(items[i].exerciseName != 'Rest' && (i+1 == items.length ? false : items[i+1].exerciseName != 'Rest')){
        copyItems.add(
          ExerciseData(
              exerciseId: 'R1',
              exerciseTime: restDuration,
              exerciseName: 'Rest',
              exerciseDescription:
              'Use this time to prepare for the next exercise or to shake off any tension.'),
        );
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
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
        title: Text(
          "Work Out",
          style: Theme.of(context).textTheme.headline5!
              .merge(TextStyle(color: Colors.black)),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.16,
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    // height: MediaQuery.of(context).size.height * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'No. of exercises:',
                            style: Theme.of(context).textTheme.bodyText1!
                                .merge(TextStyle(color: Theme.of(context).secondaryHeaderColor)),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            items.length.toString(),
                            style: Theme.of(context).textTheme.headline5!
                                .merge(TextStyle(color: Theme.of(context).secondaryHeaderColor)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    // height: MediaQuery.of(context).size.width * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Duration:',
                            style: Theme.of(context).textTheme.bodyText1!
                                .merge(TextStyle(color: Theme.of(context).secondaryHeaderColor)),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            Functions().totalDuration(items),
                            style: Theme.of(context).textTheme.headline5!
                                .merge(TextStyle(color: Theme.of(context).secondaryHeaderColor)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: AnimatedList(
              shrinkWrap: true,
              key: listKey,
              initialItemCount: items.length,
              itemBuilder: (context, index, animation) => ExerciseCard(
                item: items[index],
                animation: animation,
                onClicked: () => removeItem(index),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: new InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Exercising(items: copyItems, rest: restDuration)),
                );
              },
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).primaryColor,
                ),
                child: Center(
                  child: Text(
                    'Start',
                    style: Theme.of(context).textTheme.headline5!
                        .merge(TextStyle(color: Theme.of(context).secondaryHeaderColor)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
