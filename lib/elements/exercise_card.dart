import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/database/exercise_data.dart';

class ExerciseCard extends StatelessWidget {
  final exerciseData item;
  final Animation<double> animation;
  final VoidCallback onClicked;

  ExerciseCard(
      {Key? key,
      required this.item,
      required this.animation,
      required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item.exerciseValue == null) {
      return SizeTransition(
        sizeFactor: animation,
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).primaryColor,
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            title: new InkWell(
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(item.exerciseName,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                  content: Text(item.exerciseDescription,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
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
                      item.exerciseName,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Text(
                    item.exerciseTime.toString() + 's',
                    style: TextStyle(
                        fontSize: 32,
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ],
              ),
            ),
            //
          ),
        ),
      );
    } else {
      return SizeTransition(
        sizeFactor: animation,
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).primaryColor,
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            title: new InkWell(
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(item.exerciseName,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                  content: Text(item.exerciseDescription.split('. ').join('.\n\n'),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
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
                      item.exerciseName,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Text(
                    'x' + item.exerciseValue.toString(),
                    style: TextStyle(
                        fontSize: 32,
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ],
              ),
            ),
            // trailing: ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     primary: Theme.of(context).secondaryHeaderColor,
            //   ),
            //   child: Text(
            //     'Done',
            //     style: TextStyle(
            //         fontSize: 24, color: Theme.of(context).primaryColor),
            //   ),
            //   onPressed: onClicked,
            // )
          ),
        ),
      );
    }
  }
}
