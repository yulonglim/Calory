import 'package:flutter/material.dart';
import 'package:flutter_app/HomePage.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int? goalID = 0;
  int progress = 0;

  @override
  void initState() {
    super.initState();
    DBHelper().getGoals().then((value) => value.isEmpty
        ? null
        : setState(() {
            this.goalID = value.first.goalId;
            this.progress = value.first.progress;
          }));
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
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 20, right: 16),
        child: ListView(
          children: [
            Text(
              "Settings",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Account",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Goals Finished:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  progress == 0 ? goalID.toString() : (goalID!-1).toString() ,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
           Container(
             margin: EdgeInsets.all(4),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(8),
               color: Theme.of(context).primaryColor,
             ),
             child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: new InkWell(
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text('Clear Data?',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500)),
                        content: Text(
                            'This will clear all data from the application. Continue?',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Back'),
                          ),
                          TextButton(
                            onPressed: () async {
                              int? currentID = 0;
                              await DBHelper().getGoals().then((value) =>
                                  currentID =
                                      value.isNotEmpty ? value.first.goalId : 0);
                              await DBHelper().deleteGoal(currentID!);
                              await DBHelper().deleteAllWorkOuts();
                              clearWorkOutData();
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Homepage()),);
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
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          'Clear All Data',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: Theme.of(context).secondaryHeaderColor),
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
