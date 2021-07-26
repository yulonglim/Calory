import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/HomePage.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/database/goal.dart';
import 'package:flutter_app/elements/goal_card.dart';
import 'package:flutter_app/main.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int? goalNumber = 0;
  int progress = 0;
  final goalListKey = GlobalKey<AnimatedListState>();
  late List<Goal> goalList;

  @override
  void initState() {
    super.initState();
    DBHelper().getGoals().then((value) => value.isEmpty
        ? setState(() {
            this.goalList = [];
          })
        : setState(() {
            this.goalNumber = value.length;
            this.progress = value.last.progress;
            this.goalList = [];
            this.goalList = value;
          }));
  }

  @override
  Widget build(BuildContext context) {
    this.goalList.length == 0 ? goalList = [] : goalList = goalList;
    for (int i = 0; i < goalList.length / 2.ceil(); i++) {
      Goal temp = goalList[i];
      goalList[i] = goalList[goalList.length - 1];
      goalList[goalList.length - 1] = temp;
    }

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
            Text(
              "History",
              style: Theme.of(context).textTheme.headline5,
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Goals Finished:",
                    style: Theme.of(context).textTheme.bodyText2),
                Text(
                  progress == 0
                      ? goalNumber.toString()
                      : (goalNumber! - 1).toString(),
                  style: Theme.of(context).textTheme.bodyText2!.merge(TextStyle(
                        color: Colors.grey[600],
                      )),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: AnimatedList(
                key: goalListKey,
                initialItemCount: goalList.length,
                itemBuilder: (context, index, animation) => GoalCard(
                  item: goalList[index],
                  animation: animation,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).primaryColor,
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(8),
                title: new InkWell(
                  onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('Clear Data?',
                          style: Theme.of(context).textTheme.bodyText1),
                      content: Text(
                          'This will clear all data from the application. Continue?',
                          style: Theme.of(context).textTheme.bodyText2),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Back'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await DBHelper().deleteAll();
                            await DBHelper().deleteAllWorkOuts();
                            clearWorkOutData();
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Homepage()),
                            );
                          },
                          child: const Text('Clear'),
                        ),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          'Clear All Data',
                          style: Theme.of(context).textTheme.bodyText1!.merge(
                              TextStyle(
                                  color:
                                      Theme.of(context).secondaryHeaderColor)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //)
          ],
        ),
      ),
    );
  }
}
